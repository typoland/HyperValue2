//
//  HyperValueChooser.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import SwiftUI
import HyperValue

struct HyperValueChooser<Interpolable, Axis>: View 
where Interpolable:IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    typealias Hyper = HyperValue<Interpolable, Axis>
    @Binding var selectedValue: Hyper?
    var values: [Hyper]
    
    var body: some View {
        Picker ("Hyper", selection: $selectedValue) {
            ForEach(values) {value in
                let t = "\(value.internalAxes.count) axes, (\(value.corners.count) corners), \(value.corrections.count) corrections"
                Text(t).tag(value as Hyper?)
            }
            Text("").tag(nil as Hyper?)
        }.pickerStyle(PopUpButtonPickerStyle())
    }
}


struct CornerChooser<Interpolable, Axis>: View
where Interpolable:IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    @Binding var axes: [Axis]
    var hyperModel: HyperValueModel<Interpolable, Axis>
    typealias Hyper = HyperValue<Interpolable, Axis>
    func cornerColorImage(for coordinates: [Hyper.Coordinate]) -> some View {
        
        let color = (hyperModel.hyper.getValue(at: coordinates) as? Color) ?? Color.black
        return color.frame(width: 20, height: 12)
            .border(Color.white)
    }
    
    var body: some View {
        //Picker ("Corner:", selection: $selectedCoordinates) {
        //List ("choose corner")   { 
        List(0..<axes.cornersCountForThisSpace, 
             id: \.self) {index in
            let coordinates = axes.coordinatesOfCorner(index: index, as: Hyper.Coordinate.self) 
            let t = "\(coordinates.map {"\($0.position)"}.joined(separator: " "))"
            
            let color = cornerColorImage(for: coordinates)
                
            
            Button(action: {
                print ("och")
                axes.setCoordinates(coordinates)
            }) {
                LabeledContent(content: { color }, 
                               label: {Text("\(t)")})
                
                //                    LabeledContent("\(t)", 
                //                                   content: {
                //                        HStack {
                //                            Text ("Och")
                //                            color.frame(width: 26, height: 22)
                //                        }
                //                    })
                // Label("\(t)", image: color) 
            }
            
            
            //.tag(coordinates  as [T.Coordinate]?)
            //})
        }
        //            if selectedCoordinates == nil {
            //                let t = "\(axes.map {"\($0.shortName)\($0.position)"}.joined(separator: " "))"
            //                Text("\(t)").tag(nil as [T.Coordinate]?)
            //            }
       // }
//        .onAppear {
//            selectedCoordinates = axes.getCurrentCoordinates()
//        }.onChange(of: selectedCoordinates) {old, new in
//            if let new {
//                axes.setCoordinates(new)
//            }
//        }.onChange(of: axes.coordinates() as [T.Coordinate]) {old, new in
//            if new.isCorner {
//                selectedCoordinates = new
//            } else {
//                selectedCoordinates = nil
//            }
//        }
        // .pickerStyle(PopUpButtonPickerStyle())
//        @MainActor func render() {
//            let renderer = ImageRenderer(content: cornerColorImage(for: <#T##[T.Coordinate]#>))
//            
//            // make sure and use the correct display scale for this device
//            renderer.scale = displayScale
//            
//            if let uiImage = renderer.uiImage {
//                renderedImage = Image(uiImage: uiImage)
//            }
//        }
    }
}
/*
 Menu("Sub Menu") {
 Button(action: {}, label: {
 Text("Sub Item 1")
 })
 Button(action: {}, label: {
 Text("Sub Item 2")
 })
 Button(action: {}, label: {
 Text("Sub Item 3")
 })
 }
 */
