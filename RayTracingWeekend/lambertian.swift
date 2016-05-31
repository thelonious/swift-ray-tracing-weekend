//
//  lambertian.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class lambertian: Material {
    var albedo: vec3
    
    init(a: vec3) {
        albedo = a
    }
    
    func scatter(ray_in: ray, _ rec: hit_record, inout _ attenuation: vec3, inout _ scattered: ray) -> Bool {
        let target = rec.p + rec.normal + random_in_unit_sphere()
        
        scattered = ray(origin: rec.p, direction: target - rec.p)
        attenuation = albedo
        
        return true
    }
}
