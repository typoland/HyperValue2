//
//  HyperValueModel.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 18/11/2023.
//

import Foundation
import Observation
import HyperValue


@Observable
final class HyperValuesModel<Interpolable, Axis>
where Interpolable: IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    typealias Coordinate = Hyper.Coordinate
    typealias Hyper = HyperValue<Interpolable, Axis>
    
    var selectedHyper: Hyper? = nil
    var hyperValues: [Hyper] = []
    //var axesModel: GlobalAxesModel<Axis>
    
    init() {
//        self.axesModel = GlobalAxesModel<Axis>()
    }
    
    init(_ hyper: HyperValue<Interpolable, Axis>) {
        self.selectedHyper = hyper
//        self.axesModel = GlobalAxesModel<Axis>()
        
        self.hyperValues.append(hyper)
    }
    func addNewHyper(_ hyper:Hyper = Hyper()) {
        selectedHyper = hyper
        hyperValues.append(hyper)
    }
    
   
    func add(axis: Axis, from globalAxes:[Axis]) throws {
            try selectedHyper?.add(axis: axis, from: globalAxes)
    }
    
    @discardableResult
    func addCorrectionToHyper() -> Bool {
        if let value = selectedHyper?.value {
            return selectedHyper?.addCorrection(value) ?? false
        }
        return false
    }
}
@Observable
class HyperValueModel<Interpolable, Axis> 
where Interpolable: IntepolableProtocol,
      Axis: AxisProtocol,
      Axis: HasCoordinateProtocol
{
    typealias Coordinate = Hyper.Coordinate
  
    typealias Hyper = HyperValue<Interpolable, Axis>
    
    var hyper: Hyper
    init(hyper: HyperValue<Interpolable, Axis>)

    {
        self.hyper = hyper
    }
    
    var value: Interpolable {
        get {hyper.value}
        set {hyper.value = newValue}
    }
    var isInterpolated: Bool {
        hyper.isInterpolated
    }
    func canAdd(axis: Axis) -> Bool {
        hyper.internalAxes.canAdd(newAxis: axis)
    }
    
    func add(axis: Axis, from axes: [Axis]) throws {
        try hyper.add(axis: axis, from: axes)
    }
    
    @discardableResult
    func addCorrection() -> Bool {
        hyper.addCorrection(hyper.value)
    }
    
    
    
    var cornersCount: Int {
        hyper.corners.count
    }
    var correctionsCount: Int {
        hyper.corrections.count
    }
}

@Observable
final class GlobalAxesModel<A>
where A:AxisProtocol,
      A:HasCoordinateProtocol {
    var axes:[A] = []
    var selectedAxis: A? = nil
    
    func index(of axis: A) -> Int? {
        axes.firstIndex(of: axis)
    }
    init() {}
    
    init(axes: [A], selectedAxis: A? = nil) {
        self.axes = axes
        self.selectedAxis = selectedAxis
    }
    
    var indexOfSelectedAxis: Int? {
        if let axis = selectedAxis {
            return index(of: axis)
        }
        return nil
    }

    func delete(_ index: Int) {
        axes.remove(at: index)
        //axes.operation(.delete(index))
    }
    
    func add() {
        axes.append(A(name: "och", bounds: 0...1000))
        //axes.operation(.add)
    }
}
