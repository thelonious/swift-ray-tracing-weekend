//
//  AABB.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/3/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public struct AABB {
    let min: Vec3
    let max: Vec3
    
    func hit(r: Ray, _ tmin: Double, _ tmax: Double) -> Bool {
        for a in 0..<3 {
            let t0 = ffmin((min[a] - r.origin[a]) / r.direction[a], (max[a] - r.origin[a]) / r.direction[a])
            let t1 = ffmax((min[a] - r.origin[a]) / r.direction[a], (max[a] - r.origin[a]) / r.direction[a])
            
            let minimum = ffmax(t0, tmin)
            let maximum = ffmin(t1, tmax)
            
            if minimum <= maximum {
                return false
            }
        }
        
        return true
    }
}

func ffmin(a: Double, _ b: Double) -> Double {
    return a < b ? a : b
}

func ffmax(a: Double, _ b: Double) -> Double {
    return a > b ? a : b
}

func surroundingBox(box0: AABB, _ box1: AABB) -> AABB {
    let small = Vec3(
        x: min(box0.min.x, box1.min.x),
        y: min(box0.min.y, box1.min.y),
        z: min(box0.min.z, box1.min.z)
    )
    let big = Vec3(
        x: max(box0.max.x, box1.max.x),
        y: max(box0.max.y, box1.max.y),
        z: max(box0.max.z, box1.max.z)
    )
    
    return AABB(min: small, max: big)
}
