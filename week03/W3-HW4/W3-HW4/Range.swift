//
//  Range.swift
//  W3-HW4
//
//  Created by Hümeyra Şahin on 26.01.2022.
//

import Foundation
struct Range{
    var velocity: Double
    var teta: Double
    let g = 10.0
    func calculateRange(velocity: Double, teta: Double) -> Double{
        let velSquare = velocity * velocity
        let sin2Teta = sin((2.0 * Double(teta)) * Double.pi / 180)
        let range = Double(velSquare) * sin2Teta / g
        return range
    }
}
