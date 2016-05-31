//
//  main.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

func random_in_unit_sphere() -> vec3 {
    var p = vec3(x: 0, y: 0, z: 0)
    
    repeat {
        p = 2.0 * vec3(x: drand48(), y: drand48(), z: drand48()) - vec3(x: 1, y: 1, z: 1)
    } while p.squared_length >= 1.0
    
    return p
}

func color(r: ray, world: hitable, depth: Int) -> vec3 {
    var rec = hit_record()
    
    if world.hit(r, 1e-6, DBL_MAX, &rec) {
        var scattered = ray(origin: vec3(x: 0, y: 0, z: 0), direction: vec3(x: 0, y: 0, z: 0))
        var attenuantion = vec3(x: 0, y: 0, z: 0)
        
        if depth < 50 && rec.material.scatter(r, rec, &attenuantion, &scattered) {
            return attenuantion * color(scattered, world: world, depth: depth + 1)
        }
        else {
            return vec3(x: 0, y: 0, z: 0)
        }
    } else {
        let unit_direction = r.direction.unit_vector()
        let t = 0.5 * (unit_direction.y + 1)
        
        return (1.0 - t) * vec3(x: 1, y: 1, z: 1) + t * vec3(x: 0.5, y: 0.7, z: 1.0)
    }
}

// main

var nx = 400
var ny = 200
var ns = 50

for i in 0..<Process.arguments.count {
    let arg = Process.arguments[i]
    
    switch arg {
    case "--width":
        nx = Int(Process.arguments[i+1])!
        
    case "--height":
        ny = Int(Process.arguments[i+1])!
        
    case "--samples":
        ns = Int(Process.arguments[i+1])!
        
    default:
        break
        // do nothing
    }
}

print("P3")
print(nx, ny)
print(255)

let lower_left_corner = vec3(x: -2.0, y: -1.0, z: -1.0)
let horizontal = vec3(x: 4.0, y: 0.0, z: 0.0)
let vertical = vec3(x: 0.0, y: 2.0, z: 0.0)
let origin = vec3(x: 0.0, y: 0.0, z: 0.0)

let world = hitable_list()

var object = sphere(c: vec3(x: 0, y: -100.5, z: -1), r: 100, m: lambertian(a: vec3(x: 0.8, y: 0.8, z: 0.0)))
world.add(object)

object = sphere(c: vec3(x: 1, y: 0, z: -1), r: 0.5, m: metal(a: vec3(x: 0.8, y: 0.6, z: 0.2), f: 1.0))
world.add(object)

object = sphere(c: vec3(x: -1, y: 0, z: -1), r: 0.5, m: metal(a: vec3(x: 0.8, y: 0.8, z: 0.8), f: 0.3))
world.add(object)

object = sphere(c: vec3(x: 0, y: 0, z: -1), r: 0.5, m: lambertian(a: vec3(x: 0.8, y: 0.3, z: 0.3)))
world.add(object)

let cam = camera()

for j in (ny - 1).stride(through: 0, by: -1) {
    for i in 0..<nx {
        var col = vec3(x: 0, y: 0, z: 0)
        
        for s in 0..<ns {
            let u = (Double(i) + drand48()) / Double(nx)
            let v = (Double(j) + drand48()) / Double(ny)
            let r = cam.get_ray(u, v)
            let p = r.point_at_parameter(2.0)
            
            col = col + color(r, world: world, depth: 0)
        }
        
        col = col / Double(ns)
        col = vec3(x: sqrt(col.r), y: sqrt(col.g), z: sqrt(col.b))
        
        let ir = UInt8(255 * col.r)
        let ig = UInt8(255 * col.g)
        let ib = UInt8(255 * col.b)
        
        print(ir, ig, ib)
    }
}
