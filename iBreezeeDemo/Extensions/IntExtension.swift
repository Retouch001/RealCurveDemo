//
//  IntExtension.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/11/6.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation


extension Int {
    static func random(in range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
}
