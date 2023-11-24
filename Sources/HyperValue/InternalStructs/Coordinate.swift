//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 22/11/2023.
//

import Foundation
public struct AxisCoordinate<A>: CoordinateProtocol
where A: AxisProtocol,
      A: HasCoordinateProtocol
{
    
    public typealias Axis = A
    
    public var axis: Axis
    public var position: PositionOnAxis
    
    public init(on axis: Axis, position: PositionOnAxis) {
        self.axis = axis
        self.position = position
    }
    
    public init(on axis: Axis, at position: Double) {
        self.axis = axis
        self.position = PositionOnAxis(axis: axis, at: position)
    }
}

extension AxisCoordinate: CustomStringConvertible{}
