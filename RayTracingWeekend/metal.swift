//
//  metal.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class Metal: Material {
    var albedo: Vec3
    var fuzz: Double
    
    init(a: Vec3, f: Double) {
        albedo = a
        fuzz = f < 1 ? f : 1
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, inout _ attenuation: Vec3, inout _ scattered: Ray) -> Bool {
        let reflected = r_in.direction.unit_vector().reflect(rec.normal)
        
        scattered = Ray(origin: rec.p, direction: reflected + fuzz * random_in_unit_sphere())
        attenuation = albedo
        
        return scattered.direction.dot(rec.normal) > 0
    }
}
