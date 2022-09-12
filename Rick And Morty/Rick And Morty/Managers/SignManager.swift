//
//  SignManager.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation

class SignManager {
    
    private var defaults = UserDefaults.standard
    
    func getSignStatus() -> Bool {
        if let _ = defaults.string(forKey: "token") {
            return true
        } else {
            return false
        }
    }
    
    func getToken() -> String {
        return defaults.string(forKey: "token") ?? "error"
    }
    
    func setToken(token: String) {
        defaults.setValue(token, forKey: "token")
    }
    
    func signOut() {
        defaults.removeObject(forKey: "token")
    }
    
}
