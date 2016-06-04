//
//  hitable.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public protocol Hitable {
    func hit(r: Ray, _ t_min: Double, _ t_max: Double, inout _ rec: HitRecord) -> Bool
    func boundingBox(t0: Double, _ t1: Double, inout _ box: AABB) -> Bool
}
