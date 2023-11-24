//
//  HyperValueValueView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct HyperValueValueView<V>: View
where V: IntepolableProtocol
{
    @Binding var data: V
    var body: some View {
        HStack {
            let t = "\(V.self)"
            Text("\(t)")
            InterpolableView(data: $data)
        }
    }
}

#Preview {
    @State var data = Color()
    return HyperValueValueView(data: $data)
}
