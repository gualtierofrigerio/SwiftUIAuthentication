//
//  NumericKeyboardViewModel.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 04/06/21.
//

import Foundation

class NumericKeyboardViewModel: ObservableObject {
    var biometricFaceId: Bool {
        loginManager.biometricFaceId
    } // false for TouchID
    var enableBiometric: Bool {
        loginManager.enableBiometric
    }
    @Published var pin:[Int] = []
    @Published var message = "Insert PIN"
    
    var pinLength:Int {
        loginManager.pinLength
    }
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
        if loginManager.accountExists {
            message = "Insert PIN"
            createAccount = false
        }
        else {
            message = "Create PIN"
            createAccount = true
        }
    }
    
    func addNumberToPin(_ number:Int) {
        pin.append(number)
        if pin.count == pinLength {
            if createAccount == false {
                loginWithPin(pin)
            }
            else {
                addPin(pin)
            }
        }
    }
    
    func clearPin() {
        pin.removeAll()
    }
    
    func loginWithBiometric() {
        loginManager.loginWithBiometric { success in
            DispatchQueue.main.async {
                if success {
                    self.message = "PIN correct"
                }
                else {
                    self.message = "Login failed"
                }
            }
        }
    }
    
    // MARK: - Private
    
    private var createAccount = false
    private var firstPin: [Int] = []
    private let loginManager: LoginManager
    
    private func addPin(_ pin:[Int]) {
        if firstPin.count == 0 {
            firstPin = pin
            clearPin()
            message = "Confirm PIN"
        }
        else { // first pin has a value so it is the confirmation step
            let firstPinStr = convertPinToString(firstPin)
            let pinStr = convertPinToString(pin)
            if firstPinStr == pinStr {
                registerPin(pinStr)
            }
            else {
                clearPin()
                message = "Second PIN is different"
            }
        }
    }
        
    private func convertPinToString(_ pin: [Int]) -> String {
        pin.map {String($0)}.joined()
    }
    
    private func loginWithPin(_ pinArray: [Int]) {
        let pinStr = convertPinToString(pin)
        if loginManager.loginWithPin(pinStr) {
            message = "PIN correct"
        }
        else {
            clearPin()
            message = "Wrong PIN"
        }
    }
    
    private func registerPin(_ pinStr: String) {
        let success = loginManager.registerPin(pinStr)
        if success == false {
            message = "Cannot add PIN"
        }
        else {
            message = "PIN added!"
        }
    }
}
