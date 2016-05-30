//
//  sphere.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class sphere: hitable  {
    var center = vec3(x: 0.0, y: 0.0, z: 0.0)
    var radius = 0.0
    
    init(c: vec3, r: Double) {
        center = c
        radius = r
    }
    
    func hit(r: ray, _ t_min: Double, _ t_max: Double, inout _ rec: hit_record) -> Bool {
        let oc = r.origin - center
        let a = r.direction.squared_length
        let b = oc.dot(r.direction)
        let c = oc.squared_length - radius*radius
        let discrim = sqrt(b*b - a*c)
        
        if discrim > 0 {
            var temp = (-b - discrim) / a
            
            if temp < t_max && temp > t_min {
                rec.t = temp
                rec.p = r.point_at_parameter(rec.t)
                rec.normal = (rec.p - center) / radius
                
                return true
            }
            
            temp = (-b + discrim) / a
            
            if temp < t_max && temp > t_min {
                rec.t = temp
                rec.p = r.point_at_parameter(rec.t)
                rec.normal = (rec.p - center) / radius
                
                return true
            }
        }
        
        return false
    }
}
