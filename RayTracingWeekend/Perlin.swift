//
//  Perlin.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Perlin {
    let ranFloat: [Double]
    let permX: [Int]
    let permY: [Int]
    let permZ: [Int]
    
    init() {
        ranFloat = perlinGenerate()
        permX = perlinGeneratePerm()
        permY = perlinGeneratePerm()
        permZ = perlinGeneratePerm()
    }
    
    func noise(p: Vec3) -> Double {
        var u = p.x - floor(p.x)
        var v = p.y - floor(p.y)
        var w = p.z - floor(p.z)
        
        u = u*u*(3-2*u)
        v = v*v*(3-2*v)
        w = w*w*(3-2*w)
        
        let i = Int(floor(p.x))
        let j = Int(floor(p.y))
        let k = Int(floor(p.z))
        
        var c = Array(count: 2, repeatedValue:
            Array(count: 2, repeatedValue:
                Array(count: 2, repeatedValue: 0.0)))
        
        for di in 0..<2 {
            for dj in 0..<2 {
                for dk in 0..<2 {
                    c[di][dj][dk] = ranFloat[permX[(i+di)&255] ^ permY[(j+dj)&255] ^ permZ[(k+dk)&255]]
                }
            }
        }
        
//        return ranFloat[permX[i] ^ permY[j] ^ permZ[k]]
        return trilinearInterp(c, u, v, w)
    }
}

func perlinGenerate() -> [Double] {
    var doubles = Array(count: 256, repeatedValue: 0.0)
    
    for i in 0..<doubles.count {
        doubles[i] = drand48()
    }
    
    return doubles
}

func perlinGeneratePerm() -> [Int] {
    var ints = Array(count: 256, repeatedValue: 0)
    
    for i in 0..<ints.count {
        ints[i] = i
    }
    
    for i in (ints.count - 1).stride(to: 0, by: -1) {
        let target = Int(drand48() * Double(i + 1))
        let temp = ints[i]
        
        ints[i] = ints[target]
        ints[target] = temp
    }
    
    return ints
}

func trilinearInterp(c: [[[Double]]], _ u: Double, _ v: Double, _ w: Double) -> Double {
    var accum = 0.0
    
    for i in 0..<2 {
        let ii = Double(i)
        
        for j in 0..<2 {
            let jj = Double(j)
            
            for k in 0..<2 {
                let kk = Double(k)
                
                accum +=
                    (ii * u + (1.0 - ii) * (1.0 - u)) *
                    (jj * v + (1.0 - jj) * (1.0 - v)) *
                    (kk * w + (1.0 - kk) * (1.0 - w)) *
                    c[i][j][k]
            }
        }
    }
    
    return accum
}
