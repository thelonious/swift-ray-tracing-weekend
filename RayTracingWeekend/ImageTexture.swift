//
//  ImageTexture.swift
//  RayTracingWeekend
//
//  Created by Kevin Lindsey on 6/4/16.
//  Copyright © 2016 Kevin Lindsey. All rights reserved.
//

// heavily based on https://gist.github.com/jokester/948616a1b881451796d6

import Cocoa

class ImageTexture : Texture {
    let image: CGImage
    let context: CGContextRef
    
    var width: Int {
        get {
            return CGImageGetWidth(image)
        }
    }
    
    var height: Int {
        get {
            return CGImageGetHeight(image)
        }
    }
    
    init(path: String) {
        // "/Users/kevin/Documents/Projects/KevLinDev/ExtractPixels/earth_day.jpg"
        let nsimage = NSImage(contentsOfFile: path)
        
        image = nsimage!.CGImageForProposedRect(nil, context: nil, hints: nil)!
        context = ImageTexture.create_bitmap_context(image)
    }
    
    private class func create_bitmap_context(img: CGImage) -> CGContextRef {
        
        // Get image width, height
        let pixelsWide = CGImageGetWidth(img)
        let pixelsHigh = CGImageGetHeight(img)
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        let bitmapBytesPerRow = pixelsWide * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8,
                                            bitmapBytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        CGContextDrawImage(context, rect, img)
        
        return context!
    }
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
        let x = Int(u * Double(width))
        let y = Int(v * Double(height))
        
        let uncasted_data = CGBitmapContextGetData(context)
        let data = UnsafePointer<UInt8>(uncasted_data)
        
        let offset = 4 * (y * width + x)
        
        let red = data[offset+1]
        let green = data[offset+2]
        let blue = data[offset+3]
        
        return Vec3(
            x: Double(red) / 255.0,
            y: Double(green) / 255.0,
            z: Double(blue) / 255.0
        )
    }

}
