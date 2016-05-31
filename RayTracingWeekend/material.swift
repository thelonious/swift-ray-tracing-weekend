//
//  material.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

protocol Material {
    func scatter(r_in: ray, _ rec: hit_record, inout _ attentuation: Vec3, inout _ scattered: ray) -> Bool
}

func refract(v: Vec3, n: Vec3, ni_over_nt: Double, inout refracted: Vec3) -> Bool {
    let uv = v.unit_vector()
    let dt = uv.dot(n)
    let discrim = 1.0 - ni_over_nt*ni_over_nt * (1.0 - dt*dt)
    
    if discrim > 0 {
        refracted = ni_over_nt * (uv - n * dt) - n * sqrt(discrim)
        return true
    }
    else {
        return false
    }
}
