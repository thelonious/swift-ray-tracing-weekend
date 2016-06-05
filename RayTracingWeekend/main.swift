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

func random_in_unit_disk() -> Vec3 {
    var p = Vec3(x: 0, y: 0, z: 0)
    
    repeat {
        p = 2.0 * Vec3(x: drand48(), y: drand48(), z: 0.0) - Vec3(x: 1, y: 1, z: 0)
    } while p.squared_length >= 1.0
    
    return p
}

func color(r: Ray, world: Hitable, depth: Int) -> Vec3 {
    if let rec = world.hit(r, 1e-6, DBL_MAX) {
        var scattered = Ray(origin: Vec3(x: 0, y: 0, z: 0), direction: Vec3(x: 0, y: 0, z: 0), time: 0.0)
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

func makeWorld() -> Hitable {
    let world = HitableList()
    var object: Hitable
    
    object = Sphere(c: Vec3(x: 0, y: -100.5, z: -1), r: 100, m: Lambertian(a: ConstantTexture(color: Vec3(x: 0.7, y: 0.23, z: 0.12))))
    world.add(object)
    
    object = Sphere(c: Vec3(x: 1, y: 0, z: -1), r: 0.5, m: Metal(a: Vec3(x: 0.8, y: 0.6, z: 0.2), f: 0.1))
    world.add(object)
    
    object = Sphere(c: Vec3(x: -1, y: 0, z: -1), r: 0.5, m: Dielectric(index: 1.0))
    world.add(object)
    
    object = Sphere(c: Vec3(x: -1, y: 0, z: -1), r: -0.49, m: Dielectric(index: 1.0))
    world.add(object)
    
    object = Sphere(c: Vec3(x: 0, y: 0, z: -1), r: 0.5, m: Lambertian(a: ConstantTexture(color: Vec3(x: 0.24, y: 0.5, z: 0.15))))
    world.add(object)
    
    return world
}

func makeRandomWorld() -> Hitable {
    let world = HitableList()
    var object: Hitable
    
    let oddColor = ConstantTexture(color: Vec3(x: 0.2, y: 0.3, z: 0.1))
    let evenColor = ConstantTexture(color: Vec3(x: 0.9, y: 0.9, z: 0.9))
    let checker = CheckerTexture(odd: oddColor, even: evenColor)
    object = Sphere(c: Vec3(x: 0, y: -1000, z: 0), r: 1000, m: Lambertian(a: checker))
    world.add(object)
    
    for a in -5..<5 {
        for b in -5..<5 {
            let chooseMaterial = drand48()
            let center = Vec3(x: Double(a) + 0.9 * drand48(), y: 0.2, z: Double(b) + 0.9 * drand48())
            
            if (center - Vec3(x: 4, y: 0.2, z: 0)).length > 0.9 {
                if chooseMaterial < 0.8 {
                    object = MovingSphere(
                        cen0: center,
                        cen1: center + Vec3(x: 0, y: 0.5 * drand48(), z: 0),
                        t0: 0.0,
                        t1: 1.0,
                        r: 0.2,
                        m: Lambertian(a: ConstantTexture(color: Vec3(x: drand48()*drand48(), y: drand48()*drand48(), z: drand48()*drand48())))
                    )
                    world.add(object)
                }
                else if chooseMaterial < 0.95 {
                    object = Sphere(
                        c: center,
                        r: 0.2,
                        m: Metal(a: Vec3(x: 0.5 * (1.0 + drand48()), y: 0.5 * (1.0 + drand48()), z: 0.5 * (1.0 + drand48())), f: 0)
                    )
                    world.add(object)
                }
                else {
                    object = Sphere(c: center, r: 0.2, m: Dielectric(index: 1.5))
                    world.add(object)
                }
            }
        }
    }
    
    object = Sphere(c: Vec3(x: 0, y: 1, z: 0), r: 1, m: Dielectric(index: 1.5))
    world.add(object)
    
    object = Sphere(c: Vec3(x: -4, y: 1, z: 0), r: 1, m: Lambertian(a: ConstantTexture(color: Vec3(x: 0.4, y: 0.2, z: 0.1))))
    world.add(object)
    
    object = Sphere(c: Vec3(x: 4, y: 1, z: 0), r: 1, m: Metal(a: Vec3(x: 0.7, y: 0.6, z: 0.5 ), f: 0))
    world.add(object)
    
    return world
}

func makePerlinSpheres() -> Hitable {
    let perlinTexture = NoiseTexture(scale: 5.0)
    let world = HitableList()
    var object: Hitable
    
    object = Sphere(c: Vec3(x: 0, y: -1000, z: 0), r: 1000, m: Lambertian(a: perlinTexture))
    world.add(object)
    
    object = Sphere(c: Vec3(x: 0, y: 2, z: 0), r: 2, m: Lambertian(a: perlinTexture))
    world.add(object)
    
    return world
}

func makeEarth() -> Hitable {
    let imageTexture = ImageTexture(path: "/Users/kevinlindsey/Dropbox/Projects/RayTracingWeekend/earth_day.jpg")
    let world = HitableList()
    var object: Hitable
    
    object = Sphere(c: Vec3(x: 0, y: -1000, z: 0), r: 1000, m: Lambertian(a: ConstantTexture(color: Vec3(x: 0.4, y: 0.2, z: 0.1))))
    world.add(object)
    
    object = Sphere(c: Vec3(x: 0, y: 2, z: 0), r: 2, m: Lambertian(a: imageTexture))
    world.add(object)
    
    return world
}

// main

var nx = 400
var ny = 200
var ns = 25

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

let lookFrom = Vec3(x: 13, y: 2, z: 3)
let lookAt = Vec3(x: 0, y: 0, z: 0)
let distToFocus = 10.0 //(lookFrom - lookAt).length
let aperture = 0.0 // 2.0
let cam = Camera(
    lookFrom: lookFrom,
    lookAt: lookAt,
    vup: Vec3(x: 0, y: 1, z: 0),
    vfov: 20.0,
    aspect: Double(nx) / Double(ny),
    aperture: aperture,
    focus_dist: distToFocus,
    t0: 0.0,
    t1: 1.0
)

//let world = makeWorld()
//let world = makeRandomWorld()
//let world = makePerlinSpheres()
let world = makeEarth()

print("P3")
print(nx, ny)
print(255)

for j in (ny - 1).stride(through: 0, by: -1) {
    for i in 0..<nx {
        var col = Vec3(x: 0, y: 0, z: 0)
        
        for _ in 0..<ns {
            let u = (Double(i) + drand48()) / Double(nx)
            let v = (Double(j) + drand48()) / Double(ny)
            let r = cam.get_ray(u, v)
            
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
