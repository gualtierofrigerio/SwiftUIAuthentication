//
//  NumericKeyboard.swift
//  SwiftUIAuthentication
//
//  Created by Gualtiero Frigerio on 04/06/21.
//

import SwiftUI

struct NumericKeyboard: View {
    @ObservedObject var viewModel: NumericKeyboardViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.message)
            HStack {
                pinViewFromArray(viewModel.pin, length:viewModel.pinLength)
            }
            .padding(80)
            buttonsRows
        }
    }
    
    // MARK: - Private
    
    @State private var numberString = ""
    
    private var buttonsRows: some View {
        VStack {
            ForEach(0..<3) { externalIndex in
                HStack {
                    ForEach(1..<4) { index in
                        buttonForIndex(externalIndex: externalIndex, index: index)
                    }
                }
            }
            HStack {
                Button {
                    viewModel.loginWithBiometric()
                } label: {
                    Image(systemName: "faceid")
                }
                .disabled(!viewModel.enableBiometric)
                .foregroundColor(viewModel.enableBiometric ? Color.primary : Color.gray)
                .buttonStyle(MyButtonStyle())
                buttonForIndex(externalIndex: 0, index: 0)
                Button {
                    viewModel.clearPin()
                } label: {
                    Image(systemName: "clear")
                }
                .buttonStyle(MyButtonStyle())
            }
        }
    }
    
    private func buttonForIndex(externalIndex: Int, index: Int) -> some View {
        let number = externalIndex * 3 + index
        return ButtonNumber(number: number) {
            numberTap(number)
        }
    }
    
    private func pinViewFromArray(_ pinArray:[Int], length:Int) -> some View {
        func numberAtIndex(_ index: Int) -> String {
            if pinArray.count >= index + 1 {
                //return "\(pinArray[index])"
                return "*"
            }
            else {
                return "_"
            }
        }
        
        return ForEach(0..<length) { index in
            Text(numberAtIndex(index))
                .font(Font.largeTitle)
        }
    }
    
    private func numberTap(_ number:Int) {
        viewModel.addNumberToPin(number)
    }
}

struct NumericKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        NumericKeyboard(viewModel: NumericKeyboardViewModel(loginManager: LoginManager()))
    }
}
