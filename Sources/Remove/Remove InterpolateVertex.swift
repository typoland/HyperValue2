////
////  File.swift
////  
////
////  Created by Łukasz Dziedzic on 03/11/2023.
////
//
//import Foundation
//
//extension HyperValue 
//    where Vertex: InterpolableVertexProtocol   
//{
//    ///Interpolated `HyperValue` value at given coordinates
//    ///- Parameters:
//    ///   - coord: array of values describing coordinates, order must be the same as `hyperValue.axes` array
//    ///- Returns: interpolated value
//    func interpolated (at coord: [ Double ]) -> Vertex.Interpolable {
//        let coordinates: [Vertex.Coordinate] = hvAxes.makeCoordinates(coord)
//        return interpolated(at: coordinates)
//    }
//    
//    ///Interpolated `HyperValue` value at given coordinates
//    ///- Parameters:
//    ///   - coord: array of  coordinates, order must be the same as `hyperValue.axes` array
//    ///- Returns: interpolated value
//    func interpolated (at coords: [Vertex.Coordinate]) -> Vertex.Interpolable {
//        interpolatedVertex(at: coords).data
//    }
//    
//    ///Returns interpolated `dataVertex` at `coords`
//    func interpolatedVertex(at worldCoordinates: [Vertex.Coordinate]) -> Vertex {
//        
//        // first, trim global coordinates to local coordinates. 
//        //Local values could be two-dimensional, global 32-dimensional (too slow, max 8 please
//        let localCoordinates = worldCoordinates.trimmed(to: hvAxes)
//        
//        guard !localCoordinates.isEmpty else { 
//            //print ("NO COORDINATION, RETURN FLAT VALUE")
//            return vertices[0] 
//        }
//        
//        //If coordinates don't need interpolation - return vertex - corner or correction
//        if let vertex = vertices.filter({$0.coordinates == localCoordinates}).first {
//           // print ("VERTEX DEFINED, RETURN ITS VALUE")
//            return vertex
//        }
//        //If there is no corrections
//        if corrections.isEmpty {
//            //print ("NO CORRECTIONS, RETURN NOT CORRECTED")
//            return interpolatedNotCorrectedVertex(at: localCoordinates) 
//        }
//        //If grid is not ready
//        guard let grid = grid, gridIsReady else { 
//           // print ("GRID IS NOT READY, RETURN NOT CORRECTED")
//            return interpolatedNotCorrectedVertex(at: localCoordinates)
//        }
//        do {
//           // print ("TRY TO RETURN FROM GRID")
//            return try grid.interpolateFromGrid(at: localCoordinates)
//        } catch {
//            print (error)
//            return interpolatedNotCorrectedVertex(at: localCoordinates) 
//        }
//        //return interpolatedNotCorrectedVertex(at: localCoordinates) 
//        
//        
////        //divide space to smaller pieces, to look for value in one of them
////        //TODO: Should be cached?
////        let subspaceAxes = hvAxes.subspaceAxes(dividedBy: corrections, for: localCoordinates )
////        
////        //coordinates to define vertices for subspace 
////        let subspaceCornersCoordinates: [[Vertex.Coordinate]] = subspaceAxes.cornersCoordinates()
////        
////        
////        let newVertices: [Vertex] = subspaceCornersCoordinates.compactMap {coords in
////            return grid.first(where: { $0.coordinates == coords})
////        }
////        guard newVertices.count == hvAxes.cornersCount else {return newVertices.first ?? corners[0]}
////        
////        return subspaceAxes.interpolate(localCoordinates, corners: newVertices)
//    }
//    
//    /// Interpolates data with no correcions. Faster
//    
//}
//
//
//
