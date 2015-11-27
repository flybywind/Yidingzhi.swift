//
//  SuitStatus.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/26.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class SuitStatus : NSObject{
    var dressType:String
    var selectPart:String?
    var selectFabric: UIImage?
    
    override init() {
        dressType = "西服"
        super.init()
    }
}

struct FabricInfo {
    var Fid: String
    var FabricBrand: String
    var FabricMaterial:String
    var FabricPrice: Float
    var FabricImage: String
}