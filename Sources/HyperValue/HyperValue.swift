// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Observation

final public class HyperValue<D, A>: Equatable, Hashable, Identifiable
where  D: IntepolableProtocol,
       A: AxisProtocol,
       A: HasCoordinateProtocol

{
    //TYPEALIASES  
    public typealias Corner = CornerContainer<D>
    
    public typealias Coordinate = AxisCoordinate<A>
    public typealias Correction = SpaceInterpolableContainer<D,Coordinate>
    public typealias Axis = A
    public typealias Interpolable = D

    public typealias ID = UUID
    public var id: UUID = UUID()
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    //VARIABLES    
    public internal (set) var corners: [any CornerProtocol] 
    public internal (set) var corrections: [Correction] = []
    public internal (set) var internalAxes: [Axis] = [] 
    
    //CACHE
    var cachedValue: Correction! 
    var cachedCoordinates : [Coordinate] = []
    var cachedCorrectionsSpaces: [Correction: [SubSpace<Correction.Coordinate.Axis>]] = [:]
 
    
    
    //MARK: init(vertices: [Vertex], axes: [Axis])
    /// Creates multidimensional HyperValue
    /// - Parameters:
    ///   - corners: array of `SpaceIntepolable` values
    ///   - corrections: array of `SpaceIntepolable` values with coordiantes
    ///   - axes: axes, in which bounds filnal value will be interpolated
    ///   Nuber of corners must be 2^axes.count
    ///   For three dimensional space you have to deliver 8 corners.
    ///   Order cholud be 
    ///   ```
    ///   in XYZ space:
    ///   000, 100, 010, 110, 001, 101, 011, 111,
    public required convenience init(corners: [Interpolable],
                                     corrections: [Correction],
                                     axes: [Axis])
    {
        precondition(!corners.isEmpty, "vertices array could not be empty")
        let dim = (log2( Double(corners.count)))
        precondition(dim == dim.rounded(), "must be \(1<<corners.count) vertices")
        
        self.init()
        self.corners = corners.map {Corner(value: $0)}
        self.corrections = corrections.map{Correction(value: $0.data, 
                                                      at: $0.coordinates, 
                                                      strength: $0.strength)}
        self.internalAxes = axes 
    }
    
    
    
    //MARK: init()
    
    /// Creates zero-dimensional HyperValue.
    public required init() {
        self.corners = [Corner(value: Interpolable())]
        self.internalAxes = []
    }
}

extension HyperValue {
    public static func == (lhs: HyperValue, rhs: HyperValue) -> Bool {
        return lhs.corners as? [Corner] == rhs.corners as? [Corner]
        && lhs.corrections == rhs.corrections
    }
}
