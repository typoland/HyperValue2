////
////  File.swift
////  
////
////  Created by Łukasz Dziedzic on 03/11/2023.
////
//
//import Foundation
//extension Array {
//    
//    func filledCornerNumbers<I:IntepolableProtocol>() -> [I]? where Element == I? {
//        precondition(self.count == 4)
//        
//        let nils = (self[0] != nil ? 1 : 0)
//        + (self[1] != nil ? 1 : 0)
//        + (self[2] != nil ? 1 : 0)
//        + (self[3] != nil ? 1 : 0)
//        
//        switch nils {
//        case 4:
//            ///all values set, just remove optionals
//            return self.compactMap({ $0 })
//        case 1:
//            ///all values on side will be the same
//            let value = self.compactMap({ $0 })[0]
//            return Array(repeating: value, count: 4) as? [I]
//        case 2:
//            ///check if they are digonal or on one edge. if sum 0+3 or 1+2 then diagonal
//            let idxs = (0...3).reduce(
//                into: [Int](),
//                { array, index in
//                    if self[index] != nil { array.append(index) }
//                })
//            /// if sum of indexes == 3 it means defined points are diagonal,
//            let diagonal = idxs.reduce(0, +) == 3
//            
//            if diagonal {
//                let value = self.compactMap({$0}).average
//                //fill by the averange value on oposite corners
//                return self.map { $0 == nil ? value : $0! }
//            } else {
//                let commonAxis = (idxs[0] ^ idxs[1]) ^ 3
//                var r = self
//                //fill closest corners by same values
//                r[idxs[0] ^ commonAxis] = r[idxs[0]]
//                r[idxs[1] ^ commonAxis] = r[idxs[1]]
//                return r.compactMap({ $0 })
//            }
//        case 3:
//            //extrapolate value from three values
//            let index = self.firstIndex(of: nil)!
//            let middle:  Element
//            if (1...2).contains(index) {
//                middle = [self[0], self[3]].compactMap({$0}).average
//            } else {
//                middle = [self[1], self[2]].compactMap({$0}).average
//            }
//            
//            var result = self
//            let sourceIndex = index ^ 3
//            
//            result[index] = middle! + (middle! - self[sourceIndex]!)
//            
//            return result.compactMap({ $0 })
//            
//        default:
//            print ("FUCK IT's NIL")
//            return nil
//        }
//    }
//}
