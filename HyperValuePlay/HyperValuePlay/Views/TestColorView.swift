//
//  TestColorView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 12/11/2023.
//

import HyperValue
import SwiftUI

struct TestColorView<Interpolable, Axis>: View

where Interpolable: IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol

{
    @Binding var hyper: HyperValue<Interpolable, Axis>?
    @AppStorage("HyperInamgePixelSize") var resolution: Int = 150
    //@State var resolution: Int = 150
    @State var image: Image?
    @Bindable var axesModel: GlobalAxesModel<Axis>
    
    func hyperImage(size: CGSize) -> Image? {
        if let hyper, hyper.value is Color {
            let graph = Graph { x, xRange, y, yRange in
                hyper.colorOn(x: x, xSteps: xRange, y: y, ySteps: yRange)!
            }
            return Image(nsImage: NSImage(size: size,
                                          actions: graph.draw(xSteps: Int(size.width / Double(resolution)),
                                                              ySteps: Int(size.height / Double(resolution)))))
        }
        return nil
    }
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                hyperImage(size: proxy.size)
                    .scaledToFit()
            }.drawingGroup(opaque: true)
            
            HStack {
                SubmitAfterEnterNumberView(value: Binding(get: { Double(resolution) },
                                                          set: { resolution = Int($0) }))
            }
        }.onChange(of: axesModel.axes) {old, new in
            print ("AXES CHANGED IN VIEW", new)
        }
    }
}

#Preview {
    
    typealias Hyper = HyperValue<Color, MyAxis>
    typealias AxesModel = GlobalAxesModel<Hyper.Coordinate.Axis>
    let colors = [Color(red: 0, green: 1, blue: 0, opacity: 1),
                  Color(red: 1, green: 1, blue: 1, opacity: 1),
                  Color(red: 1, green: 0, blue: 0, opacity: 1),
                  Color(red: 1, green: 0, blue: 1, opacity: 1),
                  Color(red: 0, green: 1, blue: 0, opacity: 1),
                  Color(red: 0, green: 1, blue: 1, opacity: 1),
                  Color(red: 0, green: 0, blue: 0, opacity: 1),
                  Color(red: 0, green: 0, blue: 1, opacity: 1)]
    
    var axes = [
        Hyper.Coordinate.Axis(name: "x", bounds: 0...1000),
        Hyper.Coordinate.Axis(name: "y", bounds: 0...1000),
        Hyper.Coordinate.Axis(name: "z", bounds: 0...1000)
    ]
    for index in axes.indices {
        axes[index].at = 1000
    }
    
    let corners = (0 ..< axes.cornersCountForThisSpace).map { index in
        colors[index]
    }
    let colorCorrection1 = Color(red: 1, green: 1, blue: 1)
    let coords1 = axes.makeCoordinates(Array(repeating: 200.0, count: axes.count), 
                                       as: Hyper.Coordinate.self)
    let correction1 = Hyper.Correction(value: colorCorrection1, at: coords1, strength: .correction)
    
    let colorCorrection2 = Color(red: 1, green: 1, blue: 1)
    let coords2 = axes.makeCoordinates(Array(repeating: 700.0, count: axes.count), 
                                       as: Hyper.Coordinate.self)
    let correction2 = Hyper.Correction(value: colorCorrection2, at: coords2, strength: .correction)
   
    @State var hyper : Hyper? = Hyper(corners: corners,
                                                corrections: [correction1, correction2],
                                                axes: axes)
    @State var axesModel: AxesModel = AxesModel(axes: axes, selectedAxis: nil) 
    return TestColorView(hyper: $hyper, axesModel: axesModel)
}
