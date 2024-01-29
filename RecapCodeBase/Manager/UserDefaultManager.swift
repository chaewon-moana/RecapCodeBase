//
//  UserDefaultManager.swift
//  RecapProject
//
//  Created by cho on 1/18/24.
//

import UIKit

class UserDefaultManager {
    
    private init() { }
    
    static let shared = UserDefaultManager()
    
    let ud = UserDefaults.standard
    let list = ["dd", "ee", "asdf","sdfgg"]
    
    enum UDKey: String {
        case selectedImageIndex
        case nickname
        case firstVisit
        case recentSearchList
        case recentSearches
        case selectedFilteredButton
        case productList
        case likeList
    
    }
    
    var likeList: [String] {
        get {
            ud.array(forKey: UDKey.likeList.rawValue) as? [String] ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.likeList.rawValue)
        }
    }

    var selectedImageIndex: Int {
        get {
            ud.integer(forKey: UDKey.selectedImageIndex.rawValue)
        }
        set {
            ud.set(newValue, forKey: UDKey.selectedImageIndex.rawValue)
        }
    }
    
    var nickname: String {
        get {
            ud.string(forKey: UDKey.nickname.rawValue) ?? "이름없음"
        }
        set {
            ud.set(newValue, forKey: UDKey.nickname.rawValue)
        }
    }
    
    var firstVisit: Bool {
        get {
            ud.bool(forKey: UDKey.firstVisit.rawValue) 
        }
        set {
            ud.set(newValue, forKey: UDKey.firstVisit.rawValue)
        }
    }
    
    var recentSearchList: [String] {
        get {
            ud.array(forKey: UDKey.recentSearchList.rawValue) as? [String] ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.recentSearchList.rawValue)
        }
    }
    
    var recentSearches: String {
        get {
            ud.string(forKey: UDKey.recentSearches.rawValue) ?? "키보드"
        }
        set {
            ud.set(newValue, forKey: UDKey.recentSearches.rawValue)
        }
    }
    
    var selectedFilteredButton: Int {
        get {
            ud.integer(forKey: UDKey.selectedFilteredButton.rawValue) //기본값으로 0으로 나옴
        }
        set {
            ud.set(newValue, forKey: UDKey.selectedFilteredButton.rawValue)
        }
    }
}
