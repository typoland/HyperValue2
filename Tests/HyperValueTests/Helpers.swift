//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 10/11/2023.
//

import Foundation
import HyperValue
import XCTest
@testable import HyperValue

var GLOBAL_AXES = [
    MyAxis(name: "X", bounds: 0...1000),
    MyAxis(name: "Y", bounds: 0...1000),
//    MyAxis(name: "Z", bounds: 0...1000),
//    MyAxis(name: "A", bounds: 0...1000),
//    MyAxis(name: "B", bounds: 0...1000)
]
var GLOBAL_VERTICES = [
    Hyper.Correction(value: CGPoint(x: 0, y: 1000), at: GLOBAL_AXES.makeCoordinates(0,0,0), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 100, y: 900), at: GLOBAL_AXES.makeCoordinates(1000,0,0), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 200, y: 800), at: GLOBAL_AXES.makeCoordinates(0,1000,0), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 300, y: 700), at: GLOBAL_AXES.makeCoordinates(1000,1000,0), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 400, y: 600), at: GLOBAL_AXES.makeCoordinates(0,0,1000), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 500, y: 500), at: GLOBAL_AXES.makeCoordinates(1000,0,1000), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 600, y: 400), at: GLOBAL_AXES.makeCoordinates(0,1000,1000), strength: .corner),
    Hyper.Correction(value: CGPoint(x: 700, y: 300), at: GLOBAL_AXES.makeCoordinates(1000,1000,1000), strength: .corner),
]

var GLOBAL_CACHED_SPACES : [Hyper.Corner: [SubSpace<MyAxis>]] = [:]
// &[TestCorrectionVertex<CGPoint> : [SubSpace<TestCoordinate.Axis>]

func randomCoordinates(for axes:[MyAxis]) -> [Hyper.Coordinate] {
    var c: [Double] = []
    (0..<axes.count).forEach({ index in
        c.append(Double.random(in: axes[index].bounds))
    })
    return axes.makeCoordinates(c, as: Hyper.Coordinate.self)
}

func centerCoordinates(for axes:[MyAxis]) -> [Hyper.Coordinate] {
    var c: [Double] = []
    (0..<axes.count).forEach { index in
        c.append(((axes[index].upperBound - axes[index].lowerBound) / 2 + axes[index].lowerBound))
    } 
    return axes.makeCoordinates(c, as: Hyper.Coordinate.self)
}

func notSoRandomCoordinates(at position:Double,
                            for axes:[MyAxis]) -> [Hyper.Coordinate] {
    var c: [Double] = []
    (0..<axes.count).forEach { index in
        c.append(position)
    } 
    return axes.makeCoordinates(c, as: Hyper.Coordinate.self) 
}


func randomPoint() -> CGPoint {
    CGPoint(x: Double.random(in: -2000...2000).rounded(), 
            y: Double.random(in: -2000...2000).rounded())
    }

func randomCorrections(for axes: [Hyper.Axis], amount: Int) -> [Hyper.Correction] {
    var result: [Hyper.Correction] = []
    for _ in 0..<amount {
        let z = Hyper.Correction(value: randomPoint(), 
                              at: randomCoordinates(for: axes), 
                              strength: .correction)
        result.append(z)
    }
    return result
}

func notSoRandomCorrections(for axes: [Hyper.Axis], amount: Int) -> [Hyper.Correction] {
    var result: [Hyper.Correction] = []
    for _ in 0..<amount {
        let z = Hyper.Correction(value: randomPoint(), 
                             at: notSoRandomCoordinates(at: Double(Int.random(in: 2...8)*100), for: axes), 
                             strength: .correction)
        result.append(z)
    }
    return result
}


func randomCornerVertices(for axes: [Hyper.Axis]) -> [Hyper.Correction] {
    (axes.cornersCoordinates() as [[Hyper.Coordinate]])
        .map { coordinates in
            Hyper.Correction(value: randomPoint(), at: coordinates, strength: .corner) 
        }
} 

func notSoRandomCorners(for axes: [Hyper.Axis]) -> [Hyper.Interpolable] {
    (axes.cornersCoordinates() as [[Hyper.Coordinate]])
        .map { coordinates in
            let x = coordinates.count > 0 ? coordinates[0].at : 0.0
            var y = coordinates.count > 1 ? coordinates[1].at : 0.0
            y = coordinates.count > 2 ? y + x : 0.0
            let p = CGPoint(x: x, y: y)
            return p
        }
} 


func notSoRandomPoint(for coordinates: [Hyper.Coordinate]) -> CGPoint
{
    typealias Unit = Double
    var x: Unit = 0
    var y: Unit = 0
    for i in 0..<coordinates.count {
        for coordinate in coordinates {
            x = x + coordinate.at * Unit(i+1) / 10 
            y = y + coordinates[i].at * Unit(i+1) / 10
        }
    }
    let div = CGFloat(coordinates.count)
    return CGPoint(x: CGFloat(x)/div, y: CGFloat(y)/div)
    
}

func vertex(at position: Double, 
               type: InterpolableStrength ) -> Hyper.Correction

{
    let c = Array(repeating: position, count: GLOBAL_AXES.count)
    let c2Coords = GLOBAL_AXES.makeCoordinates(c, as: Hyper.Coordinate.self)
    let data = Array(repeating: Hyper.Interpolable.Atom(position), count: Hyper.Interpolable.atomsCount)
    return Hyper.Correction(value: Hyper.Interpolable(atoms: data), 
                          at: c2Coords, 
                          strength: type)
}
