//
//  main.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

func hit_sphere(center: vec3, radius: Double, r: ray) -> Double {
    let oc = r.origin - center
    let a = r.direction.squared_length
    let b = 2.0 * oc.dot(r.direction)
    let c = oc.squared_length - radius*radius
    let discrim = b*b - 4*a*c
    
    return (discrim < 0.0) ? -1.0 : (-b - sqrt(discrim)) / (2.0 * a)
}

func color(r: ray) -> vec3 {
    var t = hit_sphere(vec3(x:0, y:0, z:-1), radius: 0.5, r: r)
    
    if t > 0.0 {
        let n = (r.point_at_parameter(t) - vec3(x:0, y:0, z: -1)).unit_vector()
        
        return 0.5 * vec3(x: n.x + 1, y: n.y + 1, z: n.z + 1)
    }
    
    let unit_direction = r.direction.unit_vector()
    
    t = 0.5 * (unit_direction.y + 1.0)
    
    return (1.0 - t) * vec3(x: 1, y: 1, z: 1) + t * vec3(x: 0.5, y: 0.7, z: 1.0)
}

// main

let nx = 200
let ny = 100

print("P3")
print(nx, ny)
print(255)

let lower_left_corner = vec3(x: -2.0, y: -1.0, z: -1.0)
let horizontal = vec3(x: 4.0, y: 0.0, z: 0.0)
let vertical = vec3(x: 0.0, y: 2.0, z: 0.0)
let origin = vec3(x: 0.0, y: 0.0, z: 0.0)

for j in (ny - 1).stride(through: 0, by: -1) {
    for i in 0..<nx {
        let u = Double(i) / Double(nx)
        let v = Double(j) / Double(ny)
        let r = ray(origin: origin, direction: lower_left_corner + u * horizontal + v * vertical)
        let col = color(r)
        
        let ir = UInt8(255 * col.r)
        let ig = UInt8(255 * col.g)
        let ib = UInt8(255 * col.b)
        
        print(ir, ig, ib)
    }
}
