//
//  AxesView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct AxesView<Interpolable, Axis>: View 
where Axis: AxisProtocol,
      Axis: HasCoordinateProtocol,
      Interpolable: IntepolableProtocol

{
    typealias Interpolable = Interpolable
    
    
    var axesModel: GlobalAxesModel<Axis>
    @Binding var selectedHyper: HyperValue<Interpolable, Axis>?  
    @State private var axisName = ""
    @FocusState private var isFocused
    //@State private var colorTask: Task<Void, Error>? = nil
    
    enum Bound {
        case upper
        case lower
    }
    
    
    func formatter(for axis: Axis, bound: Bound) -> NumberFormatter {
        let formatter = NumberFormatter()
        switch bound {
        case .lower :
            formatter.maximum = NSNumber(value: Double(axis.upperBound))
        case .upper :
            formatter.minimum = NSNumber(value: Double(axis.lowerBound))
        }
        return formatter
    }
    
    
    func lock(_ axis: Axis) -> Bool {
        guard let selectedHyper else {return false}
        return !selectedHyper.internalAxes.contains(axis)
    }
    
    //    func bindAxes(index:Int) -> Binding<Axis> {
    //        Binding(get: {axes[index]}, set: {axes[index] = $0})
    //    }
    
    
    var body: some View {
        VStack {
            Text("axes view")
            VStack (alignment: .leading) {
                ForEach(axesModel.axes, id:\.name) { axis in
                    AxisView(axis: Binding(get: {axis}, 
                                           set: {
                        if let index = axesModel.axes.firstIndex(where: {$0.name == axis.name}) {
                            axesModel.axes[index] = $0
                        }
                    }), 
                             lock: lock(axis))
                    .controlSize(.small)
                    .focusable(false)
                    .background {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill( axesModel.selectedAxis == axis 
                                   ? Color.blue
                                   : Color.gray.opacity(0.1))
                    }
                    .gesture(TapGesture().onEnded {
                        isFocused = true
                        axesModel.selectedAxis = axis
                        axisName = axesModel.selectedAxis?.name ?? ""
                    })
                }
                
            }
            .padding(20)
            .focusable(false)
//            
//           
//            Button(action: {
//                if let index = axesModel.indexOfSelectedAxis {
//                    axesModel.delete(index)
//                    axesModel.selectedAxis = nil
//                    axisName = ""
//                } else {
//                    axesModel.add()
//                }
//            }, label: {
//                Text("\(axesModel.selectedAxis == nil ? "Add" : "Remove") axis")
//            })
        }
        .background (
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), 
                             style: .continuous)
            .fill(Color.gray.opacity(0.1))
        )
        .gesture(TapGesture().onEnded({axesModel.selectedAxis = nil}))
        
       
        
        //------------------------------------------------------------------------------------
        
        if let index = axesModel.indexOfSelectedAxis {
            VStack {
                TextField("axis", text: $axisName)
                    .onSubmit {
                        axesModel.selectedAxis?.name = axisName
                    }
//                HStack {
//                    
//                    TextField("lower", 
//                              value: axesModel.axes[index].lowerBound, 
//                              formatter: formatter(for: axesModel.axes[index],
//                                                   bound: .lower))
//                    TextField("upper", 
//                              value: axesModel.axes[index].upperBound, 
//                              formatter: formatter(for: axesModel.axes[index],
//                                                   bound: .upper))
//                }
            }
        }
        //------------------------------------------------------------------------------------
        
    
                    
      
        
        //------------------------------------------------------------------------------------
        
        
    }
}

#Preview {
    let axes: [MyAxis] = [
        MyAxis(name: "A", bounds: 0...1000),
        MyAxis(name: "B", bounds: 0...1000),
        MyAxis(name: "C", bounds: 0...1000),
    ]
    @Bindable var axesModel = GlobalAxesModel<MyAxis>(axes: axes)
    @State var hyper : HyperColor? = HyperColor()
    return AxesView(axesModel: axesModel, selectedHyper: $hyper)
}
