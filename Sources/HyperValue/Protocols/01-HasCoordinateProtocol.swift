
import Foundation
///Protocol for objects which has position inside some bounds. Used by ``StyledAxisProtocol``
public protocol HasCoordinateProtocol {
    
    /// Bounds for position. ``AxisCoordinate`` `.min`, will have value of `bounds.lowerBound`, `.max` will have `bounds.upperBound`
    var bounds: ClosedRange<Double> { get set }
    
    ///``AxisCoordinate`` could be `.min` (lowerBound), `.max` (upperBound) or some position on styled axis.
    var position: PositionOnAxis { get set }
}

public extension HasCoordinateProtocol {
    ///Absolut position on Axis
    var at: Double {
        get {
            switch position {
            case .max:
                return bounds.upperBound
            case .min:
                return bounds.lowerBound
            case .number(let number):
                return number
            }
        }
        set {
            switch newValue {
            case bounds.lowerBound:
                position = .min
            case bounds.upperBound:
                position = .max
            default:
                position = .number(newValue)
            }
        }
    }
}
