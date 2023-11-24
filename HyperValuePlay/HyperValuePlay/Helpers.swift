//
//  Helpers.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 18/11/2023.
//

import Foundation
import HyperValue
import SwiftUI

typealias HyperColor = HyperValue<Color, MyAxis>

typealias Coordinate = HyperColor.Coordinate
typealias Correction = HyperColor.Correction
typealias Corner = HyperColor.Corner
typealias Interpolable = HyperColor.Interpolable

func randomCorrection(at: [Coordinate], 
                         atomValueRange: ClosedRange<Double>,
                         strength: InterpolableStrength = .corner) -> Correction


{

    typealias T = Correction.Interpolable
    let random = (0..<T.atomsCount).map {_ in T.Atom(Double.random(in: atomValueRange))}
    let data = T(atoms: random)
    return Correction(value: data,  
                      at: at,  
                      strength: strength)
}



extension IntepolableProtocol {
    init (fit atoms: [Self.Atom], add value: Self.Atom = 1) {
        var data = atoms
        switch atoms.count {
        case let i where i < Self.atomsCount: data = data + Array(repeating: value, count: Self.atomsCount - i)
        case let i where i > Self.atomsCount: data.removeLast(i - Self.atomsCount)
        default: break    
        }
        guard data.count == Self.atomsCount else {fatalError()}   
        self = Self(atoms: data)
    }
}

func notRandomCorrection(
                            at: [Coordinate], 
                            range: ClosedRange<Double>,
                            strength: InterpolableStrength = .corner,
                            convertCoordsToAtom: (Double) -> Color.Atom = {Color.Atom($0)})
-> HyperColor.Correction
{
    
    let delivered = at.map { convertCoordsToAtom ($0.at)}
    let data = Color(fit: delivered)
    
    return Correction(value: data,  
                        at: at,  
                        strength: strength)
}

let v1 = randomCorrection(at: [], atomValueRange: 0.0...1.0) as Correction


var GLOBAL_AXES = [
    MyAxis(name: "A", bounds: 0...1000, shortName: "a"),
    MyAxis(name: "B", bounds: 0...1000, shortName: "b"),
    MyAxis(name: "C", bounds: 0...1000, shortName: "c"),
//    MyAxis(name: "D", bounds: 0...1000, shortName: "d"),
]

var GLOBAL_VERTICES = GLOBAL_AXES.vertexNumbers.map {index in
    randomCorrection(at: GLOBAL_AXES.coordinatesOfCorner(index: index, as: Coordinate.self), 
                     atomValueRange: 0.0...1.0) as Correction
}


func makeGlobalHyper(axes: [MyAxis]) -> HyperColor 
{
    let corners = axes.vertexNumbers.map {index in
        let coordinates = (GLOBAL_AXES.coordinatesOfCorner(index: index, 
                                                           as: Coordinate.self) )
        let data = Color(fit: coordinates.map {Color.Atom((1000.0-$0.at)/1000.0)})
        return data
    }
    
    
    let correctionsNumber = 3
    var corrections: [Correction] = []
    let correctionsCoordinates : [[Coordinate]] = [
        axes.map { Coordinate(on: $0, at: ($0.upperBound - $0.lowerBound) / 2 + $0.lowerBound) },
        axes.makeCoordinates([300.0, 200, 300, 200], as: Coordinate.self),
        axes.makeCoordinates([700.0, 600, 600, 800], as: Coordinate.self)
    ]
    
    let colors = [Color(atoms: [0,0,0,1]),
                  Color(atoms: [1,0,0.6,1]),
                  Color(atoms: [0.3,0,1,1])]
    
    for i in 0..<correctionsNumber {
        var correction = randomCorrection(at: correctionsCoordinates[i], 
                                          atomValueRange: 0...1, 
                                          strength: .correction) as Correction
        correction.data = colors[i]
        corrections.append(correction)
    }
    let hyper = HyperColor(corners: corners, 
                                            corrections: corrections, 
                                            axes: axes)
    return hyper
    
}  
var GLOBAL_HYPER = makeGlobalHyper(axes: GLOBAL_AXES)
