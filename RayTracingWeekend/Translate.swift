//
//  Translate.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class Translate : Hitable {
    let ptr: Hitable
    let offset: Vec3
    
    init(ptr: Hitable, offset: Vec3) {
        self.ptr = ptr
        self.offset = offset
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let movedRay = Ray(origin: r.origin - offset, direction: r.direction, time: r.time)
        
        if let rec = ptr.hit(movedRay, t_min, t_max) {
            rec.p = rec.p + offset
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        if let box = ptr.boundingBox(t0, t1) {
            return AABB(min: box.min + offset, max: box.max + offset)
        }
        
        return nil
    }
}
