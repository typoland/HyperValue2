//
//  GraphView.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 19/11/2023.
//

import Foundation
import SwiftUI

struct GraphView: View {
    var graph: Graph
    
    var body: some View {
        VStack (alignment: .trailing) {
            GeometryReader {proxy in
                Image(nsImage: NSImage(size: proxy.size, 
                                       actions: graph.draw(xSteps: 100, 
                                                           ySteps: 100)))
                
               
                let _ = print (proxy.size)
            }.background(Color.gray)
        }
    }
}

#Preview {
    let graph = Graph() {x, _, y, _ in
        return CGColor(red: Double.random(in: 0...1), 
                            green: Double.random(in: 0...1), 
                            blue: Double.random(in: 0...1), 
                            alpha: Double.random(in: 0...1))
        
    } 
    
    return GraphView(graph: graph)
}
