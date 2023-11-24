//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 09/11/2023.
//

import Foundation
public extension HyperValue 

{
    
    /// Value of HyperValue object at current coordinates,  `set` works only for defined corners or corrections
    var value: Interpolable {
        get {
            self.getValue(at: valueCoordinates)
        }
        set {
            setValue(value: newValue, on: valueCoordinates)
        }
    }
    
    @discardableResult
    func setValue(value: Interpolable, on coordinates: [Coordinate]) -> Bool {
        if let index = internalAxes.indexOf(coordinates: coordinates) {
            let new = Corner(value: value)
            resetCache()
            corners[index] = new
            return true
        }
        guard let vertexIndex = corrections.firstIndex(where: {$0.coordinates == coordinates}) 
        else { return false }
        resetCache()
        corrections[vertexIndex].data = value
        return true
    }
    
    func getValue(at coordinates: [Coordinate]) -> Interpolable {
        self.interpolatedContainer(at: coordinates).data as! Interpolable
    }
    
    var valueCoordinates: [Coordinate]   {
        internalAxes.coordinates()
    }
    

}
