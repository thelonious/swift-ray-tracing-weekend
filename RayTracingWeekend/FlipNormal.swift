//
//  FlipNormal.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct FlipNormal : Hitable {
    let ptr: Hitable
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        if var rec = ptr.hit(r, t_min, t_max) {
            rec.normal = -rec.normal
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return ptr.boundingBox(t0, t1)
    }
}
