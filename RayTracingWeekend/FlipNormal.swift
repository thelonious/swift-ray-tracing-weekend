//
//  FlipNormal.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class FlipNormal : Hitable {
    let ptr: Hitable
    
    init(ptr: Hitable) {
        self.ptr = ptr
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        if let rec = ptr.hit(r, t_min, t_max) {
            rec.normal = -rec.normal
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return ptr.boundingBox(t0, t1)
    }
}
