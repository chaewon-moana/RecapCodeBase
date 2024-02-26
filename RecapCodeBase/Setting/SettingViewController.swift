//
//  SettingViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController, CodeBase {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let udManager = UserDefaultManager.shared
    let dataManager = DataManager.profileImageList
    var likeList = UserDefaultManager.shared.likeList
    var likeCount = 0
    
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    
        navigationItem.title = "설정"
        
        tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person.fill"), tag: 0)
        tabBarController?.tabBar.tintColor = .customPointColor
        tabBarController?.tabBar.barTintColor = .black
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
        
        setAddView()
        configureLayout()
        configureAttribute()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setAddView() {
        view.addSubview(tableView)
    }
    
    func configureAttribute() {

    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.cellList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
            profileCell.selectionStyle = .none
            profileCell.likeLabel.attributedText = profileCell.configureCell(count: udManager.likeList.count)
            profileCell.profileImage.image = UIImage(named: DataManager.profileImageList[udManager.selectedImageIndex])
            return profileCell
        } else {
            let noticeCell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell")!
            
            noticeCell.textLabel?.text = viewModel.noticeCellForRowAt(indexPath)
            noticeCell.textLabel?.font = .middleBodyFont
            
            return noticeCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = ProfileNicknameViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            //HELP!!!: 얘를 뷰모델로 옮기고 싶은데 그러면 viewModel에 UIKit을 import 해야하는데 그게 맞을까요?
            if indexPath.row == viewModel.cellList.value.count - 1 {
                showAlertWithCancel(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?") { action in
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    
                    let vc = OnboardViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
            }
        }
        
    }
}

#Preview {
    SettingViewController()
}
