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
    let viewModel = ProfileNicknameViewModel()
    
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
        
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
    }

    @objc func nicknameTextFieldChanged() {
        viewModel.inputNickname.value = nicknameTextField.text
        
        //HELP!!!: Color를 저런식으로 판단하는 조건도 viewmodel에 넣어야하는건지, 요정도는 빼도 괜찮은지
        stateLabel.text = viewModel.outputStateLabel.value
        stateLabel.textColor = viewModel.outputStateLabelColor.value ? .customPointColor : .warningColor
        nicknameTextField.text = viewModel.outputNicknameLabel.value
    }
    
    func setAddView() {
        view.addSubviews([profileImageView, cameraImageView, nicknameTextField, stateLabel, doneButton, underLineView])
    }
    
    func configureAttribute() {
        
        profileImageView.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
                
        stateLabel.text = textState.first.rawValue
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

        if viewModel.outputNicknameCheck.value {
            udManager.nickname = nicknameTextField.text!
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let vc = MainTabBarViewController()
            vc.selectedIndex = 0
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        } else {
            showAlertWith(title: "닉네임 조건에 맞지 않습니다.", message: "닉네임을 조건에 맞게 다시 설정해주세요")
        }
    }
}

extension ProfileNicknameViewController: UITextFieldDelegate {

    func setTextField() {
        nicknameTextField.borderStyle = .none
        nicknameTextField.placeholder = "닉네임을 입력해주세요:)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

#Preview {
    ProfileNicknameViewController()
}
