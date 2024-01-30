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
    //@IBOutlet var tableView: UITableView!
    let cellList = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]
    let udManager = UserDefaultManager.shared
    let dataManager = DataManager.profileImageList
    var likeList = UserDefaultManager.shared.likeList
    var likeCount = 0
    
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
        
        if section == 0 {
            return 1
        } else {
            return cellList.count
        }
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
            noticeCell.textLabel?.text = cellList[indexPath.row]
            noticeCell.textLabel?.font = .middleBodyFont

            return noticeCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = ProfileNicknameViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: 다른 cell은 막고, 처음부터 선택하기 cell을 누르면 다 초기화되고 onboarding으로 출발
            
            if indexPath.row == cellList.count - 1 {
                let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "확인", style: .default) { action in

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
                
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                alert.addAction(cancel)
                alert.addAction(ok)

                present(alert, animated: true)
            }
        }
    }
    
}

#Preview {
    SettingViewController()
}
