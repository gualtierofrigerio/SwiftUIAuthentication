//
//  SwiftUIAuthenticationApp.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 31/05/21.
//

import SwiftUI

@main
struct SwiftUIAuthenticationApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView(viewModel: ContentViewModel())
            NumericKeyboard(viewModel: NumericKeyboardViewModel(loginManager: LoginManager()))
        }
    }
}
