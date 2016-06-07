//
//  XYRect.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/5/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct XYRect : Hitable {
    let x0: Double
    let x1: Double
    let y0: Double
    let y1: Double
    let k: Double
    let material: Material
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let t = (k - r.origin.z) / r.direction.z
        
        if (t < t_min || t > t_max) {
            return nil
        }
        
        let x = r.origin.x + t * r.direction.x
        let y = r.origin.y + t * r.direction.y
        
        if (x < x0 || x > x1 || y < y0 || y > y1) {
            return nil
        }
        
        return HitRecord(
            t: t,
            p: r.point_at_parameter(t),
            u: (x - x0) / (x1 - x0),
            v: (y - y0) / (y1 - y0),
            normal: Vec3(x: 0, y: 0, z: 1),
            material: material
        )
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: Vec3(x: x0, y: y0, z: k - 0.0001), max: Vec3(x: x1, y: y1, z: k + 0.0001))
    }
}
