//
//  SearchViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var filterdButton: [UIButton]!
    @IBOutlet var productCollectionView: UICollectionView!
    
    enum buttonList: String, CaseIterable {
        //TODO: button 글자 사이 inset 주기
        case accuracy = " 정확도 "
        case date = " 날짜순 "
        case highPrice = " 가격높은순 "
        case lowPrice = " 가격낮은순 "
    }
    
    enum SortedButton: String, CaseIterable {
        case sim
        case date
        case dsc //가격 높은 순
        case asc //가격 낮은 순
    }
    
    let productManager = ProductAPIManager()
    let udManager = UserDefaultManager.shared
    var start = 1
    var filtedButton: String = "sim"
    
    var product: ProductList = ProductList(total: 0, start: 1, display: 30, items: [])
    var items: [Product] = [] {
        didSet {
            productCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtedButton = "sim"
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.prefetchDataSource = self
                
        let xib = UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil)
        productCollectionView.register(xib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        let image = UIImage(systemName: "chevron.backward")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = button

        //MARK: 왜 self를 저기 앞에다 붙여주면 안써도 되는 것인가??
        productManager.callRequest(text: udManager.recentSearches, start: 1, sort: SortedButton.sim.rawValue) { [self] value in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(for: value.total)!
            searchResultLabel.text = "\(result)개의 검색 결과"
            navigationItem.title = udManager.recentSearches
            product = value
            items = product.items
        }
        
        setCommonUI()
        setUI()
        collectionViewLayout()
        setButtons()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func setButtons() {
        for idx in 0...filterdButton.count - 1 {
            filterdButton[idx].setTitle(buttonList.allCases[idx].rawValue, for: .normal)
            if filtedButton == SortedButton.allCases[idx].rawValue {
                filterdButton[idx].setTitleColor(.black, for: .normal)
                filterdButton[idx].backgroundColor = .white
            } else {
                filterdButton[idx].setTitleColor(.white, for: .normal)
                filterdButton[idx].backgroundColor = .black
            }
            filterdButton[idx].tag = idx
            filterdButton[idx].setfilteredButton()
        }
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 4
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        let cellHeight = UIScreen.main.bounds.height - spacing * 2
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 3)
        layout.scrollDirection = .vertical
        
        productCollectionView.collectionViewLayout = layout
    }
    
    func setUI() {
        searchResultLabel.text = "\(product.total) 개의 검색 결과"
        searchResultLabel.textColor = .customPointColor
        searchResultLabel.font = .BigBodyFont
    }
    
    //tag로 버튼 구분
    @IBAction func filteredButtonTapped(_ sender: UIButton) {
        udManager.selectedFilteredButton = sender.tag
        filtedButton = SortedButton.allCases[sender.tag].rawValue
        productManager.callRequest(text: udManager.recentSearches, start: 1, sort: filtedButton) { value in
            self.product = value
            self.items = self.product.items
        }
        productCollectionView.reloadData()
        setButtons()
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.likeButton.tag = Int(items[indexPath.item].productId)!
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: .touchUpInside)
        cell.configureCell(data: items[indexPath.item])
        
        if udManager.likeList.contains(items[indexPath.row].productId) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        let value = String(sender.tag)
        var tmpList = udManager.likeList
        if tmpList.contains(value) {
            let idx = tmpList.firstIndex(of: value)!
            tmpList.remove(at: idx)
            udManager.likeList = tmpList
        } else {
            tmpList.append(value)
            udManager.likeList = tmpList
        }
        print(udManager.likeList)
        productCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
        vc.productId = items[indexPath.item].productId
        
        var title = items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")        
        vc.productTitle = title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            if items.count - 2 == idx.item {
                start += 1
                productManager.callRequest(text: udManager.recentSearches, start: start, sort: filtedButton) { value in
                    self.items.append(contentsOf: value.items)
                }
            }
        }
        productCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===cancel===")
    }
}
