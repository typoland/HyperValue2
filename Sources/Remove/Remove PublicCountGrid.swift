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
//#if DEBUG
//var taskID: Int = 0
//#endif
//
//extension HyperValue {
//    ///Count grid if necessary
//    public func countGrid() { //async {
//        
//        guard !corrections.isEmpty else {
//            countGridTask?.cancel()
//            countGridTask = nil
//            grid = corners
//            _gridIsReady = true
//            print ("Not corrections, grid == corners")
//            return
//        }
//#if DEBUG
//        taskID += 1 
//        print ("previous ID \(taskID-1)...canceled, start \(taskID)")
//#endif
//        _gridIsReady = false
//        grid = nil
//        countGridTask?.cancel()
//        countGridTask = Task<Void, Error>(priority: .utility) {
//            do {
//                self.grid = try await Self.defineGrid(axes: hvAxes,
//                                                      corners: corners, 
//                                                      corrections: corrections)
//    
//                countGridTask = nil
//                _gridIsReady = true
//            } catch {
//                print ("\t🚫 canceled \(countGridTask.debugDescription)")
//                _gridIsReady = false
//                grid = nil
//            }
//        }
//        
//    }
//}
