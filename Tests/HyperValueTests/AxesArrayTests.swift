import XCTest
@testable import HyperValue

final class AxesArrayTests: XCTestCase {

    let axisX = MyAxis(name: "X", bounds: 0...1000)
    let axisY = MyAxis(name: "Y", bounds: 0...1000)
    let axisZ = MyAxis(name: "Z", bounds: 0...1000)
    
    let allAxes = [ 
        MyAxis(name: "A", bounds: 0...1000),
        MyAxis(name: "B", bounds: 0...1000),
        MyAxis(name: "C", bounds: 0...1000),
//                    MyAxis(name: "D", bounds: 0...1000),
//                    MyAxis(name: "E", bounds: 0...1000),
//                    MyAxis(name: "F", bounds: 0...1000),
        //            MyAxis(name: "G", bounds: 0...1000),
        //            MyAxis(name: "H", bounds: 0...1000),
        //            MyAxis(name: "I", bounds: 0...1000)
    ]
    
    func testArrayCoordinates<C>(as: C.Type) throws 
    where C: CoordinateProtocol,
          C.Axis == MyAxis
    {
        for i in 0..<allAxes.count {
            let axes: [C.Axis] = Array(allAxes[0...i])
            for i in 0..<axes.cornersCountForThisSpace {
                let coordinates = axes.coordinatesOfCorner(index: i,
                                                           as: C.self)
                let j = axes.indexOf(coordinates: coordinates) ?? -1
                XCTAssert(i == j)
            }
        }
    }
    
    func testSlicesArray() throws {
        for i in 0..<allAxes.count {
            let axes: [MyAxis] = Array(allAxes[0...i])
            let dividers =  [Hyper.Correction(value: CGPoint(), 
                                              at: randomCoordinates(for: axes) as [Hyper.Coordinate], 
                                                  strength: .correction),
                             Hyper.Correction(value: CGPoint(), 
                                                  at: randomCoordinates(for: axes) as [Hyper.Coordinate], 
                                                  strength: .correction)
            ]
            for i in 0..<axes.count {
                dividers.forEach({print("\($0.coordinates[i])")})
                axes.slices(for: i, dividers: dividers.map{$0.coordinates})
                    .forEach({print("Slice: \($0)") })
                print()
            }
            print ("------------*----------------")
        }
    }
}

