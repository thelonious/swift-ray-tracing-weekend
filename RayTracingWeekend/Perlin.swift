//
//  Perlin.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

import Foundation

struct Perlin {
    let ranVector: [Vec3]
    let permX: [Int]
    let permY: [Int]
    let permZ: [Int]
    
    init() {
        ranVector = perlinGenerate()
        permX = perlinGeneratePerm()
        permY = perlinGeneratePerm()
        permZ = perlinGeneratePerm()
    }
    
    func noise(p: Vec3) -> Double {
        let u = p.x - floor(p.x)
        let v = p.y - floor(p.y)
        let w = p.z - floor(p.z)
        
        let i = Int(floor(p.x))
        let j = Int(floor(p.y))
        let k = Int(floor(p.z))
        
        var c = Array(count: 2, repeatedValue:
            Array(count: 2, repeatedValue:
                Array(count: 2, repeatedValue: Vec3(x: 0, y: 0, z: 0))))
        
        for di in 0..<2 {
            for dj in 0..<2 {
                for dk in 0..<2 {
                    c[di][dj][dk] = ranVector[permX[(i+di)&255] ^ permY[(j+dj)&255] ^ permZ[(k+dk)&255]]
                }
            }
        }
        
//        return ranFloat[permX[i] ^ permY[j] ^ permZ[k]]
//        return trilinearInterp(c, u, v, w)
        return perlinInterp(c, u, v, w)
    }
    
    func turbulence(p: Vec3, depth: Int) -> Double {
        var accum = 0.0
        var temp = p
        var weight = 1.0
        
        for _ in 0..<depth {
            accum += weight * noise(temp)
            weight *= 0.5
            temp = temp * 2
        }
        
        return abs(accum)
    }
}

func perlinGenerate() -> [Vec3] {
    var vectors = Array(count: 256, repeatedValue: Vec3(x: 0, y: 0, z: 0))
    
    for i in 0..<vectors.count {
        let vector = Vec3(x: -1 + 2 * drand48(), y: -1 + 2 * drand48(), z: -1 + 2 * drand48())
        
        vectors[i] = vector.unit_vector()
    }
    
    return vectors
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

func perlinInterp(c: [[[Vec3]]], _ u: Double, _ v: Double, _ w: Double) -> Double {
    let uu = u*u*(3-2*u)
    let vv = v*v*(3-2*v)
    let ww = w*w*(3-2*w)
    
    var accum = 0.0
    
    for i in 0..<2 {
        let ii = Double(i)
        
        for j in 0..<2 {
            let jj = Double(j)
            
            for k in 0..<2 {
                let kk = Double(k)
                let weight = Vec3(x: u-ii, y: v-jj, z: w-kk)
                
                accum +=
                    (ii * uu + (1.0 - ii) * (1.0 - uu)) *
                    (jj * vv + (1.0 - jj) * (1.0 - vv)) *
                    (kk * ww + (1.0 - kk) * (1.0 - ww)) *
                    c[i][j][k].dot(weight)
            }
        }
    }
    
    return accum
}
