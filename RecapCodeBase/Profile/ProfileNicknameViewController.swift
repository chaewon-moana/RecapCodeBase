//
//  NicknameViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

enum SettingType {
    case setting
    case editing
}

class ProfileNicknameViewController: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var camaraImageView: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var underLineView: UIView!
    
    let profileList = DataManager.profileImageList
    let udManager = UserDefaultManager.shared
    var checkDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.delegate = self

        setNavigation()
        setCommonUI()
        setUI()
        setTextField()
                
        let image = UIImage(systemName: "chevron.backward")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = button
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImageView.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    
    func setNavigation() {
        navigationItem.title = udManager.firstVisit ? "프로필 수정" : "프로필 설정"
    }
    
    func setUI() {
        
        backView.backgroundColor = .clear
        
        profileImageView.setImageViewButton(size: 100)
        profileImageView.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
                
        stateLabel.text = "닉네임에 @, #, $, %의 특수문자 및 숫자는 사용불가합니다."
        stateLabel.font = .subTextFont
        stateLabel.textColor = .customPointColor
        
        camaraImageView.image = .camera
        
        doneButton.customButton(text: "완료")
        
        underLineView.backgroundColor = .gray
        underLineView.layer.borderWidth = 1
        underLineView.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func profileImageTapped(_ sender: UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ProfileImageViewController.identifier) as! ProfileImageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        udManager.nickname = nicknameTextField.text!
        udManager.firstVisit = true

        if checkDone {
            
            udManager.nickname = nicknameTextField.text!
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
            vc.selectedIndex = 0
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        } else { //TODO: 조건에 맞지 않을 때, alert 띄우기 나아아중에
            
            let alert = UIAlertController(title: "닉네임 조건에 맞지 않습니다.", message: "닉네임을 조건에 맞게 다시 설정해주세요", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            //조건에 맞지 않다고 닉네임 다시 설정해달라는 alert 띄우기
        }
    }
}

extension ProfileNicknameViewController: UITextFieldDelegate {
    
    enum textState: String {
        case normal = "사용할 수 있는 닉네임이에요 :)"
        case misTextLength = "2글자 이상 10글자 미만으로 설정해주세요"
        case specialCharacter = "닉네임에 @,#,$,%는 포함할 수 없어요"
        case number = "닉네임에 숫자는 포함할 수 없어요"
    }
    
    func setTextField() {
        nicknameTextField.borderStyle = .none
        nicknameTextField.placeholder = "닉네임을 입력해주세요:)"
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        let specialText = ["#","@","$","%"]
        let number = ["0","1","2","3","4","5","6","7","8","9"]
        let maxTextLength = 9
        let minTextLength = 2
        
        var checkSpecial = false
        var checkNumber = false
        var checkLength = false
        
        for idx in specialText where text.contains(idx) {
            checkSpecial = true
        }
        
        for idx in number where text.contains(idx) {
            checkNumber = true
        }
        
        if checkSpecial {
            stateLabel.text = textState.specialCharacter.rawValue
            stateLabel.textColor = .warningColor
        } else if checkNumber {
            stateLabel.text = textState.number.rawValue
            stateLabel.textColor = .warningColor
        } else if text.count < minTextLength {
            stateLabel.text = textState.misTextLength.rawValue
            stateLabel.textColor = .warningColor
        } else if text.count == maxTextLength {
            stateLabel.text = textState.misTextLength.rawValue
            stateLabel.textColor = .warningColor
        } else {
            stateLabel.text = textState.normal.rawValue
            stateLabel.textColor = .customPointColor
        }

        if text.count > maxTextLength {
            let startIndex = text.startIndex
            let endIndex = text.index(startIndex, offsetBy: maxTextLength - 1)
            let fixedText = String(text[startIndex...endIndex])
            textField.text = fixedText
        }
        
        if text.count < minTextLength || text.count > maxTextLength {
            checkLength = true
        }
        checkDone = !checkNumber && !checkSpecial && !checkLength
    }
}
