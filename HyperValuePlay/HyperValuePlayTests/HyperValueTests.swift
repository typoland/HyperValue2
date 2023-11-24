//
//  CombinePlayTests.swift
//  CombinePlayTests
//
//  Created by Łukasz Dziedzic on 02/11/2023.
//

import XCTest
import HyperValue


final class MyAxis: AxisProtocol, HasCoordinateProtocol {
    var name: String
    var upperBound: Double
    var lowerBound: Double
    var position: PositionOnAxis 
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    init(name: String, bounds: ClosedRange<Double>){
        self.name = name
        self.lowerBound = bounds.lowerBound
        self.upperBound = bounds.upperBound
        self.position = .min
    }
}

final class HyperValueTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        typealias HP = HyperValue<CGPoint, MyAxis>
        typealias Coordinate = HP.Coordinate
        let hyper = HP()
        let W = MyAxis(name: "width", bounds: 0...1000)
        let H = MyAxis(name: "height", bounds: 0...500)
        let C = MyAxis(name: "contrast", bounds: 30...600)
        let allAxes = [W, H, C]
        let cW = Coordinate(on: W, at: 500)
        let cH = Coordinate(on: H, position: .min)
        let cC = Coordinate(on: C, position: .max)
        let p = CGPoint(x: 100, y: 300)
       
        print (hyper.value)
        try hyper.add(axis: W, from: allAxes)
        try hyper.add(axis: H, from: allAxes)
        try hyper.add(axis: C, from: allAxes)
        //print (hyper.currentCoordinates)
        hyper.corners.forEach({print ("corner: \($0)")})
    
        W.position = .min
        H.position = .min
        C.position = .min
        //print (hyper.currentCoordinates)
        hyper.value = CGPoint(x: 100, y: 100)
        W.position = .max
        H.position = .min
        C.position = .min
        hyper.value = CGPoint(x: 300, y: 800)
        W.position = .min
        H.position = .max
        C.position = .min
        hyper.value = CGPoint(x: 234, y: 888)
        W.position = .max
        H.position = .max
        C.position = .min
        hyper.value = CGPoint(x: 678, y: 987)
        W.position = .min
        H.position = .min
        C.position = .max
        hyper.value = CGPoint(x: 45, y: 100)
        W.position = .max
        H.position = .min
        C.position = .max
        hyper.value = CGPoint(x: 345, y: 456)
        W.position = .min
        H.position = .max
        C.position = .max
        hyper.value = CGPoint(x: 456, y: 566)
        W.position = .max
        H.position = .max
        C.position = .max
        hyper.value = CGPoint(x: 111, y: 676)
        print (hyper.value)
        W.position = .number(0)
        H.position = .number(0)
        C.position = .number(0)
        print ("\n\nBefore", hyper.value)
        let coord = allAxes.makeCoordinates([120.09, 123, 312], as: Coordinate.self)
        hyper.setValue(value: CGPoint(x: 16, y: 1200), on: coord)
                  
        hyper.corrections.forEach({correction in
            print("Correction")
            correction.coordinates.forEach({print("\t\($0)")})
        })

      
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
