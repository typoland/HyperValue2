//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 22/11/2023.
//

import Foundation

struct SubSpace<Axis:AxisProtocol> {
    let axes: [Axis]
    let corners: [any CornerProtocol]
}

extension SubSpace {
    
    func contains<C>(coordinates: [C]) -> Bool
    where C: CoordinateProtocol,
          C.Axis == Axis  
    {
        var OK = true
        let coordinates = coordinates.adapt(to: axes)
        for axis in axes {
            if let coordinate = coordinates.first(where: {$0.axis.name == axis.name}) {
                OK = OK && axis.bounds.contains( coordinate.at )
            }
            guard OK else {
                return false}
        }
        return true
    }
}

extension SubSpace: CustomStringConvertible {
    var description: String {
        "\(corners.map{ "\(axes.count) axes:\($0.strength)"} )"
    }
}
