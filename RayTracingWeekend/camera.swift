//
//  camera.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Camera {
    let lower_left_corner = Vec3(x: -2.0, y: -1.0, z: -1.0)
    let horizontal = Vec3(x: 4.0, y: 0, z: 0)
    let vertical = Vec3(x: 0, y: 2.0, z: 0)
    let origin = Vec3(x: 0, y: 0, z: 0)
    
    func get_ray(u: Double, _ v: Double) -> Ray {
        return Ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical - origin);
    }
}
