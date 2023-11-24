////
////  File.swift
////  
////
////  Created by Łukasz Dziedzic on 13/11/2023.
////
//
//import Foundation
//
//
//public extension Array 
//where Element: InterpolableVertexProtocol 
//
//{
//    typealias Vertex = Element
//
//    func interpolateFromGrid(at coordinates: [Vertex.Coordinate]) throws -> Vertex {
//        typealias Axis = Vertex.Coordinate.Axis
//        var coordinatesAtZero: [Vertex.Coordinate] = []
//        var coordiantesAtMax: [Vertex.Coordinate] = []
//        var boxAxes: [Axis] = []
//
////        print ("✔️", coordinates)
//        //Create one small world from all Vertices in grid // Maybe cache
//        for coordinate in coordinates {
//            
//            let axis = coordinate.axis
//            
//            let positions = Set(self.compactMap {vertex in
//                vertex.coordinates
//                .first(where: {$0.axis == axis})})
//                .sorted(by: {$0.at < $1.at})
//            
////            print ("🔶", coordinate, coordinate.axis.bounds)
////            positions.forEach({print ("°", $0.at)})
////            print ()
//            
//            let smaller = positions
//                .filter({$0.at < coordinate.at})
//                .last ?? coordinate
////            print (coordinate.at, ">", smaller.at)
//            coordinatesAtZero.append(smaller)
//            
//            let bigger = positions
//                .filter({$0.at > coordinate.at})
//                .first ?? coordinate
//            coordiantesAtMax.append(bigger)
////            print (coordinate.at, "<", bigger.at)
//            
//            //create axes bound by lower and bigger coords
//            boxAxes.append(Axis(name: coordinate.axis.name,
//                                bounds: smaller.at...bigger.at))
//        }
//        var corners: [Vertex] = []
//        
////        boxAxes.forEach({print("💠", $0)})
//        //<ake bounds shorter
//        for coordinates in boxAxes.cornersCoordinates() as [[Vertex.Coordinate]] 
//        {
//            if let existingVertex = self.first(where: {$0.coordinates == coordinates}) {
//                let newVertex = Vertex(value: existingVertex.data,
//                                       at: coordinates,
//                                       strength: existingVertex.strength)
//                corners.append(newVertex)
//            } else {
//                throw HyperValueErrors.vertexForFound(at: "\(coordinates)")
//            }
//        }
//        return boxAxes.interpolate(coordinates, corners: corners)        
//    }
//}
//
//
