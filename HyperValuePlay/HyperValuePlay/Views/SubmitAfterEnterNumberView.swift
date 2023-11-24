//
//  File.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import Foundation
import SwiftUI


struct SubmitAfterEnterNumberView<T>: View 
where T: BinaryFloatingPoint {
    var value: Binding<T>
    @State private var localValue: T = 0
    @FocusState private var isFocused

    var formatter : FloatingPointFormatStyle<T> = FloatingPointFormatStyle<T>(locale: Locale.current)
    
    func assignLocalToOutside() {
        if abs(localValue - value.wrappedValue) > 0.00001 {
            value.wrappedValue = localValue 
        }
    }
    
    var body: some View {
        HStack  {
            TextField( "", 
                       value: $localValue, 
                       format: formatter)
            .contentMargins(8)
//            .contentMargins (EdgeInsets(top: 0, 
//                                       leading: 0, 
//                                       bottom: 0, 
//                                       trailing: 6))
            .multilineTextAlignment(.trailing)
            .onSubmit {
                assignLocalToOutside()
            }
            .textFieldStyle(ComittedNumberFieldStyle())
            .onChange(of: value.wrappedValue) {
                localValue = value.wrappedValue
            }
        }.onHover(perform: { hovering in
            isFocused = hovering }
        ).onChange(of: isFocused) {
            if !isFocused {
                self.localValue = value.wrappedValue
                //assignLocalToOutside()
            }
        }.onAppear {
            self.localValue = value.wrappedValue
        }
        .focused($isFocused)
        .frame(maxWidth: 90)
    }
    
//    init(value: Binding<T>, 
//         isReady: Bool = true) {
//
//        self.outsideValue = value
//    }
}

#Preview {
    @State var number: CGFloat = 999
    return SubmitAfterEnterNumberView(value: $number)
}


