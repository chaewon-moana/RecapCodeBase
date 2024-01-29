//
//  SearchDetailViewController.swift
//  RecapProject
//
//  Created by cho on 1/21/24.
//

import UIKit
import WebKit

class SearchDetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var productId: String = ""
    var productTitle: String = ""
    let udManager = UserDefaultManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = udManager.likeList.contains(productId) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = button
        navigationItem.title = productTitle
        navigationController?.navigationBar.tintColor = .white
        tabBarController?.tabBar.barTintColor = .black

        linkWebView()
    }
    
    @objc func likeButtonTapped() {
        var tmp = udManager.likeList
        if udManager.likeList.contains(productId) {
            let idx = udManager.likeList.firstIndex(of: productId)!
            tmp.remove(at: idx)
            udManager.likeList = tmp
        } else {
            tmp.append(productId)
            udManager.likeList = tmp
        }
        let image = udManager.likeList.contains(productId) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = button
    }


    func linkWebView() {
        let url = URL(string: "https://msearch.shopping.naver.com/product/\(productId)")
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
}
