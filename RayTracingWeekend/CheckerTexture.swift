//
//  CheckerTexture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class CheckerTexture : Texture {
    let odd: Texture
    let even: Texture
    
    init(odd: Texture, even: Texture) {
        self.odd = odd
        self.even = even
    }
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
        let sines = sin(10 * p.x) * sin(10 * p.y) * sin(10 * p.z)
        
        return sines < 0.0 ? odd.value(u, v, p) : even.value(u, v, p)
    }
}
