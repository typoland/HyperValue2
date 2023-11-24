import XCTest
@testable import HyperValue



final class CorrectedValueTest: XCTestCase {
    
    
    func testSubspaceAxes() throws {
        let c1 = Array(repeating: 750.0, count: GLOBAL_AXES.count)
        let c1Coords = GLOBAL_AXES.makeCoordinates(c1, as: Hyper.Coordinate.self)
        let correction1 = Hyper.Correction(value: CGPoint(x: 750, y: 750), 
                                         at: c1Coords, 
                                         strength: .correction)
        
        let c2 = Array(repeating: 250.0, count: GLOBAL_AXES.count)
        let c2Coords = GLOBAL_AXES.makeCoordinates(c2, as: Hyper.Coordinate.self)
        let correction2 = Hyper.Correction(value: CGPoint(x: 250, y: 250), 
                                         at: c2Coords, 
                                         strength: .correction)
        
        let c3 = Array(repeating: 500.0, count: GLOBAL_AXES.count)
        let c3Coords = GLOBAL_AXES.makeCoordinates(c3, as: Hyper.Coordinate.self)
        let start = Date.now
       
            let shortAxes = GLOBAL_AXES.subspaceAxes(dividedBy: [correction1, correction2], 
                                                            for: c3Coords)
        print ("✅\(#function) Test is done with result:\n", shortAxes, shortAxes , "\nin \(Date.now.timeIntervalSince(start))s")
      
    }
    
    func testInterpolableStrength() throws {
        let vertices = ( GLOBAL_AXES.cornersCoordinates() as [[Hyper.Coordinate]])
            .map { coordinates in
                Hyper.Correction(value: randomPoint(), at: coordinates, strength: .corner) 
            }
        
        let correction = Hyper.Correction(value: randomPoint(), 
                                      at: centerCoordinates(for: GLOBAL_AXES),
                                      strength: .correction)
        vertices.forEach({print ("\(#function) VERTEX", $0)})
        print ("\(#function) CORRECTION", correction)
        
        let randomCoordinates = notSoRandomCoordinates(at: 250, for: GLOBAL_AXES)
        Task<Void,Error> {
            let start = Date.now
            var cache: [Hyper.Correction:[SubSpace<Hyper.Axis>]] = [:]
            let r = Hyper.interpolateVertex(for: correction,
                                                   in: vertices, 
                                            on: randomCoordinates, 
                                            cachedSpaces: &cache)
            print ("✅\(#function) \(r) in \(Date.now.timeIntervalSince(start).formatted())")
        }
    }
    

    func testTrueValue() async throws {
        let corners = notSoRandomCorners(for: GLOBAL_AXES)
        let middle = centerCoordinates(for: GLOBAL_AXES)
        var corrections = notSoRandomCorrections(for: GLOBAL_AXES, amount: 4)
        corrections[0].coordinates = middle
        corrections[0].data = CGPoint(x: -1000, y: -1000)
        corrections[1].coordinates = notSoRandomCoordinates(at: 250, for: GLOBAL_AXES)
        corrections[1].data = CGPoint(x: -1000, y: -1000)
        // print (corners.count, corrections.count)
        
        
        let start = Date.now
        //Task<Void, Error> {
        let hyper = Hyper(corners: corners, 
                          corrections:corrections, 
                          axes: GLOBAL_AXES)
        //let coordinates = notSoRandomCoordinates(at: 499, for: GLOBAL_AXES)
        let numberOfValues = 200
        for _ in 0..<numberOfValues {
            let coordinates = randomCoordinates(for: GLOBAL_AXES) as [Hyper.Coordinate]
            let s = hyper.interpolatedContainer(at: coordinates) 
            print (s.data)
        }
        print ("\n✅\(#function) \(numberOfValues) values in \(Date.now.timeIntervalSince(start))s.")
    }
    
    
//    func testDefineMissingCornerss() throws {
//        
//        
//        Task {
//            var vertices =  [ Hyper.Vertex(at: GLOBAL_AXES.cornersCoordinates()[0]),
//                              Hyper.Vertex(at: GLOBAL_AXES.cornersCoordinates()[3])
//            ]
//            vertices[0].data = CGPoint(x: 1000, y: 1000)
//            do {
//                let s = Hyper.defineMissingCorners(for: vertices, axes: GLOBAL_AXES)
//                print (s.count)
//                vertices.forEach({print ("\(#function) DEFINED", $0)})
//                s.forEach({ print ("✅\(#function) NEW", $0)})
//            }
//        }
//    } 
    
    
}
