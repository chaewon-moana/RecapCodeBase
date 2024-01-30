//
//  NicknameViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

enum SettingType {
    case setting
    case editing
}

class ProfileNicknameViewController: UIViewController, CodeBase {
    
    let profileImageView = ProfileImageView(frame: .zero)
    let cameraImageView = UIImageView()
    let nicknameTextField = UITextField()
    let stateLabel = UILabel()
    let doneButton = SeSACButton()
    let underLineView = UIView()

    let profileList = DataManager.profileImageList
    let udManager = UserDefaultManager.shared
    var checkDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.delegate = self

        setAddView()
        configureLayout()
        configureAttribute()
        setNavigation()
        setCommonUI()
        setTextField()
        profileImageTapped()
    
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }

    func setAddView() {
        view.addSubviews([profileImageView, cameraImageView, nicknameTextField, stateLabel, doneButton, underLineView])
    }
    
    func configureAttribute() {
        
        profileImageView.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
                
        stateLabel.text = "닉네임에 @, #, $, %의 특수문자 및 숫자는 사용불가합니다."
        stateLabel.font = .subTextFont
        stateLabel.textColor = .customPointColor
        
        cameraImageView.image = .camera
        
        doneButton.setTitle("완료", for: .normal)
        
        underLineView.backgroundColor = .gray
        underLineView.layer.borderWidth = 1
        underLineView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.bottom.trailing.equalTo(profileImageView)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        
        underLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view).inset(20)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(2)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(underLineView.snp.bottom).offset(10)
        }
        
        doneButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(stateLabel.snp.bottom).offset(30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImageView.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
    }
    
    func setNavigation() {
        navigationItem.title = udManager.firstVisit ? "프로필 수정" : "프로필 설정"
        let image = UIImage(systemName: "chevron.backward")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func profileImageTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func moveToProfileImage() {
        print("이미지 눌림")
        let vc = ProfileImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doneButtonTapped() {
        udManager.nickname = nicknameTextField.text!
        udManager.firstVisit = true

        if checkDone {
            udManager.nickname = nicknameTextField.text!
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let vc = MainTabBarViewController()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 
}

#Preview {
    ProfileNicknameViewController()
}
