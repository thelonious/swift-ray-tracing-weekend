//
//  metal.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class metal: Material {
    var albedo: vec3
    var fuzz: Double
    
    init(a: vec3, f: Double) {
        albedo = a
        fuzz = f < 1 ? f : 1
    }
    
    func scatter(ray_in: ray, _ rec: hit_record, inout _ attenuation: vec3, inout _ scattered: ray) -> Bool {
        let reflected = ray_in.direction.unit_vector().reflect(rec.normal)
        
        scattered = ray(origin: rec.p, direction: reflected + fuzz * random_in_unit_sphere())
        attenuation = albedo
        
        return scattered.direction.dot(rec.normal) > 0
    }
}
