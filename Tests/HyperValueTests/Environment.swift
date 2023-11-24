//
//  Environment.swift
//  CombinePlayTests
//
//  Created by Łukasz Dziedzic on 06/11/2023.
//

import Foundation
import Observation
import HyperValue

typealias Hyper = HyperValue<CGPoint, MyAxis>

class MyAxis: AxisProtocol, HasCoordinateProtocol, ObservableObject {
   // var axisInstances: [AxisStyleInstance] = []
    
    
   // typealias AxisStyleInstance = AxisInstance
    
    static var defaultName: String = ""
    static var defaultShortName: String = ""
    static var defaultBounds: ClosedRange<Double> = 0...1000
    
    var name: String
    var upperBound: Double
    var lowerBound: Double
    var position: PositionOnAxis
  
    required init(name: String, bounds: ClosedRange<Double>) {
        self.name = name
        self.lowerBound = bounds.lowerBound
        self.upperBound = bounds.upperBound
        self.position = .min
    }
}

extension MyAxis {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(bounds)
        //hasher.combine(axisInstances)        
    }
}
extension MyAxis: CustomStringConvertible {}


//struct TestCoordinate: SpaceCoordinateProtocol {
//        
//    typealias Axis = MyAxis
//    typealias CoordUnit = MyAxis.Unit
//    
//    var axis: Axis
//    var position: PositionOnAxis
//    
//    init(on axis: Axis, position: PositionOnAxis) {
//        self.axis = axis
//        self.position = position
//    }
//    
//    init(on axis: Axis, at position: Double) {
//        self.axis = axis
//        self.position = PositionOnAxis(axis: axis, at: position)
//    }
//}
//
//extension TestCoordinate: CustomStringConvertible{}

//struct TestCornerVertex<Interpolable: IntepolableProtocol>: CornerProtocol {
//    init() {
//        self.data = Interpolable()
//        self.strength = .corner
//    }
//    
//    let id = UUID()
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    var data: Interpolable
//    
//    static func == (lhs: TestCornerVertex<Interpolable>, rhs: TestCornerVertex<Interpolable>) -> Bool {
//        lhs.data == rhs.data
//    }
//    
//    typealias Interpolable = Interpolable
//    
//    var strength: InterpolableStrength
//}
//extension TestCornerVertex: CustomStringConvertible{}
//
//
//struct TestCorrectionVertex<Interpolable: IntepolableProtocol>: CorrectionProtocol {
//    
//    typealias Interpolable = Corner.Interpolable
//    typealias Corner = TestCornerVertex<Interpolable>
//    
//    init() {
//        self.data = Interpolable()
//        self.strength = .correction
//        self.coordinates = []
//    }
//
//    
//    //typealias Interpolable = Interpolable
//    
//    
//    typealias Coord = TestCoordinate
//
//    
//    var data: Interpolable
//    var coordinates: [Coord]
//    var strength: InterpolableStrength
//    
//    init(at coordinates: [Coord]) {
//        self.init()
//        self.coordinates = coordinates
//    }
//    
//    init(value: Interpolable, 
//         at coordinates: [Coord], 
//         strength: InterpolableStrength) {
//        
//        self.data = value
//        self.coordinates = coordinates
//        self.strength = strength
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(coordinates)
//        
//    }
//}
//extension TestCorrectionVertex: CustomStringConvertible{}

