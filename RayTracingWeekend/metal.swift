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
    
    init(a: vec3) {
        albedo = a
    }
    
    func scatter(ray_in: ray, _ rec: hit_record, inout _ attenuation: vec3, inout _ scattered: ray) -> Bool {
        let reflected = ray_in.direction.unit_vector().reflect(rec.normal)
        
        scattered = ray(origin: rec.p, direction: reflected)
        attenuation = albedo
        
        return scattered.direction.dot(rec.normal) > 0
    }
}
