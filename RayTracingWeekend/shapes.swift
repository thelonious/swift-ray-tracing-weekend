//
//  shapes.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public struct hit_record {
    var t = 0.0
    var p = Vec3(x: 0, y: 0, z: 0)
    var normal = Vec3(x: 0, y: 0, z: 0)
    var material: Material = Metal(a: Vec3(x: 0, y: 0, z: 0), f: 0)
}
