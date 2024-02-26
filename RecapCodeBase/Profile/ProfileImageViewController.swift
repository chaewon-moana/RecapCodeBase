//
//  ProfileImageViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit
import SnapKit

class ProfileImageViewController: UIViewController, CodeBase {
    
    let profileImageView = ProfileImageView(frame: .zero)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    let profileList = DataManager.profileImageList
    let udManager = UserDefaultManager.shared
    lazy var selectedImageIdx = udManager.selectedImageIndex {
        didSet {
            print(selectedImageIdx, 44)
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageIdx = udManager.selectedImageIndex
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.title = udManager.firstVisit ? "프로필 설정" : "프로필 수정"
        let image = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        
        collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileImageCollectionViewCell")
        
        setAddView()
        configureLayout()
        configureAttribute()

    }
    
    func setAddView() {
        view.addSubview(profileImageView)
        view.addSubview(collectionView)
    }
    
    func configureAttribute() {
        profileImageView.image = UIImage(named: profileList[udManager.selectedImageIndex])
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        collectionView.backgroundColor = .clear
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let cellWidth = UIScreen.main.bounds.width - spacing * 5
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    @objc func backButtonTapped() {
        udManager.selectedImageIndex = selectedImageIdx
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell

        cell.imageView.image = UIImage(named: profileList[indexPath.item])
        cell.imageView.backgroundColor = .blue
        
        if selectedImageIdx == indexPath.item {
            cell.imageView.layer.borderColor = UIColor.customPointColor.cgColor
        } else {
            cell.imageView.layer.borderColor = UIColor.clear.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIdx = indexPath.item
        profileImageView.image = UIImage(named: profileList[selectedImageIdx])
    }
    
}

 
