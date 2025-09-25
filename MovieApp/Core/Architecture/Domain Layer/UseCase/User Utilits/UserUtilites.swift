//
//  UserUtilites.swift
//  POMacArch
//
//  Created by mohamed gamal on 22/12/2021.
//  Copyright © 2021 PoMac. All rights reserved.
//

import Foundation

protocol UserUtilitesProtocol {
    static func save(token: String)
    static func loadToken() -> String?
    static func deleteToken()
}

class UserUtilites: UserUtilitesProtocol {
    struct Keys {
        static let token = "userToken"
        static let user = "User"
        static let fcmToken = "fcmToken"
        static let onboardShow = "onboardShow"
        static let complateProfile = "complateProfile"
        static let pandingProfile = "Panding"
        static let update = "Update"
        static let reloadOrder = "reloadOrder"
        static let reloadHome = "reloadHome"
    }
    static func save(token: String) {
        UserDefaults.standard.set(token, forKey: Keys.token)
        UserDefaults.standard.synchronize()
    }
    static func onboardShow(onboardShow: Bool) {
        UserDefaults.standard.set(onboardShow, forKey: Keys.onboardShow)
        UserDefaults.standard.synchronize()
    }
    
    static func saveIsComplate(complate: Bool) {
        UserDefaults.standard.set(complate, forKey: Keys.complateProfile)
        UserDefaults.standard.synchronize()
    }
    
    static func saveIsPanding(complate: Bool) {
        UserDefaults.standard.set(complate, forKey: Keys.pandingProfile)
        UserDefaults.standard.synchronize()
    }
    
    static func loadIsComplate() -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.complateProfile)
    }
    
    static func loadIsPanding() -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.pandingProfile)
    }
    static func isLoagin() -> Bool {
        return !(UserDefaults.standard.string(forKey: Keys.token)?.isEmpty ?? true)
    }
    
    static func loadonboardShow() -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.onboardShow) 
    }

    static func loadToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.token)
    }
    static func saveFcmToken(token: String) {
        UserDefaults.standard.set(token, forKey: Keys.fcmToken)
        UserDefaults.standard.synchronize()
    }

    static func loadFcmToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.fcmToken)
    }

    static func deleteToken() {
        UserDefaults.standard.removeObject(forKey: Keys.token)
        UserDefaults.standard.synchronize()
    }
    
    static func deleteIsComplate() {
        UserDefaults.standard.removeObject(forKey: Keys.complateProfile)
        UserDefaults.standard.synchronize()
    }
    
    static func deleteIsPanding() {
        UserDefaults.standard.removeObject(forKey: Keys.pandingProfile)
        UserDefaults.standard.synchronize()
    }
    static func saveUpdateRequird(requird: String) {
        UserDefaults.standard.set(requird, forKey: Keys.update)
        UserDefaults.standard.synchronize()
    }
    static func loadUpdateRequird() -> String? {
        return UserDefaults.standard.string(forKey: Keys.update)
    }
    static func saveReloadOrders(requird: Bool) {
        UserDefaults.standard.set(requird, forKey: Keys.reloadOrder)
        UserDefaults.standard.synchronize()
    }
    static func loadOrders() -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.reloadOrder)
    }
    static func saveReloadHome(requird: Bool) {
        UserDefaults.standard.set(requird, forKey: Keys.reloadHome)
        UserDefaults.standard.synchronize()
    }
    static func loadHome() -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.reloadHome)
    }    
    //MARK: - delete User
    static func deleteUser(){
        UserDefaults.standard.removeObject(forKey: Keys.user)
        UserDefaults.standard.synchronize()
    }
}

