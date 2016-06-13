//
//  hitable.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

protocol Hitable {
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord?
    func boundingBox(t0: Double, _ t1: Double) -> AABB?
}
