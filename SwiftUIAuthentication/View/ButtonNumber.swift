//
//  ButtonNumber.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 04/06/21.
//

import SwiftUI

struct ButtonNumber: View {
    var number:Int
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("\(number)")
                .font(Font.largeTitle)
        }
        .buttonStyle(MyButtonStyle())
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.largeTitle)
            .frame(width:70, height:70)
            .padding()
            .background(configuration.isPressed ? Color.red : Color.green)
            .clipShape(Circle())
    }
    
}

struct ButtonNumber_Previews: PreviewProvider {
    static var previews: some View {
        ButtonNumber(number: 1, action: {})
    }
}
