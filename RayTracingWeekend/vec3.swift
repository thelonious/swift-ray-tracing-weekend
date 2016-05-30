//
//  vec3.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 5/30/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

public struct vec3 : CustomStringConvertible {
    var x: Double
    var y: Double
    var z: Double
    
    var r: Double {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    var g: Double {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    var b: Double {
        get {
            return z
        }
        set {
            z = newValue
        }
    }
    
    public var description: String {
        return "\(x) \(y) \(z)"
    }
    
    var length: Double {
        return sqrt(x*x + y*y + z*z)
    }
    
    // aka. Magnitude
    var squared_length: Double {
        return x*x + y*y + z*z
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    func dot(v2: vec3) -> Double {
        return x * v2.x + y * v2.y + z * v2.z
    }
    
    func cross(v2: vec3) -> vec3 {
        let rx = y*v2.z - z*v2.y
        let ry = -(x*v2.z - z*v2.x)
        let rz = x * v2.y - y * v2.x
        
        return vec3(x: rx, y: ry, z: rz)
    }
    
    func unit_vector() -> vec3 {
        let k = 1.0 / sqrt(x*x + y*y + z*z)
        
        return vec3(x: x * k, y: y * k, z: z * k)
    }
}

func + (v1: vec3, v2: vec3) -> vec3 {
    return vec3(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)
}

func - (v1: vec3, v2: vec3) -> vec3 {
    return vec3(x: v1.x - v2.x, y: v1.y - v2.y, z: v1.z - v2.z)
}

func * (v1: vec3, v2: vec3) -> vec3 {
    return vec3(x: v1.x * v2.x, y: v1.y * v2.y, z: v1.z * v2.z)
}

func / (v1: vec3, v2: vec3) -> vec3 {
    return vec3(x: v1.x / v2.x, y: v1.y / v2.y, z: v1.z / v2.z)
}

func * (v: vec3, s: Double) -> vec3 {
    return vec3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func * (s: Double, v: vec3) -> vec3 {
    return vec3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func / (v: vec3, s: Double) -> vec3 {
    return vec3(x: v.x / s, y: v.y / s, z: v.z / s)
}
