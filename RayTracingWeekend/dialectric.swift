//
//  dialectric.swiftr.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Dielectric: Material {
    var ref_idx: Double
    
    init(index: Double) {
        ref_idx = index
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, inout _ attenuation: Vec3, inout _ scattered: Ray) -> Bool {
        var outward_normal = Vec3(x: 0, y: 0, z: 0)
        let reflected = r_in.direction.reflect(rec.normal)
        var ni_over_nt = 1.0
        
        attenuation = Vec3(x: 1, y: 1, z: 1)
        
        var refracted = Vec3(x: 0, y: 0, z: 0)
        var reflect_prob = 0.0
        var cosine = 0.0
        
        if r_in.direction.dot(rec.normal) > 0 {
            outward_normal = Vec3(x: -rec.normal.x, y: -rec.normal.y, z: -rec.normal.z) //-rec.normal
            ni_over_nt = ref_idx
            cosine = ref_idx * r_in.direction.dot(rec.normal) / r_in.direction.length
        }
        else {
            outward_normal = rec.normal
            ni_over_nt = 1.0 / ref_idx
            cosine = -r_in.direction.dot(rec.normal) / r_in.direction.length
        }
        
        if refract(r_in.direction, n: outward_normal, ni_over_nt: ni_over_nt, refracted: &refracted) {
            reflect_prob = schlick(cosine, ref_idx: ref_idx)
        }
        else {
            reflect_prob = 1.0
        }
        
        if drand48() < reflect_prob {
            scattered = Ray(origin: rec.p, direction: reflected, time: r_in.time)
        }
        else {
            scattered = Ray(origin: rec.p, direction: refracted, time: r_in.time)
        }
        
        return true
    }
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

func schlick(cosine: Double, ref_idx: Double) -> Double {
    var r0 = (1.0 - ref_idx) / (1.0 + ref_idx)
    
    r0 = r0 * r0
    
    return r0 + (1.0 - r0) * pow((1.0 - cosine), 5)
}
