//
//  HyperViewImage.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 20/11/2023.
//


import SwiftUI
import HyperValue

extension HyperValue 
{
    
    func colorOn(x:Int, xSteps: Int, y: Int, ySteps:Int) -> CGColor? {
        
        func coordinate(on axis: Coordinate.Axis, step: Int, steps: Int) -> Coordinate {
            let bounds = axis.bounds
            let at = (bounds.upperBound - bounds.lowerBound) * Double(step) / Double(steps)
            return Coordinate(on: axis, at: at)
        }
        
        var coordinates = [Coordinate]()
        if internalAxes.count == 0 {
            return (corners[0].data as! Color).cgColor ?? CGColor.clear
        }
        if internalAxes.count >= 1 {
            coordinates.append(coordinate(on: internalAxes[0], step: x, steps: xSteps))
        }
        if internalAxes.count >= 2 {
            coordinates.append(coordinate(on: internalAxes[1], step: y, steps: ySteps))
        }   
        if internalAxes.count >= 3 {
           
            for i in 2..<internalAxes.count {
                coordinates.append(Coordinate(on: internalAxes[i], at: internalAxes[i].at ))
            }
        }
        //print ("countng third axis \(coordinates)")
        if let value = getValue(at: coordinates) as? Color {
            return value.cgColor
        }
        return nil
        
    }
}

