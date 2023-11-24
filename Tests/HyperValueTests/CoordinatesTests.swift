import XCTest
@testable import HyperValue

final class CoordinatesTests: XCTestCase {
    
    let axisX = MyAxis(name: "X", bounds: 0...1000)
    let axisY = MyAxis(name: "Y", bounds: 0...1000)
    let axisZ = MyAxis(name: "Z", bounds: 0...1000)
        
    func testCoordinates() throws {
        let axes: [MyAxis] = [axisX, axisY, axisZ]
        //        let coordinates = axes.makeCoordinates(300, 400, 1000) as [Coordinate]
        //        let coordinates1 = axes.makeCoordinates(0, 400, 100) as [Coordinate]
        //        print (coordinates, coordinates1)
        //        coordinates.forEach({print ($0.at)})
        //        coordinates1.forEach({print ($0.position)})
        //        let both = zip(coordinates, coordinates1)
        //        for (c1, c2) in both {
        //            print (c1 == c2)
        //        }
        let coordinates2a = axes.makeCoordinates(0, 40, 0) as [Hyper.Coordinate]
        let coordinates2b: [Hyper.Coordinate] = [
            Hyper.Coordinate(on: axes[0], position: .min),
            Hyper.Coordinate(on: axes[1], position: .number(40)),
            Hyper.Coordinate(on: axes[2], position: .min)
        ]
        
        let coordinates3 = axes.makeCoordinates(100, 200, 300) as [Hyper.Coordinate]
        let coordinates4 = axes.makeCoordinates(600, 700, 800) as [Hyper.Coordinate]
        print ("point zero:",coordinates2a)
        print ("point zero:",coordinates2b)
        print (coordinates2a == coordinates2b)
        print ("point max:",coordinates3)
        print ("point middle:",coordinates4)
        
        
    }
    func testCompareCoordinates() throws {
        let axis = MyAxis(name: "test", bounds: 0...1000)
        let axis2 = MyAxis(name: "test1", bounds: 0...1000)
        let A = Hyper.Coordinate(on: axis, at: 0)
        let B = Hyper.Coordinate(on: axis, at: 500)
        let C = Hyper.Coordinate(on: axis, at: 1000)
        let D = Hyper.Coordinate(on: axis2, at: 500)
        let E = Hyper.Coordinate(on: axis, at: 333)
        let F = Hyper.Coordinate(on: axis, at: 667)
        
        print ("A==A", A == A)
        print ("A<B", A < B)
        print ("A>B", A > B)
        print ("A==B", A == B)
        
        print ("C==C", C == C)
        print ("A<C", A < C)
        print ("A>C", A > C)
        print ("A==C", A == C)
        
        print ("B==B", B == B)
        print ("B<C", A < C)
        print ("B>C", A > C)
        print ("B==C", A == C)
        
        print ("D==A", D == A)
        print ("D==B", D < B)
        print ("D==C", D > C)
        print ("D==D", D == D)
        
        print ("D<A", D < A)
        print ("D<B", D < B)
        print ("D<C", D < C)
        print ("D<D", D < D)
        
        print ("D>A", D > A)
        print ("D>B", D > B)
        print ("D>C", D > C)
        print ("D>D", D > D)
        let s = [B, A, E, C, F]
        
        s.forEach({print("at:", $0.at, $0.position, "(\(axis.lowerBound)...\(axis.upperBound)")})
        let sorted = s.sorted(by: {$0<$1})
        sorted.forEach({print($0)})
    }
}
