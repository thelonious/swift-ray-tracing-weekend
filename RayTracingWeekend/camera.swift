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
    
    init(vfov: Double, aspect: Double) {
        let theta = vfov * M_PI / 180.0
        let half_height = tan(theta * 0.5)
        let half_width = aspect * half_height
        
        lower_left_corner = Vec3(x: -half_width, y: -half_height, z: -1.0)
        horizontal = Vec3(x: 2.0 * half_width, y: 0.0, z: 0.0)
        vertical = Vec3(x: 0.0, y: 2.0 * half_height, z: 0.0)
        origin = Vec3(x: 0, y: 0, z: 0)
    }
    
    func get_ray(u: Double, _ v: Double) -> Ray {
        return Ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical - origin);
    }
}
