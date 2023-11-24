import XCTest
@testable import HyperValue

extension Array {
    func fitToElements(number: Int, if missing: (Int) -> ([Element])) -> Self {
        var result = self
        switch result.count {
        case let i where i < number: result = result + missing(number - 1)//Array(repeating: self[0], count: number - i)
        case let i where i > number: result.removeLast(i - number)
        default: break   
        }
        return result
    }
}


final class InterpolateTests: XCTestCase {
    
    typealias HyperDouble = HyperValue<Double, MyAxis>    
    func testInterpolateInterpolable() throws {
        print (linearInterpolation(between: 100.0, and: 200.0, 
                                   in: (0.0...1000.0), 
                                   at: 500.0))
    }
    
    
    func testOneDimensionInterpolate() throws {
        
        let axis = GLOBAL_AXES[0]
        let coords = [axis].coordinatesOfCorner(index: 1, 
                                                as: Hyper.Coordinate.self) 
        let vertexA = HyperDouble.Corner(value: 100.0)
        let vertexB = HyperDouble.Corner(value: 1000.0)
        let vertexC = HyperDouble.Correction(value: 500.0, 
                                           at: coords, 
                                           strength: .correction) 
        
        let range = axis.upperBound - axis.lowerBound
        let steps = 8
        for i in 0...steps {
            let step = range/Double(steps) * Double(i)
            let coords = [axis].makeCoordinates(step) as [Hyper.Coordinate]
            let vertex = HyperDouble.Correction(from: [vertexA, vertexC], at: coords)
            print (step, vertex.data, vertex.strength)
        }
    }
    
    func testInterpolate() throws {
        var corners:[any CornerProtocol]  = []
        ( 0..<GLOBAL_AXES.cornersCountForThisSpace )
            .forEach( { index in
                corners.append( Hyper.Corner(value: CGPoint()) )
            })
        let cornerIndexToReplace = 2
        let correctionCoords = GLOBAL_AXES.coordinatesOfCorner(index: cornerIndexToReplace, 
                                                               as: Hyper.Coordinate.self)
        let correction = Hyper.Correction(value: CGPoint(x: 10000, y: 10000), 
                                              at: correctionCoords, 
                                              strength: .correction)
      
        corners[cornerIndexToReplace] = correction 
        corners.forEach({print($0)})
        let time = Date.now
        for _ in 0..<1 {
            let coords = randomCoordinates(for: GLOBAL_AXES)
            
            let vertex = Hyper.Correction(from: corners, at: coords)
            print ("\(vertex.data) \(vertex.strength)")
        }
        print ("✅ in \(String(describing: Date.now.timeIntervalSince(time))).s")
    }
    
    func testPreciseInterpolateFor () {
        let corners = (0..<GLOBAL_AXES.cornersCountForThisSpace)
            .map {i in
                Hyper.Corner(value: CGPoint())
            }
        let correction = Hyper.Correction(value: CGPoint(x: 5000, y: 5000), 
                                          at: centerCoordinates(for: GLOBAL_AXES),
                                          strength: .correction)
        
        let numbers = [250.0 ,500, 250, 222, 398, 450, 945].fitToElements(number: GLOBAL_AXES.count) {missingElementCount in
            Array(repeating: 0, count: missingElementCount)}
        
        let middle = GLOBAL_AXES.makeCoordinates(numbers, as: HyperDouble.Coordinate.self)
        
        var cache: [Hyper.Correction:[SubSpace<Hyper.Axis>]] = [:] 
        
        let result = Hyper.interpolateVertex(for: correction, 
                                in: corners, on: middle,
                                cachedSpaces: &cache)
        print (result)
        print (cache)
    }
    
    func testInterpolateForCorrection() throws {
        let corners = (0..<GLOBAL_AXES.cornersCountForThisSpace)
            .map {i in
                Hyper.Corner(value: CGPoint()
//                                notSoRandomPoint(for: GLOBAL_AXES.coordinatesOfCorner(index: i))
                            // randomPoint()
                )
            }
//        corners.forEach({print ("input \($0)")})
        let correction = Hyper.Correction(value: CGPoint(x: 5000, y: 5000), 
                                          at: centerCoordinates(for: GLOBAL_AXES),
                                          strength: .correction)
        //let coordinates = notSoRandomCoordinates(at: 250, for: GLOBAL_AXES)
        let numbers = [100.0 ,300, 890, 222, 398, 450, 945].fitToElements(number: GLOBAL_AXES.count) {missingElementCount in
        Array(repeating: 0, count: missingElementCount)}
        
        let coordinates = GLOBAL_AXES.makeCoordinates(numbers, as: HyperDouble.Coordinate.self)
        let time = Date.now
        var cache: [Hyper.Correction:[SubSpace<Hyper.Axis>]] = [:]
        let z = Hyper.interpolateVertex(for: correction, 
                                        in: corners, 
                                        on: coordinates, 
                                        cachedSpaces: &cache)
        print ("✅ in \(String(describing: Date.now.timeIntervalSince(time))).s \n\(z)")
    }
    
    func testJoinVertices() throws {
        let corners = (0..<GLOBAL_AXES.cornersCountForThisSpace)
            .map {i in
                Hyper.Corner(value: CGPoint())
            }
        
        print (" Corrections in: ========================")
        let numberOfTests = 100
        let numberOfCorrections = 1
        /*
        let corrections = (0..<numberOfCorrections).map {i in
            Hyper.Correction(value: CGPoint(x: Double(i+1)*1000, y: Double(i+2)*1000), 
                             at: notSoRandomCoordinates(at: Double(i+3)*100, // (i+1) - not on corner
                                                        for: GLOBAL_AXES),
                             strength: .correction)
        }
        */
        let corrections = [Hyper.Correction(value: CGPoint(x: 1000, y: 1000), 
                                      at: centerCoordinates(for: GLOBAL_AXES), 
                                      strength: .correction)]
        corrections.forEach({print($0)})
        print ("======================================")
        let testsNumberRange = 0..<numberOfTests
        let testCoordiantes : [[Hyper.Coordinate]] = testsNumberRange.map {i in
            //randomCoordinates(for: GLOBAL_AXES)
            notSoRandomCoordinates(at: Double(i+1)*100,
                                   for: GLOBAL_AXES)
        }
        let time = Date.now
        var cache: [Hyper.Correction:[SubSpace<Hyper.Axis>]] = [:]
        testCoordiantes.forEach { coordinates in
            
            let z = Hyper.join(corrections: corrections, 
                               in: corners, 
                               on: coordinates, 
                               cachedSpaces: &cache)
           // &[TestCorrectionVertex<CGPoint> : [SubSpace<TestCoordinate.Axis>]
            //print("Joined at", coordinates)
            //print (z)
            //print ("======================================================\n")
           
        }
        print ("cache Size: \(cache.count)") 
        print ("✅ in \(String(describing: Date.now.timeIntervalSince(time))).s \(GLOBAL_AXES.count) dimensions, \(corrections.count) corrections \(testsNumberRange.upperBound) values, ") 
        for (correction, subspaces) in cache {
            print ("key: \(correction.coordinates)")
            subspaces.forEach({subspace in
                subspace.axes.forEach({print($0, terminator: ", ")})
                print()
                subspace.corners.forEach({print($0)})
                print()
            })
        }
    }
}
