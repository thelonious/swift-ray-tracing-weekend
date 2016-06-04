//
//  MovingSphere.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/2/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class MovingSphere : Hitable {
    let center0: Vec3
    let center1: Vec3
    let time0: Double
    let time1: Double
    let radius: Double
    let material: Material
    
    init(cen0: Vec3, cen1: Vec3, t0: Double, t1: Double, r: Double, m: Material) {
        center0 = cen0
        center1 = cen1
        time0 = t0
        time1 = t1
        radius = r
        material = m
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double, inout _ rec: HitRecord) -> Bool {
        let oc = r.origin - center(r.time)
        let a = r.direction.squared_length
        let b = oc.dot(r.direction)
        let c = oc.squared_length - radius*radius
        let discrim = sqrt(b*b - a*c)
        
        if discrim > 0 {
            var temp = (-b - discrim) / a
            
            if temp < t_max && temp > t_min {
                rec.t = temp
                rec.p = r.point_at_parameter(rec.t)
                rec.normal = (rec.p - center(r.time)) / radius
                rec.material = material
                
                return true
            }
            
            temp = (-b + discrim) / a
            
            if temp < t_max && temp > t_min {
                rec.t = temp
                rec.p = r.point_at_parameter(rec.t)
                rec.normal = (rec.p - center(r.time)) / radius
                rec.material = material
                
                return true
            }
        }
        
        return false
    }
    
    func center(time: Double) -> Vec3 {
        return center0 + ((time - time0) / (time1 - time0)) * (center1 - center0)
    }
}