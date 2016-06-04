//
//  CheckerTexture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct CheckerTexture : Texture {
    let odd: Texture
    let even: Texture
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
        let sines = sin(10 * p.x) * sin(10 * p.y) * sin(10 * p.z)
        
        if sines < 0.0 {
            return odd.value(u, v, p)
        }
        else {
            return even.value(u, v, p)
        }
    }
}
