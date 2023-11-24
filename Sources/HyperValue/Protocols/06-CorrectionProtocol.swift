//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation

///Protocol for vertices containg interpolatable data. Most important building block.
///
///As ``SpaceVertexProtocol`` describes only position in space, `InterpolableVertexProtocol` could contain data assgined to this vertex. You can understand it as a *”some color or number at coordinates of this vertex”*. Basic building block of interpolated hyperspace.
public protocol CorrectionProtocol: 
                                        CornerProtocol, Equatable where Coordinate: CoordinateProtocol
{
    associatedtype Corner: CornerProtocol
    associatedtype Coordinate: CoordinateProtocol
    
    init (value: Interpolable,
          at coordinates: [ Coordinate ],
          strength: InterpolableStrength)
    var coordinates : [Coordinate] {get set}
}

public extension CorrectionProtocol {
    static func ==  (lhs: Self, rhs: Self) -> Bool {
        guard lhs.coordinates == rhs.coordinates else {return false}
        guard lhs.data == rhs.data else {return false}
        guard lhs.strength == rhs.strength else {return false}
        return true
    }
}

extension CorrectionProtocol {
    public var description:String {
        return "\(strength) \(Interpolable.self) \(data) @ \(coordinates)"
    }
}

public extension CorrectionProtocol where Coordinate.Axis: AxisProtocol {
    var name: String {
        let result = coordinates.reduce(into: "") {s, coord in
            var name = coord.axis.name
            switch coord.position {
            case .max: name = " ▲" + name
            case .min: name = " ▽" + name
            case .number: name = " ○" + name   
            }
            s = s + name
        }
        return result.condenseWhitespace
    }
}

/// Value descibing how *strong* is ``InterpolableVertexProtocol`` vertex data. Temporary added vertices before mixing layers have value 0.0<x<1.0, corners have always 0.0 and corrections sholud be equal 1.0


//public enum InterpolableStrength: Hashable {
//    case corner
//    case correction
//    case any(Double)
//    
//    init (rawValue number: Double) {
//        if number == 0 {self = .corner}
//        else if number == 1 {self = .correction}
//        else {self = .any(number)
//        }
//    }
//    
//    var value: Double {
//        switch self {
//        case .corner: {return 0.0}()
//        case .correction: {return 1.0}()    
//        case .any(let value): {return value}()
//        }
//    }
//    
//    public static func == (lhs:Self, rhs:Self) -> Bool {
//        lhs.value == rhs.value
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(value)
//    }
//}
//
//extension InterpolableStrength: CustomStringConvertible {
//    var s:String {
//        switch self {
//        case .corner: return "⬜︎"
//        case .correction: return "⬛︎"
//        case .any(let number): return "⚫︎\(number.formatted(.number.precision(.fractionLength(2...2))))"
//        }
//    }
//    public var description: String {
//        "\(s)"
//    }
//}
//public typealias InterpolableStrength = Double
//extension InterpolableStrength : BinaryFloatingPoint {
//    static var corner = 0.0
//    static var correction = 1.0
//}
