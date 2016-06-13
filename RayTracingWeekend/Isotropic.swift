//
//  Isotropic.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class Isotropic : Material {
    let albedo: Texture
    
    init(albedo: Texture) {
        self.albedo = albedo
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, inout _ attentuation: Vec3, inout _ scattered: Ray) -> Bool {
        scattered = Ray(origin: rec.p, direction: random_in_unit_sphere(), time: r_in.time)
        attentuation = albedo.value(rec.u, rec.v, rec.p)
        
        return true
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return Vec3(x: 0.0, y: 0.0, z: 0.0)
    }
}
