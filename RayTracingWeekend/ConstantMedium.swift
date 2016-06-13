//
//  ConstantMedium.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class ConstantMedium : Hitable {
    let boundary: Hitable
    let density: Double
    let phaseFunction: Material
    
    init(b: Hitable, d: Double, a: Texture) {
        boundary = b
        density = d
        phaseFunction = Isotropic(albedo: a)
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        if let rec1 = boundary.hit(r, -DBL_MAX, DBL_MAX) {
            if let rec2 = boundary.hit(r, rec1.t + 0.0001, DBL_MAX) {
                if rec1.t < t_min {
                    rec1.t = t_min
                }
                if rec2.t > t_max {
                    rec2.t = t_max
                }
                if (rec1.t >= rec2.t) {
                    return nil
                }
                if (rec1.t < 0) {
                    rec1.t = 0
                }
                
                let distanceInsideBoundary = (rec2.t - rec1.t) * r.direction.length
                let hitDistance = -(1.0 / density) * log(drand48())
                
                if hitDistance < distanceInsideBoundary {
                    let t = rec1.t + hitDistance / r.direction.length
                    let rec = HitRecord(
                        t: t,
                        p: r.point_at_parameter(t),
                        u: 0.0,
                        v: 0.0,
                        normal: Vec3(x: 1, y: 0, z: 0),
                        material: phaseFunction
                    )

                    return rec
                }
            }
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return boundary.boundingBox(t0, t1)
    }
}
