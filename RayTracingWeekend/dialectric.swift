//
//  dialectric.swiftr.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Dielectric: Material {
    var ref_index = 1.0
    
    init(index: Double) {
        ref_index = index
    }
    
    func scatter(ray_in: ray, _ rec: hit_record, inout _ attenuation: Vec3, inout _ scattered: ray) -> Bool {
        var outward_normal = Vec3(x: 0, y: 0, z: 0)
        let reflected = ray_in.direction.reflect(rec.normal)
        var ni_over_nt = 1.0
        
        attenuation = Vec3(x: 1, y: 1, z: 0)
        
        var refracted = Vec3(x: 0, y: 0, z: 0)
        
        if ray_in.direction.dot(rec.normal) > 0 {
            outward_normal = -rec.normal
            ni_over_nt = ref_index
        }
        else {
            outward_normal = rec.normal
            ni_over_nt = 1.0 / ref_index
        }
        
        if refract(ray_in.direction, n: outward_normal, ni_over_nt: ni_over_nt, refracted: &refracted) {
            scattered = ray(origin: rec.p, direction: refracted)
        }
        else {
            scattered = ray(origin: rec.p, direction: reflected)
            return false
        }
        
        return true
    }
}
