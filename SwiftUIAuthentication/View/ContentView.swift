//
//  ContentView.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 31/05/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel:ContentViewModel
    
    var body: some View {
        VStack {
            Text("Login or add a new account")
            Form {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                    
                Button {
                    addAccount()
                } label: {
                    Text("Add account")
                }
                Button {
                    login()
                } label: {
                    Text("Login")
                }
            }
            Text("Or use FaceID")
            Button {
                biometric()
            } label: {
                Image(systemName: "faceid")
                    .font(Font.largeTitle)
            }
        }
        .alert(isPresented: $viewModel.presentAlert) {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    @State var username:String = ""
    @State var password:String = ""
    
    private func addAccount() {
        viewModel.addAccount(username: username, password: password)
    }
    
    func biometric() {
        viewModel.biometric()
    }
    
    private func login() {
        viewModel.login(username: username, password: password)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
