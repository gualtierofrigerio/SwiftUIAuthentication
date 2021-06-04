//
//  ContentViewModel.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 31/05/21.
//

import Foundation
import GFAuthentication

class ContentViewModel: ObservableObject {
    @Published var presentAlert = false
    @Published var alertMessage = ""
    
    init() {
        localAuthentication.configureKeychain(service: "SwiftUIAuthentication", group: nil)
    }
    
    func addAccount(username: String, password: String) {
        let added = localAuthentication.addItemInKeychain(account: username, password: password)
        if added {
            alertMessage = "item added to the keychain"
        }
        else {
            alertMessage = "cannot add item to the keychain"
        }
        presentAlert = true
    }
    
    func biometric() {
        localAuthentication.attempBiometricAuthentication(reason: "Login", revertToPasscode: true) { success in
            DispatchQueue.main.async {
                if success {
                    self.alertMessage = "Biometric success"
                }
                else {
                    self.alertMessage = "Biometric failed"
                }
                self.presentAlert = true
            }
        }
    }
    
    func login(username: String, password: String) {
        if let storedPassword = localAuthentication.getPasswordFromKeychain(account: username) {
            if password == storedPassword {
                alertMessage = "username and password found!"
            }
            else {
                alertMessage = "password doesn't match"
            }
        }
        else {
            alertMessage = "cannot find account in keychain"
        }
        presentAlert = true
    }
    
    private let localAuthentication = GFAuthentication()
}
