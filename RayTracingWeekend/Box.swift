//
//  Box.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/9/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class Box : Hitable {
    let pmin: Vec3
    let pmax: Vec3
    let sides: HitableList
    
    init(p0: Vec3, p1: Vec3, material: Material) {
        pmin = p0
        pmax = p1
        
        sides = HitableList()
        sides.add(XYRect(x0: p0.x, x1: p1.x, y0: p0.y, y1: p1.y, k: p1.z, material: material))
        sides.add(FlipNormal(ptr: XYRect(x0: p0.x, x1: p1.x, y0: p0.y, y1: p1.y, k: p0.z, material: material)))
        sides.add(XZRect(x0: p0.x, x1: p1.x, z0: p0.z, z1: p1.z, k: p1.y, material: material))
        sides.add(FlipNormal(ptr: XZRect(x0: p0.x, x1: p1.x, z0: p0.z, z1: p1.z, k: p0.y, material: material)))
        sides.add(YZRect(y0: p0.y, y1: p1.y, z0: p0.z, z1: p1.z, k: p1.x, material: material))
        sides.add(FlipNormal(ptr: YZRect(y0: p0.y, y1: p1.y, z0: p0.x, z1: p1.z, k: p0.x, material: material)))
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        return sides.hit(r, t_min, t_max)
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: pmin, max: pmax)
    }
}
