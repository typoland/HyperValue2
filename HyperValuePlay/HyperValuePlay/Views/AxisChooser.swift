//
//  AxisChooser.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct AxisChooser<Axis>: View 
where Axis: AxisProtocol,
      Axis: HasCoordinateProtocol 
{
    @Bindable var axesModel: GlobalAxesModel<Axis>

    
    var body: some View {
        Picker ("Axis", selection: $axesModel.selectedAxis) {
            ForEach(axesModel.axes, id:\.name) {axis in
                Text(axis.name).tag(axis as Axis?)
            }
            Text("").tag(nil as Axis?)
        }.pickerStyle(PopUpButtonPickerStyle())
    }
}

#Preview {
    let axes: [MyAxis] = [
        MyAxis(name: "A", bounds: 0...1000),
        MyAxis(name: "B", bounds: 0...1000),
        MyAxis(name: "C", bounds: 0...1000),
    ]
    @Bindable var model = GlobalAxesModel(axes: axes)
    return AxisChooser(axesModel: model)
}


