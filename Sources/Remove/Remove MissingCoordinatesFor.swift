////
////  File.swift
////  
////
////  Created by Łukasz Dziedzic on 03/11/2023.
////
//
//import Foundation
//extension HyperValue {
//    
//    static func gridCoordinatesFor(corrections:[Vertex], in axes: [Axis])
//    async throws 
//    -> [[Coordinate]] 
//    {
//        
//        var result: [[Vertex.Coordinate]] = []
//        func deep(_ coords: [Coordinate], dim:Int = 0) async throws  {
//            try Task.checkCancellation()
//            if dim < axes.dimensions {
//                for slice in axes.slices(for: dim, 
//                                         dividers: corrections.map{$0.coordinates}) {
//                    try await deep(coords + [slice], dim: dim+1)
//                }
//            } else {
//                if !coords.isCorner {
//                    result.append(coords)
//                }
//            }
//        }
//        try await deep([])
//        return result
//    }
//}
