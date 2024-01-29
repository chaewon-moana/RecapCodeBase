//
//  MainViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import Alamofire
import SnapKit

class MainViewController: UIViewController, CodeBase {

    let searchBar = UISearchBar()
    let recentLabel = UILabel()
    let resetButton = UIButton()
    let recentTableView = UITableView()

//    @IBOutlet var searchBar: UISearchBar!
//    @IBOutlet var recentLabel: UILabel!
//    @IBOutlet var resetButton: UIButton!
//    @IBOutlet var recentTableView: UITableView!
//    @IBOutlet var backView: UIView!
    
    let udManager = UserDefaultManager.shared
    let productManager = ProductAPIManager()
    var data: ProductList = ProductList(total: 0, start: 0, display: 0, items: [])
    var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(udManager.recentSearchList)

        searchBar.delegate = self
        recentTableView.delegate = self
        recentTableView.dataSource = self
        recentTableView.separatorStyle = .none
        recentTableView.rowHeight = udManager.recentSearchList.isEmpty ? 500 : 40
        
        recentTableView.isScrollEnabled = udManager.recentSearchList.isEmpty ? false : true
        tabBarController?.tabBar.isHidden = false
        
        navigationItem.title = "\(udManager.nickname)의 새싹쇼핑"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
 
        
        let xib = UINib(nibName: RecentSearchesTableViewCell.identifier, bundle: nil)
        recentTableView.register(xib, forCellReuseIdentifier: RecentSearchesTableViewCell.identifier)
        
        let emptyXib = UINib(nibName: EmptyTableViewCell.identifier, bundle: nil)
        recentTableView.register(emptyXib, forCellReuseIdentifier: EmptyTableViewCell.identifier)
        
        setCommonUI()
        setSearchBarUI()
        setUI()
    }
    
    func setUI() {
        recentLabel.text = "최근 검색"
        recentLabel.textColor = .customTextColor
        recentLabel.font = .middleBodyFont
        
        resetButton.setTitle("모두 지우기", for: .normal)
        resetButton.setTitleColor(.customPointColor, for: .normal)
        resetButton.titleLabel?.font = .smallBodyFont
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        //TODO: userDefaults에서 recentSearchList 데이터 초기화
        udManager.recentSearchList = []
        recentTableView.reloadData()
    }
    
    func setAddView() {
        
    }
    
    func configureAttribute() {
        
    }
    
    func configureLayout() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return udManager.recentSearchList.isEmpty ? 1 : udManager.recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //MARK: cell과 emptyCell을 밖에다 선언하면 에러뜸,,휴
        if !udManager.recentSearchList.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchesTableViewCell.identifier, for: indexPath) as! RecentSearchesTableViewCell
            
            cell.selectionStyle = .none
            cell.searchesLabel.text = udManager.recentSearchList[indexPath.row]
            
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(cellDeleteButton(sender:)), for: .touchUpInside)
            backView.isHidden = false
            
            return cell
            
        } else {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
            
            emptyCell.selectionStyle = .none
            backView.isHidden = true
            return emptyCell
        }
        
    }
    
    @objc func cellDeleteButton(sender: UIButton) {
        print("\(sender.tag)지워짐요")
        var list = udManager.recentSearchList
        list.remove(at: sender.tag)
        udManager.recentSearchList = list
        recentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return udManager.recentSearchList.isEmpty ? 500 : 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        udManager.recentSearches = udManager.recentSearchList[indexPath.row]
        productManager.callRequest(text: udManager.recentSearches, start: 1, sort: "sim") { value in
            let vc = self.storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func setSearchBarUI() {
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 8
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        udManager.recentSearches = searchBar.text!
        udManager.recentSearchList.insert(searchBar.text!, at: 0)
        searchBar.text = ""
        productManager.callRequest(text: searchBar.text!, start: 1, sort: "sim") { value in
            self.data = value
        }
        recentTableView.reloadData()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

