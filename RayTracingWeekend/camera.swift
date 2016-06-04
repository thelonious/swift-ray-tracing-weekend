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
    let lensRadius: Double
    let u: Vec3
    let v: Vec3
    let w: Vec3
    let time0: Double
    let time1: Double
    
    init(lookFrom: Vec3, lookAt: Vec3, vup: Vec3, vfov: Double, aspect: Double, aperture: Double, focus_dist: Double, t0: Double, t1: Double) {
        time0 = t0
        time1 = t1
        
        lensRadius = aperture * 0.5
        
        let theta = vfov * M_PI / 180.0
        let half_height = tan(theta * 0.5)
        let half_width = aspect * half_height
        
        origin = lookFrom
        
        w = (lookFrom - lookAt).unit_vector()
        u = vup.cross(w).unit_vector()
        v = w.cross(u)
        
        lower_left_corner = origin - (half_width * focus_dist * u) - (half_height * focus_dist * v) - focus_dist * w
        horizontal = 2.0 * half_width * focus_dist * u
        vertical = 2.0 * half_height * focus_dist * v
        
    }
    
    func get_ray(s: Double, _ t: Double) -> Ray {
        let rd = lensRadius * random_in_unit_disk()
        let offset = u * rd.x + v * rd.y
        let time = time0 + drand48() * (time1 - time0)
        
        return Ray(
            origin: origin + offset,
            direction: lower_left_corner + (s * horizontal) + (t * vertical) - origin - offset,
            time: time
        );
    }
}
