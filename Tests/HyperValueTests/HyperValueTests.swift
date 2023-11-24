import XCTest
@testable import HyperValue

final class HyperValueTests: XCTestCase {
    
   
        
    func testHyperValue() async throws {
        let hyper = Hyper()
        hyper.value = CGPoint(x: 20, y: 30)
     
        for axis in GLOBAL_AXES {
            try hyper.add(axis: axis, from: GLOBAL_AXES)
        }
       
        print ("Corners Count", hyper.corners.count)
        //Make random values on all axes
        for index in 0..<GLOBAL_AXES.cornersCountForThisSpace {
            let coordinates = GLOBAL_AXES.coordinatesOfCorner(index: index, 
                                                              as: Hyper.Coordinate.self)
            //GLOBAL_AXES.setCoordinates(coordinates)
            let value = notSoRandomPoint(for: coordinates)
            hyper.setValue(value: value, on: coordinates)
        }
        //Add random corrections
        let numberOfCorrections = 2
        for _ in 0 ..< numberOfCorrections {
            GLOBAL_AXES.setCoordinates(randomCoordinates(for: GLOBAL_AXES))
            hyper.addCorrection(randomPoint())
        }
        print ("CORRECTIONS", hyper.corrections.count)
        
        
       
        
//        for i in 1...20 {
//            let coordinates = randomCoordinates(for: axes)
//            axes.setCoordinates(coordinates)
//            print ("\(i) Hyper.value \(hyper.isInterpolated ? "(interpolated)" : "(vertex)")\n",hyper.value, coordinates)
//        }
    }
}

//XCTAssert(1 + 1 == 2, "1 + 1 does not equal 2")
//XCTAssertEqual(label.text, "Hello World", "Label text is not equal to 'Hello World'")


//let button = app.buttons["Login"]
//let existence = button.waitForExistence(timeout: 5)
//XCTAssertTrue(existence)
//// The button will now be guaranteed to exist so we can interact with it.
//button.tap()
