//
//  LoginManager.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 04/06/21.
//

import Foundation
import GFAuthentication

class LoginManager {
    let pinLength = 5
    var enableBiometric = true
    var biometricFaceId = false
    var accountExists = false
    
    init() {
        configureAuthentication()
        checkBiometricAvailability()
        checkIfAccountExists()
    }
    
    func loginWithBiometric(callback: @escaping (Bool) -> Void) {
        authentication.attempBiometricAuthentication(reason: "Login",
                                                     revertToPasscode: true) { success in
            callback(success)
        }
    }
    
    func loginWithPin(_ pinStr: String) -> Bool {
        let savedPin = authentication.getPasswordFromKeychain(account: account)
        return pinStr == savedPin
    }
    
    func registerPin(_ pinStr: String) -> Bool {
        authentication.addItemInKeychain(account: account, password: pinStr)
    }
    
    // MARK: - Private
    private let authentication = GFAuthentication()
    private let account:String = "Test"

    private func checkBiometricAvailability() {
        let (available, type) = authentication.isBiometricAuthenticationAvailable()
        if available {
            enableBiometric = true
            if type == .biometricTypeFaceID {
                biometricFaceId = true
            }
        }
    }
    
    private func checkIfAccountExists() {
        if let _ = authentication.getPasswordFromKeychain(account: account) {
            accountExists = true
        }
        else {
            accountExists = false
        }
    }
    
    private func configureAuthentication() {
        authentication.configureKeychain(service: "SwiftUIAuthentication", group: nil)
    }
}
