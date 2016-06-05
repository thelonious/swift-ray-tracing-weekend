//
//  NoiseTexture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct NoiseTexture : Texture {
    let noise = Perlin()
    let scale: Double
    
    init() {
        self.scale = 1.0
    }
    
    init(scale: Double) {
        self.scale = scale
    }
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
//        return Vec3(x: 1, y: 1, z: 1) * 0.5 * (1 + noise.noise(scale * p))
//        return Vec3(x: 1, y: 1, z: 1) * noise.turbulence(scale * p, depth: 7)
        return Vec3(x: 1, y: 1, z: 1) * 0.5 * (1 + sin(scale * p.z + 10 * noise.turbulence(p, depth: 7)))
    }
}
