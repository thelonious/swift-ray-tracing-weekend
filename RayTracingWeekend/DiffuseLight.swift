//
//  DiffuseLight.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/5/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct DiffuseLight : Material {
    let emit: Texture
    
    func scatter(r_in: Ray, _ rec: HitRecord, inout _ attentuation: Vec3, inout _ scattered: Ray) -> Bool {
        return false
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return emit.value(u, v, p)
    }
}
