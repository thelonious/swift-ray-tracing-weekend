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
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        var result: HitRecord? = nil
        var closest_so_far = t_max
        
        for item in list {
            if let record = item.hit(r, t_min, closest_so_far) {
                result = record
                closest_so_far = record.t
            }
        }
        
        return result
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        var result: AABB? = nil
        
        if list.count < 1 {
            return nil
        }
        
        if let tempBox = list[0].boundingBox(t0, t1) {
            result = tempBox
        }
        else {
            return nil
        }
        
        for elem in list {
            if let tempBox = elem.boundingBox(t0, t1) {
                result = surroundingBox(result!, tempBox)
            }
            else {
                return nil
            }
        }
        
        return result
    }
}
