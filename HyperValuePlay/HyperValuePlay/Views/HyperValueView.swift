//
//  HyperValue.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//
import Foundation
import SwiftUI
import HyperValue

struct CornerButton<CP>: View
where CP: CornerProtocol
{
    var vertex: CP
    var body: some View {
        Rectangle().fill(vertex.strength == .corner ? Color.blue : Color.orange)
    }
}


struct HyperValueView<Interpolable, Axis>: View 
where Interpolable: IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    
    
    @Bindable var hyperModel: HyperValueModel<Interpolable, Axis>
    @Bindable var axesModel: GlobalAxesModel<Axis>
    
    
    
    @State var showEditCorrectionPopover: Bool = false
    
    var formatter = FloatingPointFormatStyle<CGFloat>(locale: Locale(identifier: "en_US"))
    
    
    var body: some View {
        VStack (alignment: .leading){
            // if let hyperModel {
            let typeName = "\(Interpolable.self)"
            Text("Hyper Value \(typeName)")
                .controlSize(.extraLarge)
                .multilineTextAlignment(.leading)
                .frame(width: 150)
            
            InterpolableView<Interpolable>(data: Binding(get: {hyperModel.value}, 
                                                       set: {hyperModel.value = $0}) )//OK
            .disabled(hyperModel.isInterpolated)
            
            Divider()
            
            if let axis = axesModel.selectedAxis, 
                hyperModel.canAdd(axis: axis)
            {
                Button("add axis to HyperView") {
                    do {
                        try hyperModel.add(axis: axis, from: axesModel.axes)
                    } catch {
                        print (error)
                    }
                }
            }
            Text ("Internal Axes:")
            ForEach(hyperModel.hyper.internalAxes.indices, id:\.self) {index in
                let axis = hyperModel.hyper.internalAxes[index]
                let p = "\(axis.position)"
                Text("\(axis.name) at \(p)")
            }
            
            Divider()
            
            Text("Number of corners: \(hyperModel.cornersCount)")
            CornerChooser(axes: $axesModel.axes, hyperModel: hyperModel)
            
            Divider()
            
            Text("Number of corrections: \(hyperModel.correctionsCount)")
            let correctionsCount = hyperModel.hyper.corrections.count
            ForEach (0..<correctionsCount, id:\.self ) {index in
                Button(action: {
                    let coordinates = hyperModel.hyper.corrections[index].coordinates 
                    axesModel.axes.setCoordinates(coordinates)
                }, label: {
                    HStack {
                        let t = "\(hyperModel.hyper.corrections[index].description)"
                        Text("\(t)")
                        if let color = hyperModel.hyper.corrections[index].data as? Color {
                            color.frame(width: 20, height: 12)
                                .border(Color.white)
                        }
                        Button(action: { showEditCorrectionPopover = true}, 
                               label: {Image(systemName: "rectangle.and.pencil.and.ellipsis").symbolRenderingMode(.multicolor)})
                        .buttonStyle(.borderless)
                    }
//                    .popover(isPresented: $showEditCorrectionPopover) {
//                        ForEach(hyperModel.corrections[index]
//                            .coordinates.indices, id:\.self) {coordIdx in
//                                HStack {
//                                    Text("\(hyperModel.corrections[index].coordinates[coordIdx].axis.name)")
//                                    SubmitAfterEnterNumberView("",value: Binding(get: {hyperModel.corrections[index].coordinates[coordIdx].at}, 
//                                                                                 set: {print("\(#function) \( $0)")}))
//                                }
//                            }
//                    }
                    
                    
                })
                
                
                
            }
            Button("Add correction") {
                let ok = hyperModel.addCorrection()
                print ("Correction\(ok ? "" : "not") added")
            }
           
        }
        
    }
}



#Preview {
    @State var axes = [
        MyAxis(name: "A", bounds: 0...1000),
        MyAxis(name: "B", bounds: 0...1000),
        MyAxis(name: "C", bounds: 0...1000),
    ]
    typealias Axis = MyAxis
    @State var axesModel = GlobalAxesModel<Axis> ()
    let hyper = HyperValue<Color, Axis>()
    @State var hyperModel = HyperValueModel(hyper: hyper)
    return HyperValueView(hyperModel: hyperModel, 
                          axesModel: axesModel)
}

struct VerticesView<V>: View 
where V:CorrectionProtocol,
      V.Coordinate.Axis: AxisProtocol
{
    
    var vertices: [V]
    var body: some View {
        ForEach (vertices.indices , id:\.self ) { i in
            VStack {
                CorrectionView(correction: vertices[i])
            }
        }
    }
}
