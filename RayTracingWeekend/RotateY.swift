//
//  RotateY.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class RotateY : Hitable {
    let ptr: Hitable
    let sinTheta: Double
    let cosTheta: Double
    let bbox: AABB?
    
    init(p: Hitable, angle: Double) {
        let radians = (M_PI / 180.0) * angle
        
        ptr = p
        sinTheta = sin(radians)
        cosTheta = cos(radians)
        
        if let bb = p.boundingBox(0, 1) {
            var min = Vec3(x: DBL_MAX, y: DBL_MAX, z: DBL_MAX)
            var max = Vec3(x: -DBL_MAX, y: -DBL_MAX, z: -DBL_MAX)
            
            for var i in 0..<2 {
                let ii = Double(i)
                
                for var j in 0..<2 {
                    let jj = Double(j)
                    
                    for var k in 0..<2 {
                        let kk = Double(k)
                        
                        let x = ii * bb.max.x + (1.0 - ii) * bb.min.x
                        let y = jj * bb.max.y + (1.0 - jj) * bb.min.y
                        let z = kk * bb.max.z + (1.0 - kk) * bb.min.z
                        let newX = cosTheta * x + sinTheta * z
                        let newZ = -sinTheta * x + cosTheta * z
                        let tester = Vec3(x: newX, y: y, z: newZ)
                        
                        for c in 0..<3 {
                            if tester[c] > max[c] {
                                max[c] = tester[c]
                            }
                            if tester[c] < min[c] {
                                min[c] = tester[c]
                            }
                        }
                    }
                }
            }
            
            bbox = AABB(min: min, max: max)
        }
        else {
            bbox = nil
        }
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        var origin = r.origin
        var direction = r.direction
        
        origin[0] = cosTheta * r.origin[0] - sinTheta * r.origin[2]
        origin[2] = sinTheta * r.origin[0] + cosTheta * r.origin[2]
        direction[0] = cosTheta * r.direction[0] - sinTheta * r.direction[2]
        direction[2] = sinTheta * r.direction[0] + cosTheta * r.direction[2]
        
        let rotatedR = Ray(origin: origin, direction: direction, time: r.time)
        
        if let rec = ptr.hit(rotatedR, t_min, t_max) {
            var p = rec.p
            var normal = rec.normal
            
            p[0] = cosTheta * rec.p[0] + sinTheta * rec.p[2]
            p[2] = -sinTheta * rec.p[0] + cosTheta * rec.p[2]
            normal[0] = cosTheta * rec.normal[0] + sinTheta * rec.normal[2]
            normal[2] = -sinTheta * rec.normal[0] + cosTheta * rec.normal[2]
            
            rec.p = p
            rec.normal = normal
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return bbox
    }
}
