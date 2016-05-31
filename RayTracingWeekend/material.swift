//
//  material.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

protocol Material {
    func scatter(r_in: ray, _ rec: hit_record, inout _ attentuation: Vec3, inout _ scattered: ray) -> Bool
}
