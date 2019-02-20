//
//  Doit.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/26.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation

enum DotType: Int, Codable {
    case normal
    case high
    case low
    case disorder
}


struct Dot: Codable {
    let value: Double
    let timeStamp: TimeInterval
    let dotType: DotType
}
