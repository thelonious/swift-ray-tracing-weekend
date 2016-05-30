//
//  hitable.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public protocol hitable {
    func hit(r: ray, _ t_min: Double, _ t_max: Double, inout _ rec: hit_record) -> Bool
}
