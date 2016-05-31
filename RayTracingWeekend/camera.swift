//
//  camera.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Camera {
    let lower_left_corner: Vec3
    let horizontal: Vec3
    let vertical: Vec3
    let origin: Vec3
    
    init(lookFrom: Vec3, lookAt: Vec3, vup: Vec3, vfov: Double, aspect: Double) {
        let theta = vfov * M_PI / 180.0
        let half_height = tan(theta * 0.5)
        let half_width = aspect * half_height
        
        origin = lookFrom
        
        let w = (lookFrom - lookAt).unit_vector()
        let u = vup.cross(w).unit_vector()
        let v = w.cross(u)
        
        lower_left_corner = origin - half_width * u - half_height * v - w
        horizontal = 2.0 * half_width * u
        vertical = 2.0 * half_height * v
        
    }
    
    func get_ray(u: Double, _ v: Double) -> Ray {
        return Ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical - origin);
    }
}
