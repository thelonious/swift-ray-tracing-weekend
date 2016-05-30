//
//  main.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

func color(r: ray, world: hitable) -> vec3 {
    var rec = hit_record()
    
    if world.hit(r, 0.0, DBL_MAX, &rec) {
        return 0.5 * vec3(x: rec.normal.x + 1, y: rec.normal.y + 1, z: rec.normal.z + 1);
    }
    else {
        let unit_direction = r.direction.unit_vector()
        let t = 0.5 * (unit_direction.y + 1)
        
        return (1.0 - t) * vec3(x: 1, y: 1, z: 1) + t * vec3(x: 0.5, y: 0.7, z: 1.0)
    }
}

// main

let nx = 200
let ny = 100
let ns = 100

print("P3")
print(nx, ny)
print(255)

let lower_left_corner = vec3(x: -2.0, y: -1.0, z: -1.0)
let horizontal = vec3(x: 4.0, y: 0.0, z: 0.0)
let vertical = vec3(x: 0.0, y: 2.0, z: 0.0)
let origin = vec3(x: 0.0, y: 0.0, z: 0.0)

let world = hitable_list()
world.add(sphere(c: vec3(x: 0, y: 0, z: -1), r: 0.5))
world.add(sphere(c: vec3(x: 0, y: -100.5, z: -1), r: 100))

let cam = camera()

for j in (ny - 1).stride(through: 0, by: -1) {
    for i in 0..<nx {
        var col = vec3(x: 0, y: 0, z: 0)
        
        for s in 0..<ns {
            let u = (Double(i) + drand48()) / Double(nx)
            let v = (Double(j) + drand48()) / Double(ny)
            let r = cam.get_ray(u, v)
            let p = r.point_at_parameter(2.0)
            
            col = col + color(r, world: world)
        }
        
        col = col / Double(ns)
        
//        let u = Double(i) / Double(nx)
//        let v = Double(j) / Double(ny)
//        let r = cam.get_ray(u, v)
//        let p = r.point_at_parameter(2.0)
//        let col = color(r, world: world)
        
        let ir = UInt8(255 * col.r)
        let ig = UInt8(255 * col.g)
        let ib = UInt8(255 * col.b)
        
        print(ir, ig, ib)
    }
}
