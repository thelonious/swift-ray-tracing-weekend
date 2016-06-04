//
//  Texture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public protocol Texture {
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3
}
