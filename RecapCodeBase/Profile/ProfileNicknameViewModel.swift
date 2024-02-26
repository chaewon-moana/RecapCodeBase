//
//  ProfileNicknameViewModel.swift
//  RecapCodeBase
//
//  Created by cho on 2/26/24.
//

import Foundation

class ProfileNicknameViewModel {
    
    enum textState: String {
        case normal = "사용할 수 있는 닉네임이에요 :)"
        case misTextLength = "2글자 이상 10글자 미만으로 설정해주세요"
        case specialCharacter = "닉네임에 @,#,$,%는 포함할 수 없어요"
        case number = "닉네임에 숫자는 포함할 수 없어요"
    }
    
    let udManager = UserDefaultManager.shared
    
    var inputNickname: Observable<String?> = Observable("")
    
    var outputStateLabel = Observable("")
    var outputNicknameLabel = Observable("")
    var outputStateLabelColor: Observable<Bool> = Observable(true)
    
    var checkDone = false
    
    init() {
        inputNickname.bind { text in
            self.nicknameValidation(text)
        }
    }
    
    //HELP!!!!!: 이거 필터되는 조건에 따라서 입력되는 값이 달라지는데 해결할 수 있는 좋은 방법이 없나,,?
    private func nicknameValidation(_ text: String?) {
        guard let text = text else { return }
        
        let specialText = ["#","@","$","%"]
        let number = ["0","1","2","3","4","5","6","7","8","9"]
        let maxTextLength = 9
        let minTextLength = 2
        
        outputStateLabel.value = textState.normal.rawValue
        outputNicknameLabel.value = text
        outputStateLabelColor.value = true

        for idx in specialText where text.contains(idx) {
            outputStateLabel.value = textState.specialCharacter.rawValue
            outputStateLabelColor.value = false
        }
      
        for idx in number where text.contains(idx) {
            outputStateLabel.value = textState.number.rawValue
            outputStateLabelColor.value = false
        }
        
        if text.count < minTextLength {
            outputStateLabel.value = textState.misTextLength.rawValue
            outputStateLabelColor.value = false
        }
        
        if text.count > maxTextLength {
            outputStateLabel.value = textState.misTextLength.rawValue
            let startIndex = text.startIndex
            let endIndex = text.index(startIndex, offsetBy: maxTextLength - 1)
            let fixedText = String(text[startIndex...endIndex])
            outputNicknameLabel.value = fixedText
            outputStateLabelColor.value = false
        }
    }
}
