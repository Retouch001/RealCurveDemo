//
//  FilterData.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/11/2.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation


let HIGH_PASS_ORDER4 = 5
let XX_LEN4 = 4


let bcgHighB4: [[Double]] = [
    [9.661396633989e-11, 3.864558653595e-10, 5.796837980393e-10, 3.864558653595e-10, 9.661396633989e-11],//0.5HZ
    [0.9837151741298, -3.934860696519, 5.902291044779, -3.934860696519, 0.9837151741298],//2HZ
    [0.0001832160233696, 0.0007328640934784, 0.001099296140218, 0.0007328640934784, 0.0001832160233696],//2HZ
    [0.9597822300872, -3.839128920349, 5.758693380523, -3.839128920349, 0.9597822300872],//2.5HZ
    [0.9519338983403, -3.807735593361, 5.711603390042, -3.807735593361, 0.9519338983403],//3HZ
    [0.9364275523716, -3.745710209486, 5.61856531423, -3.745710209486, 0.9364275523716]//4HZ
]

let bcgHighA4: [[Double]] = [
    [1, -3.983581258659, 5.950878429267, -3.951012436573, 0.9837152675105],
    [1, -3.967162595949, 5.902025861491, -3.902558784823, 0.9676955438131],
    [1, -3.344067837712, 4.238863950884, -2.409342856586, 0.517478199788],
    [1, -3.917907865392, 5.757076379118, -3.760349507695, 0.9211819291912],
    [1, -3.901490302634, 5.709294001763, -3.71397992224, 0.9061781468094],
    [1, -3.868656667909, 5.614526849635, -3.622760759561, 0.8768965608408]
]

struct DataFilter {
    var highEcgB4: [Double] = Array(repeating: 0.0, count: HIGH_PASS_ORDER4)
    var highEcgA4: [Double] = Array(repeating: 0.0, count: HIGH_PASS_ORDER4)
    
    var xx4: [Double] = Array(repeating: 0.0, count: 4)
    var yx4: [Double] = Array(repeating: 0.0, count: 4)
    
    
//    private mutating func highPassFilter(signal: Double, point: Int) -> Double {
//        var lous: Double = 0
//
//        for index in 0..<HIGH_PASS_ORDER4 {
//            highEcgB4[index] = bcgHighB4[point][index]
//            highEcgA4[index] = bcgHighA4[point][index]
//        }
//
////        for index in 0..<HIGH_PASS_ORDER4-1 {
////            lous += highEcgB4[index +1]*xx4[index] - highEcgA4[index + 1]
////        }
//    }
    
    
    
}
