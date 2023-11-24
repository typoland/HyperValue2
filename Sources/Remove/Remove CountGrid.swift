////
////  File.swift
////  
////
////  Created by Łukasz Dziedzic on 03/11/2023.
////
//
//import Foundation
//
////extension HyperValueProtocol {
///**
// Defines  vertices lying on all corrections intersections. Renders Values
// 
// If in space defined by `Axis "x", 0...1000,  Axis "y", 0...1000`, was defined some corretions on `(100, 200)`and `(800, 500)`
// function returns list of Veritces on locations:
// 
// `(0,0), (0,100), (0,800), (0,1000),`
// `(200,0), (200,100), (200,800), (200,1000), `
// `(500,0), (500,100), (500,800), (500,1000),`
// `(1000,0), (1000,100), (1000,800), (1000,1000),`
// 
// With proper  defined values
// */
//extension HyperValue {
//    static func defineGrid(
//        axes: [Vertex.Coordinate.Axis],
//        corners: [Vertex], 
//        corrections: [Vertex]) 
//    async throws 
//    -> [Vertex]
//    {
//        
//        var definedGridVertices: [Vertex] = []
//#if DEBUG 
//        let start = Date.now
//        print ("step 0️⃣")
//        
//#endif
//        
//        //let cornerAxes = hvAxes
//        
//        let corners =   Self.defineMissingCorners(for: corners, axes: axes)
//        //If axes and vertices are adde in legal way it shodlnt be necessary
//        //let correctedCorners = corners //just for accident above is not true
//#if DEBUG
//        print ("step 1️⃣ Corners: \(Date.now.timeIntervalSince(start))s")     
//#endif
//        //Define verices
//        let newGridCoordinates = try await  Self.gridCoordinatesFor(corrections: corrections, 
//                                                                    in: axes)
//#if DEBUG
//        print ("step 2️⃣ NewGridCoordinates: \(Date.now.timeIntervalSince(start))s")     
//#endif
//        /*
//         //=============ADD outside vertices==========//
//         result.append(contentsOf: correctedCorners)
//         */
//        definedGridVertices.append(contentsOf: corners)
//        //definedGridVertices.append(contentsOf: corrections)
//        
//        //            definedGridVertices.forEach({print ($0)})
//        
//        //`1` means it has exactly at the same postition
//        //`0<x<1` means it's somhere in beteween correction and edge or corner
//        //`0` means it's on the edge or corner
//        
//        
//        //corrections must have the same number of coordinates as axes so:
//        // - if some coordinate is missing it exchange one correction from middle to two on egdes. I don't know it is practical
//        // every CorrectionSubspace for every Corroection
//        //https://augmentedcode.io/tag/withthrowingtaskgroup/
//        
//        //MARK: TaskGroup, bit faster than flat
//        let correctionSubspaces = try await withThrowingTaskGroup(of: [Vertex].self, 
//                                                                  returning: [[Vertex]].self) 
//        { correctionTasks in
//            corrections.forEach { correction in
//                
//                correctionTasks.addTask {
//                    
//                    var vertexLayers:[Vertex] = []
//                    for coordinates in newGridCoordinates { // every new grid position
//                        let vertexWithStrength = try await Self.InterpolableStrength(for: correction,
//                                                                               in: corners,
//                                                                               on: coordinates)
//                        vertexLayers.append(vertexWithStrength)
//                    }
//                    return vertexLayers
//                } 
//            }
//            var subspace :[[Vertex]] = []
//            for try await layer in correctionTasks {
//                subspace.append(layer)
//            }
//            return subspace
//        }
//        
//        
//        
//         //MARK: TaskGroup, slow as hell
////        var correctionSubspaces : [[Vertex]] = [] 
////        for correction in corrections { // evey correction
////            // subgrid for one correction
////            let correctionSubspace = try await withThrowingTaskGroup(of: Vertex.self, 
////                                                                     returning: [Vertex].self) { verticesTasks in
////                
////                newGridCoordinates.forEach { coordinates in
////                    verticesTasks.addTask {
////                        return try await Self.InterpolableStrength(for: correction, 
////                                                             in: corners,
////                                                             on: coordinates)
////                    }
////                }
////                var vertexLayer: [Vertex] = []
////                for try await vertex in verticesTasks {
////                    vertexLayer.append(vertex)
////                }
////                return vertexLayer
////            }
////            
////            correctionSubspaces.append(correctionSubspace)
////        }
//         
//        
//        //MARK: no TaskGroup
////        var correctionSubspaces : [[Vertex]] = []
////        for correction in corrections { // evey correction
////            var vertexLayers: [Vertex] = [] // subgrid for one correction
////            for coordinates in newGridCoordinates { // every new grid position
////                try Task.checkCancellation() 
////                // count vertex strength on this position.
////                let vertexWithStrength = try await Self.InterpolableStrength(for: correction,
////                                                                       in: corners,
////                                                                       on: coordinates)
////                vertexLayers.append(vertexWithStrength)
////                
////            }
////            correctionSubspaces.append(vertexLayers)
////        }
//       
//        
//#if DEBUG
//        print ("step 3️⃣ correctionSubspaces: \(Date.now.timeIntervalSince(start))s")     
//#endif
//        if correctionSubspaces.count > 0 {
//            for vertexNr in 0 ..< correctionSubspaces[0].count {
//                var layers: [Vertex] = []
//                for layerNr in 0 ..< correctionSubspaces.count {
//                    layers.append(correctionSubspaces[layerNr][vertexNr])
//                }
//                
//                definedGridVertices.append (layers.mixVertices)
//            }
//        } 
//#if DEBUG
//        print ("step 4️⃣ definedGrid: \(Date.now.timeIntervalSince(start))s")     
//#endif
//        return definedGridVertices
//    }
//}
