//
//  hitable_list.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class hitable_list: hitable  {
    var list = [hitable]()
    
    var count: Int {
        return list.count
    }
    
    func add(h: hitable) {
        list.append(h)
    }
    
    func hit(r: ray, _ t_min: Double, _ t_max: Double, inout _ rec: hit_record) -> Bool {
        var hit_anything = false
        
        for item in list {
            if item.hit(r, t_min, t_max, &rec) {
                hit_anything = true
                break;
            }
        }
        
        return hit_anything
    }
}
