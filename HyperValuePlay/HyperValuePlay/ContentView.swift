//
//  ContentView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 02/11/2023.
//

import SwiftUI
import HyperValue


struct ContentView<Interpolable, Axis> : View 
where Axis: AxisProtocol,
      Axis: HasCoordinateProtocol,
      Interpolable: IntepolableProtocol
{
    
    typealias Hyper = HyperValue<Interpolable, Axis>
    @Bindable var hyperModel = HyperValuesModel<Interpolable, Axis>()
    @Bindable var axesModel = GlobalAxesModel<Axis>()
    
    var body: some View {
        HStack(spacing: 3) {
            
            VStack {
                VStack(alignment: .leading) {
                    Button("Add new hyper value") {
                        hyperModel.addNewHyper()
                    }
                    HyperValueChooser(selectedValue: $hyperModel.selectedHyper, 
                                      values: hyperModel.hyperValues)
                    //                        .frame(maxWidth: 200)
                }.controlSize(.mini)
                
                Divider()
                
                if let hyper = hyperModel.selectedHyper  {
                    HyperValueView(hyperModel: HyperValueModel(hyper: hyper), 
                                   axesModel: axesModel)
                    
                    
                    Spacer()
                }
                Spacer()  
            }.frame(width: 240)
            
            // --------------- Right side -------------------
           
            VStack {
                AxesView(axesModel: axesModel,
                         selectedHyper: $hyperModel.selectedHyper)
//                
                AxisChooser(axesModel: axesModel)
            
                TestColorView(hyper: $hyperModel.selectedHyper, 
                              axesModel: axesModel)
            
            }
          
            
        }
        .padding()
        .onChange(of: axesModel.axes){ old, new in
            if let removedAxis = Set(old).subtracting(Set(new)).first {
                for hyper in hyperModel.hyperValues {
                    Task {
                        await hyper.remove(axis: removedAxis)
                    }
                }
            }
        }.onAppear {
            hyperModel.addNewHyper(makeGlobalHyper(axes: GLOBAL_AXES) as! HyperValue<Interpolable, Axis>)
            axesModel.axes = GLOBAL_AXES as! [Axis]
        }
    }
}

#Preview {
    return ContentView<Color, MyAxis>()
}

