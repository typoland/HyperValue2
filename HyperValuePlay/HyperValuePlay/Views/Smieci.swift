//
//  Smieci.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 11/11/2023.
//

import Foundation
//            .popover(isPresented: $isShowingPopover, content: {
//                TextField("Enter", text: $name)
//                    .frame(width: 300, height: 500, alignment: .center)
//            })
//            if isFocused {
//                
//                Button(action: {isShowingPopover = true}, 
//                       label: {Image(systemName: "rectangle.and.pencil.and.ellipsis").symbolRenderingMode(.multicolor)})
//                .buttonStyle(.borderless)
//            }
}
//        .onHover(perform: { hovering in
//            isFocused = hovering }
//        )
//        .focused($isFocused)

//    func bindCorner<T>(index: Int, path: WritableKeyPath<Hyper.Vertex, T>) -> Binding<T> {
//        Binding(get: {hyper.corners[index][keyPath: path]}, 
//                set: {
//            let coordinates = hyper.corners[index].coordinates
//            let currentInterpolable = hyper.corners[index].data
//            switch path {
//            case \Hyper.Vertex.data :
//                hyper.setValue(value: $0 as! Vertex<CGPoint>.Interpolable, on: coordinates)
//            case \Hyper.Vertex.data.x :   
//                let p = CGPoint(x:$0 as! CGFloat, y: currentInterpolable.y)
//                hyper.setValue(value: p , on: coordinates)
//            case \Hyper.Vertex.data.y :   
//                let p = CGPoint(x:currentInterpolable.x, y:$0 as! CGFloat)
//                hyper.setValue(value: p , on: coordinates)
//            default: break
//            }
//        })
//    }
//    
