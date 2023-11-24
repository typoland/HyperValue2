//
//  VertexView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct CorrectionView<V>: View 
where V:CorrectionProtocol,
      V.Coordinate.Axis: AxisProtocol
{
    var correction: V
    var body: some View {
        HStack {
            let t = "\(correction)"
            Text("\(t)")
            let atoms = correction.data.atomized
            ForEach(atoms.indices, id:\.self) {i in
                let z = "\(Double(atoms[i]).formatted(.number.precision(.fractionLength(0...2))))"
                Text("\(z)")
            }
        }
    }
}

#Preview {
    let axis = HyperColor.Axis(name: "axis", bounds: 0...1000)
    let coordinates = HyperColor.Coordinate(on: axis, position: .number(500))
    let vertex = HyperColor.Correction(value: Color.red, 
                                            at: [coordinates], 
                                            strength: .corner)
    return CorrectionView(correction: vertex)
}


