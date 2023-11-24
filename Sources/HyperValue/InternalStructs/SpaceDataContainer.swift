//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 22/11/2023.
//

import Foundation

public struct SpaceInterpolableContainer<D, C>: CorrectionProtocol, Hashable
where D: IntepolableProtocol,
      C: CoordinateProtocol,
      C.Axis: AxisProtocol,
      C.Axis: HasCoordinateProtocol
{
    
    public typealias Interpolable = D
    public typealias Corner = CornerContainer<D>
    public typealias Coordinate = C
    public init() {
        self.data = Interpolable()
        self.strength = .correction
        self.coordinates = []
    }
    
    
    public typealias Coord = C
    
    
    public var data: Interpolable
    public var coordinates: [Coord]
    public var strength: InterpolableStrength
    
    public init(at coordinates: [Coord]) {
        self.init()
        self.coordinates = coordinates
    }
    
    public init(value: Interpolable, 
         at coordinates: [Coord], 
         strength: InterpolableStrength) {
        
        self.data = value
        self.coordinates = coordinates
        self.strength = strength
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates)
        
    }
}
extension SpaceInterpolableContainer: CustomStringConvertible{}

///Protocol for vertices containg interpolatable data. Most important building block.
///
///As ``SpaceVertexProtocol`` describes only position in space, `InterpolableVertexProtocol` could contain data assgined to this vertex. You can understand it as a *”some color or number at coordinates of this vertex”*. Basic building block of interpolated hyperspace.


public extension SpaceInterpolableContainer {
    static func ==  (lhs: Self, rhs: Self) -> Bool {
        guard lhs.coordinates == rhs.coordinates else {return false}
        guard lhs.data == rhs.data else {return false}
        guard lhs.strength == rhs.strength else {return false}
        return true
    }
}

extension SpaceInterpolableContainer {
    public var description:String {
        return "\(strength) \(Interpolable.self) \(data) @ \(coordinates)"
    }
}

public extension SpaceInterpolableContainer 
where C.Axis: AxisProtocol {
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
