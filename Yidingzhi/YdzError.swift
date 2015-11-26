//
//  YdzError.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/26.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import Foundation

enum YdzError : ErrorType {
    case Debug(msg:String)
    case Unexpected
    case InvalidValue
    case OutBound
}