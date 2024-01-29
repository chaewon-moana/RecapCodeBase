//
//  Product.swift
//  RecapProject
//
//  Created by cho on 1/19/24.
//

import Foundation
import Alamofire

struct ProductList: Codable {
    let total: Int
    let start: Int //삭제 예정
    let display: Int //삭제 예정
    var items: [Product]
}

struct Product: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
}

struct ProductAPIManager {
    let udManager = UserDefaultManager.shared
    
    func callRequest(text: String, start: Int, sort: String, completionHandler: @escaping (ProductList) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(text)&start=\(start)&display=30&sort=\(sort)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        AF.request(url, headers: headers).responseDecodable(of: ProductList.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
