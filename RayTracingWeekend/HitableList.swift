//
//  hitable_list.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class HitableList: Hitable  {
    var list = [Hitable]()
    
    var count: Int {
        return list.count
    }
    
    func add(h: Hitable) {
        list.append(h)
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double, inout _ rec: HitRecord) -> Bool {
        var temp_rec = HitRecord()
        var hit_anything = false
        var closest_so_far = t_max
        
        for item in list {
            if item.hit(r, t_min, closest_so_far, &temp_rec) {
                hit_anything = true
                closest_so_far = temp_rec.t
                rec = temp_rec
            }
        }
        
        return hit_anything
    }
}
