//
//  CGPointView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct InterpolableView<D>: View 
where D: IntepolableProtocol
{
    typealias Interpolable = D
    @Binding var data: D
//    @State private var atoms: [D.Atom] = []
    var body: some View {
        HStack(content: {
            if let color = data as? Color {
                color.frame(width: 30, height: 28)
                    .border(Color.white)
            }
            ForEach(0..<Interpolable.atomsCount, id:\.self) {index in
                SubmitAfterEnterNumberView(value: Binding(get: {data.atomized[index]}, 
                                                              set: {newValue in
                        var newAtoms = data.atomized 
                        newAtoms[index] = newValue
                        data = Interpolable(atoms: newAtoms)
                    })) 
              
                }
            
        })
    }
}

#Preview {
    @State var point: CGPoint = CGPoint(x: 20, y: 20)
    @State var ready = true
    @State var v = CGPoint()
    return InterpolableView(data: $v)
}
