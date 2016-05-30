//
//  ray.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public struct ray {
    var origin: vec3
    var direction: vec3
    
    func point_at_parameter(t: Double) -> vec3 {
        return origin + t * direction
    }
}
