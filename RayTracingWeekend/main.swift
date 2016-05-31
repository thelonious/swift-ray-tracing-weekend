//
//  main.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

func random_in_unit_sphere() -> Vec3 {
    var p = Vec3(x: 0, y: 0, z: 0)
    
    repeat {
        p = 2.0 * Vec3(x: drand48(), y: drand48(), z: drand48()) - Vec3(x: 1, y: 1, z: 1)
    } while p.squared_length >= 1.0
    
    return p
}

func color(r: Ray, world: Hitable, depth: Int) -> Vec3 {
    var rec = HitRecord()
    
    if world.hit(r, 1e-6, DBL_MAX, &rec) {
        var scattered = Ray(origin: Vec3(x: 0, y: 0, z: 0), direction: Vec3(x: 0, y: 0, z: 0))
        var attenuantion = Vec3(x: 0, y: 0, z: 0)
        
        if depth < 50 && rec.material.scatter(r, rec, &attenuantion, &scattered) {
            return attenuantion * color(scattered, world: world, depth: depth + 1)
        }
        else {
            return Vec3(x: 0, y: 0, z: 0)
        }
    } else {
        let unit_direction = r.direction.unit_vector()
        let t = 0.5 * (unit_direction.y + 1)
        
        return (1.0 - t) * Vec3(x: 1, y: 1, z: 1) + t * Vec3(x: 0.5, y: 0.7, z: 1.0)
    }
}

// main

var nx = 200
var ny = 100
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

let lower_left_corner = Vec3(x: -2.0, y: -1.0, z: -1.0)
let horizontal = Vec3(x: 4.0, y: 0.0, z: 0.0)
let vertical = Vec3(x: 0.0, y: 2.0, z: 0.0)
let origin = Vec3(x: 0.0, y: 0.0, z: 0.0)

let world = HitableList()

var object = Sphere(c: Vec3(x: 0, y: -100.5, z: -1), r: 100, m: Lambertian(a: Vec3(x: 0.8, y: 0.8, z: 0.0)))
world.add(object)

object = Sphere(c: Vec3(x: 1, y: 0, z: -1), r: 0.5, m: Metal(a: Vec3(x: 0.8, y: 0.6, z: 0.2), f: 0.0))
world.add(object)

//object = Sphere(c: Vec3(x: -1, y: 0, z: -1), r: 0.5, m: Dielectric(index: 1.5))
//world.add(object)

object = Sphere(c: Vec3(x: -1, y: 0, z: -1), r: -0.45, m: Dielectric(index: 1.5))
world.add(object)

object = Sphere(c: Vec3(x: 0, y: 0, z: -1), r: 0.5, m: Lambertian(a: Vec3(x: 0.1, y: 0.2, z: 0.5)))
world.add(object)

let cam = Camera(
    lookFrom: Vec3(x: -2, y: 2, z: 1),
    lookAt: Vec3(x: 0, y: 0, z: -1),
    vup: Vec3(x: 0, y: 1, z: 0),
    vfov: 30.0,
    aspect: Double(nx) / Double(ny)
)

for j in (ny - 1).stride(through: 0, by: -1) {
    for i in 0..<nx {
        var col = Vec3(x: 0, y: 0, z: 0)
        
        for s in 0..<ns {
            let u = (Double(i) + drand48()) / Double(nx)
            let v = (Double(j) + drand48()) / Double(ny)
            let r = cam.get_ray(u, v)
            let p = r.point_at_parameter(2.0)
            
            col = col + color(r, world: world, depth: 0)
        }
        
        col = col / Double(ns)
        col = Vec3(x: sqrt(col.r), y: sqrt(col.g), z: sqrt(col.b))
        
        let ir = UInt8(255 * col.r)
        let ig = UInt8(255 * col.g)
        let ib = UInt8(255 * col.b)
        
        print(ir, ig, ib)
    }
}
