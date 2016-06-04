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
    
    func boundingBox(t0: Double, _ t1: Double, inout _ box: AABB) -> Bool {
        if list.count < 1 {
            return false
        }
        
        var tempBox = AABB(min: Vec3(x: 0, y: 0, z: 0), max: Vec3(x: 0, y: 0, z: 0))
        let firstTrue = list[0].boundingBox(t0, t1, &tempBox)
        
        if !firstTrue {
            return false
        }
        else {
            box = tempBox
        }
        
        for elem in list {
            if elem.boundingBox(t0, t1, &tempBox) {
                box = surroundingBox(box, box1: tempBox)
            }
            else {
                return false
            }
        }
        
        return true
    }
}
