//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
    /// Adds axis to hyperValue.
    /// - Parameters:
    ///   - axis: axis to add
    ///   - allAxes: environment axis, necessary to keep same order in all hypervalues
    func add(axis: Axis, from allAxes: [Axis]) throws {
        guard !containAxis(axis) else { throw HyperValueErrors.couldNotAdd(axis.name)}
        
        let newAxes = allAxes.sort(array: internalAxes+[axis], by: \.self)
        
        
        //guard let axisIndex = newAxes.firstIndex(of: axis) else {return}
        for index in corrections.indices {
            self.corrections[index].coordinates
                .append(Coordinate(on: axis, position: .min))
        }
        corners = corners + corners
        
        internalAxes = newAxes
    }
}
