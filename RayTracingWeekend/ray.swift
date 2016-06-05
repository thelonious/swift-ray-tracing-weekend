//
//  ray.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public struct Ray : CustomStringConvertible {
    var origin: Vec3
    var direction: Vec3
    var time: Double
    
    public var description: String {
        return "origin: \(origin), direction: \(direction), time: \(time)"
    }
    
    func point_at_parameter(t: Double) -> Vec3 {
        return origin + t * direction
    }
}
