//
//  File.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import Foundation
import SwiftUI

struct ComittedNumberFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .textFieldStyle(.plain)
            //.foregroundColor(isFocused ? .white : .primary).opacity(1)
            .padding(EdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 5))
            .contentMargins(0)
            .frame(maxWidth: 120)
            .focused($isFocused)
            .background {
                if isFocused  {RoundedRectangle(cornerRadius: 3, style: .continuous).foregroundColor(.gray.opacity(0.2))} 
            }
        
            .animation(isFocused 
                       ? Animation.easeIn(duration: 0.05) 
                       : Animation.easeOut(duration: 0.15), 
                       value: isFocused)
        
    }
    
    @FocusState var isFocused: Bool
}

#Preview {
    @State var number: CGFloat = 123
    //var formatter = FloatingPointFormatStyle<CGFloat>(locale: Locale(identifier: "en_US"))
    
    return SubmitAfterEnterNumberView(value: $number)
}
