//
//  BVHNode.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/3/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

class BVHNode : Hitable {
    let left: Hitable
    let right: Hitable
    let box: AABB
    var sortedItems: [Hitable]
    
    init(items: [Hitable], time0: Double, time1: Double) {
        let axis = Int(3 * drand48())
        
        switch axis {
        case 0:
            sortedItems = items.sort(box_x_compare)
        case 1:
            sortedItems = items.sort(box_y_compare)
        default:
            sortedItems = items.sort(box_z_compare)
        }
        
        let count = sortedItems.count
        
        switch count {
        case 1:
            left = sortedItems[0]
            right = sortedItems[0]
        case 2:
            left = sortedItems[0]
            right = sortedItems[1]
        default:
            let leftItems = sortedItems[0...(count / 2)]
            let rightItems = sortedItems[(count / 2)...(count - count / 2)]
            
            left = BVHNode(items: Array(leftItems), time0: time0, time1: time1)
            right = BVHNode(items: Array(rightItems), time0: time0, time1: time1)
        }
        
        if let boxLeft = left.boundingBox(time0, time1), boxRight = right.boundingBox(time0, time1) {
            box = surroundingBox(boxLeft, boxRight)
        }
        else {
            box = AABB(min: Vec3(x: 0, y: 0, z: 0), max: Vec3(x: 0, y: 0, z: 0))
        }
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        if box.hit(r, t_min, t_max) {
            let leftRecord = left.hit(r, t_min, t_max)
            let rightRecord = right.hit(r, t_min, t_max)
            
            if let hitLeft = leftRecord, hitRight = rightRecord {
                if hitLeft.t < hitRight.t {
                    return hitLeft
                }
                else {
                    return hitRight
                }
            }
            else if let hitLeft = leftRecord {
                return hitLeft
            }
            else if let hitRight = rightRecord {
                return hitRight
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return nil
    }
}

func box_x_compare(a: Hitable, b: Hitable) -> Bool {
    if let boxLeft = a.boundingBox(0, 0), boxRight = b.boundingBox(0, 0) {
        if boxLeft.min.x - boxRight.min.x < 0 {
            return true
        }
    }
    
    // true for <
    // false for >=
    return false
}

func box_y_compare(a: Hitable, b: Hitable) -> Bool {
    if let boxLeft = a.boundingBox(0, 0), boxRight = b.boundingBox(0, 0) {
        if boxLeft.min.y - boxRight.min.y < 0 {
            return true
        }
    }
    
    // true for <
    // false for >=
    return false
}

func box_z_compare(a: Hitable, b: Hitable) -> Bool {
    if let boxLeft = a.boundingBox(0, 0), boxRight = b.boundingBox(0, 0) {
        if boxLeft.min.z - boxRight.min.z < 0 {
            return true
        }
    }
    
    // true for <
    // false for >=
    return false
}
