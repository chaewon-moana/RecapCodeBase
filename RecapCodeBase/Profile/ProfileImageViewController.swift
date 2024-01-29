//
//  ProfileImageViewController.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class ProfileImageViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    //let profileList = DataManager.profileImage.allCases
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
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = button
        setImageView()

    }
    
    @objc func backButtonTapped() {
        udManager.selectedImageIndex = selectedImageIdx
        navigationController?.popViewController(animated: true)
        
    }

    func setImageView() {
        
        profileImageView.setImageViewButton(size: 150)
        profileImageView.image = UIImage(named: profileList[udManager.selectedImageIndex])
        
        let xib = UINib(nibName: ProfileImageCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 16
        let cellWidth = UIScreen.main.bounds.width - spacing * 5
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell

        cell.imageView.image = UIImage(named: profileList[indexPath.item])
        cell.imageView.setImageViewButton(size: 75)
        
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
