//
//  OnboardViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class OnboardViewController: UIViewController, CodeBase {

    let nameImageView = UIImageView()
    let onboardImageView = UIImageView()
    let startButton = SeSACButton()
    
    let udManager = UserDefaultManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCommonUI()      
        setAddView()
        configureLayout()
        configureAttribute()
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    func setAddView() {
        view.addSubview(nameImageView)
        view.addSubview(onboardImageView)
        view.addSubview(startButton)
    }
    
    func configureAttribute() {
        nameImageView.image = .sesacShopping
        
        onboardImageView.image = .onboarding
        
        startButton.setTitle("시작하기", for: .normal)
    }
    
    func configureLayout() {
        nameImageView.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(120)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.centerX.equalTo(view)
        }
        
        onboardImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.top.equalTo(nameImageView.snp.bottom).offset(70)
            make.centerX.equalTo(view)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    @objc func startButtonTapped() {
        print("start button 눌림")
        let vc = ProfileNicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
