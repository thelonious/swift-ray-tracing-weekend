//
//  sphere.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class Sphere: Hitable  {
    var center = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var radius = 0.0
    var material: Material
    
    init(c: Vec3, r: Double, m: Material) {
        center = c
        radius = r
        material = m
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        var result: HitRecord? = nil
        
        let oc = r.origin - center
        let a = r.direction.squared_length
        let b = oc.dot(r.direction)
        let c = oc.squared_length - radius*radius
        let discrim = sqrt(b*b - a*c)
        
        if discrim > 0 {
            var temp = (-b - discrim) / a
            
            if temp < t_max && temp > t_min {
                let point = r.point_at_parameter(temp)
                
                result = HitRecord(t: temp, p: point, normal: (point - center) / radius, material: material)
            }
            else {
                temp = (-b + discrim) / a
                
                if temp < t_max && temp > t_min {
                    let point = r.point_at_parameter(temp)
                    
                    result = HitRecord(t: temp, p: point, normal: (point - center) / radius, material: material)
                }
            }
        }
        
        return result
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: center - Vec3(x: radius, y: radius, z: radius), max: center + Vec3(x: radius, y: radius, z: radius))
    }
}
