//
//  OnboardViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet var nameImageView: UIImageView!
    @IBOutlet var onboardImageView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    let udManager = UserDefaultManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCommonUI()        
    }

    func setUI() {
        nameImageView.image = .sesacShopping
        onboardImageView.image = .onboarding
        startButton.customButton(text: "시작하기")
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ProfileNicknameViewController.identifier) as! ProfileNicknameViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
