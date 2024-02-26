//
//  SearchViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, CodeBase {

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
    
    let searchResultLabel = UILabel()
    var filteredButton1 = UIButton()
    var filteredButton2 = UIButton()
    var filteredButton3 = UIButton()
    var filteredButton4 = UIButton()
    let productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    lazy var filteredButton: [UIButton] = [filteredButton1, filteredButton2, filteredButton3, filteredButton4]
    let productManager = ProductAPIManager()
    let udManager = UserDefaultManager.shared
    var start = 1
    var defaultButton: String = "sim"
    
    let viewModel = SearchViewModel()
    
    var product: ProductList = ProductList(total: 0, start: 1, display: 30, items: [])
    var items: [Product] = [] {
        didSet {
            productCollectionView.reloadData()
        }
    }
    
    func bindData() {
        viewModel.outputProductItems.bind { product in
            self.productCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultButton = "sim"
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.prefetchDataSource = self
                
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
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
        
        //viewModel.callRequest()
//        viewModel.inputViewDidLoad.value = ()
//        bindData()
//        viewModel.inputRecentSearches.value = udManager.recentSearches
//        searchResultLabel.text = viewModel.outputResultLabel.value
//        navigationItem.title = udManager.recentSearches
//       
        
        
        setAddView()
        configureLayout()
        configureAttribute()
        setCommonUI()
    }

    func setAddView() {
        view.addSubviews([searchResultLabel, productCollectionView, filteredButton1, filteredButton2, filteredButton3, filteredButton4])
    }
    
    func configureAttribute() {
        setButtons()
        
        searchResultLabel.text = "테스트드으으으"//"\(product.total) 개의 검색 결과"
        searchResultLabel.textColor = .customPointColor
        searchResultLabel.font = .BigBodyFont
        
        productCollectionView.backgroundColor = .customBackgroundColor
    }
    
    func configureLayout() {
        searchResultLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(view).offset(8)
            make.horizontalEdges.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        filteredButton1.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(8)
            make.top.equalTo(searchResultLabel.snp.bottom).offset(8)
        }
        
        filteredButton2.snp.makeConstraints { make in
            make.leading.equalTo(filteredButton1.snp.trailing).offset(4)
            make.top.equalTo(searchResultLabel.snp.bottom).offset(8)
        }
        
        filteredButton3.snp.makeConstraints { make in
            make.leading.equalTo(filteredButton2.snp.trailing).offset(4)
            make.top.equalTo(searchResultLabel.snp.bottom).offset(8)
        }
        
        filteredButton4.snp.makeConstraints { make in
            make.leading.equalTo(filteredButton3.snp.trailing).offset(4)
            make.top.equalTo(searchResultLabel.snp.bottom).offset(8)
        }
        
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filteredButton1.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func setButtons() {
        for idx in 0...filteredButton.count - 1 {
            filteredButton[idx].setTitle(buttonList.allCases[idx].rawValue, for: .normal)
            if defaultButton == SortedButton.allCases[idx].rawValue {
                filteredButton[idx].setTitleColor(.black, for: .normal)
                filteredButton[idx].backgroundColor = .white
            } else {
                filteredButton[idx].setTitleColor(.white, for: .normal)
                filteredButton[idx].backgroundColor = .black
            }
            filteredButton[idx].tag = idx
            filteredButton[idx].setfilteredButton()
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 4
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        let cellHeight = UIScreen.main.bounds.height - spacing * 2
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 3)
        layout.scrollDirection = .vertical
        
        return layout
    }
 
    //tag로 버튼 구분
    @IBAction func filteredButtonTapped(_ sender: UIButton) {
        udManager.selectedFilteredButton = sender.tag
        defaultButton = SortedButton.allCases[sender.tag].rawValue
        productManager.callRequest(text: udManager.recentSearches, start: 1, sort: defaultButton) { value in
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
        let vc = SearchDetailViewController()
        
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
                productManager.callRequest(text: udManager.recentSearches, start: start, sort: defaultButton) { value in
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
