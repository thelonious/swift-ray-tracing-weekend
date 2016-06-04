//
//  ConstantTexture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct ConstantTexture : Texture {
    let color: Vec3
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
        return color
    }
}
