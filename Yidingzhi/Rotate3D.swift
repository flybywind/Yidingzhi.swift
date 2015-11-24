//
//  Rotate3D.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/22.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import Foundation
import SceneKit

struct Rotate3D {
    var rx:Float,
        ry:Float,
        rz:Float
    let maxRx: Float,
        maxRy: Float,
        maxRz: Float
    
    func rotate3DMatrix() ->SCNMatrix4 {
        var mat = SCNMatrix4MakeRotation(rx, 1, 0, 0)
        mat = SCNMatrix4Rotate(mat, ry, 0, 1, 0)
        mat = SCNMatrix4Rotate(mat, rz, 0, 0, 1)
//        print("rotate around x by", rx)
//        print("rotate around y by", ry)
//        print("rotate around z by", rz)
//        print("================")
        return mat
    }

    
    mutating func rotate3DAdd(rotX drx:Float, rotY dry:Float, rotZ drz:Float) {
        rx += drx
        ry += dry
        rz += drz
        
        rx = setMax(rx, maxRx)
        ry = setMax(ry, maxRy)
        rz = setMax(rz, maxRz)
    }
    
    private func setMax(var val:Float, _ threshod:Float) ->Float{
        if threshod > 0 {
            if val > 0 {
                val = min(threshod, val)
            } else {
                val = max(-threshod, val)
            }
        }
        return val
    }
}