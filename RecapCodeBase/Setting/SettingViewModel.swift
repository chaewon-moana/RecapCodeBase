//
//  SettingViewModel.swift
//  RecapCodeBase
//
//  Created by cho on 2/26/24.
//

import Foundation
import UIKit

class SettingViewModel {
    let cellList: Observable<[String]> = Observable(["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"])
    
    func noticeCellForRowAt(_ indexPath: IndexPath) -> String {
        return cellList.value[indexPath.row]
    }
    
   
}
