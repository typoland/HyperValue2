//
//  AxisView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 12/11/2023.
//

import SwiftUI
import HyperValue

struct AxisView<Axis>: View
where Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    @Binding var axis: Axis
    var lock: Bool
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                Text("\(axis.name)")
                    .multilineTextAlignment(.leading)
                    .controlSize(.extraLarge)
                
            } .frame(width: 70)
            
            TextField("", value: $axis.at, 
                      formatter: NumberFormatter())
            .frame(width: 30)
            .disabled(lock)
            
            Slider(value: Binding(get: {axis.at}, 
                                  set: {axis.at = $0}),
                   in: axis.lowerBound...axis.upperBound)
            .disabled(lock)
//            TextField("short", text: $axis.shortName)
//                .frame(width: 22)
        }
        
    }
}

#Preview {
    @State var axis: MyAxis = MyAxis(name: "A", bounds: 0...1000)
    return AxisView(axis: $axis, lock: false)
}
