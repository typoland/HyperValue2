//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation

public protocol CoordinateProtocol: HasCoordinateProtocol, Hashable, Comparable
where Axis: AxisProtocol
{
    associatedtype Axis: AxisProtocol
    var axis: Axis { get set }
    var position: PositionOnAxis {get set}
    init(on axis: Axis, position: PositionOnAxis)
    init(on axis: Axis, at : Double)
}

