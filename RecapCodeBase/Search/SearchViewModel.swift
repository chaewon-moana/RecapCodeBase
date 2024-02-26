//
//  SearchViewModel.swift
//  RecapCodeBase
//
//  Created by cho on 2/26/24.
//

import Foundation

class SearchViewModel {
    
    enum SortedButton: String, CaseIterable {
        case sim
        case date
        case dsc //가격 높은 순
        case asc //가격 낮은 순
    }
    
    let productManager = ProductAPIManager()

    var inputTotalProductCount: Observable<Int> = Observable(0)
    var inputRecentSearches: Observable<String> = Observable("")
    var inputViewDidLoad: Observable<Void?> = Observable(nil)
    
    var outputProductList: Observable<ProductList> = Observable(ProductList(total: 0, start: 0, display: 0, items: []))
    var outputProductItems: Observable<[Product]> = Observable([])
    var outputResultLabel: Observable<String> = Observable("")
    
    
    init() {
        inputViewDidLoad.bind { _ in
            self.callRequest()
        }
    }
    private func callRequest() {
        productManager.callRequest(text: inputRecentSearches.value, start: 1, sort: SortedButton.sim.rawValue) { [self] product in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(for: inputTotalProductCount.value)
            outputResultLabel.value = "\(result)개의 검색 결과"
            outputProductList.value = product
            outputProductItems.value = product.items
        }

    }
}
