//
//  UserHelper.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation
import Alamofire

private struct AppConstants {
    // NSUserDefaults persistence keys
    static let isUserLogin          = "isUserLogin"
    static let accessToken          = "accessToken"
    static let refreshToken         = "refreshToken"
}

private struct UserConstants {
    // NSUserDefaults persistence keys
    static let addressline1 = "addressline1"
}

let userManager = UserManager.shared

internal class UserManager {
    
    // static properties get lazy evaluation and dispatch_once_t for free
    private struct Static {
        static let instance = UserManager()
    }
    
    // this is the Swift way to do singletons
    class var shared: UserManager { 
        return Static.instance
    }
    
    // user authentication always begins with a UUID
    private let userDefaults = UserDefaults.standard
    
    let dateFormatter = DateFormatter()
    
    // username etc. are backed by NSUserDefaults, no need for further local storage
    
    var httpTokenHeader: HTTPHeaders? {
        get {
            return ["Accept": "application/json", "Authorization": !(userManager.accessToken.isEmpty) ? "Bearer \(userManager.accessToken)" : "", "Content-Type": "application/json"]
        }
    }
    
    var httpPreTokenHeader: HTTPHeaders? {
        get {
            return ["Accept": "application/json"]
        }
    }
    
    var isUserLogin: Bool {
        get {
            return userDefaults.object(forKey: AppConstants.isUserLogin) as? Bool ?? false
        }
        
        set (newValue) {
            userDefaults.set(newValue, forKey: AppConstants.isUserLogin)
            userDefaults.synchronize()
        }
    }
    
    // user token data
    var accessToken: String {
        get {
            return userDefaults.object(forKey: AppConstants.accessToken) as? String ?? ""
        }
        
        set (newValue) {
            userDefaults.set(newValue, forKey: AppConstants.accessToken)
            userDefaults.synchronize()
        }
    }
    
    // user refresh token data
    var refreshToken: String {
        get {
            return userDefaults.object(forKey: AppConstants.refreshToken) as? String ?? ""
        }
        
        set (newValue) {
            userDefaults.set(newValue, forKey: AppConstants.refreshToken)
            userDefaults.synchronize()
        }
    }
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
}

extension UserManager {
    
    // MARK: clearAllData
    func clearAllData() {
        
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        userDefaults.synchronize()
    }
    
}

extension UserDefaults {
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
