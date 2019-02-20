//
//  DataCoordinator.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/25.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation

let host = "10.10.10.1"
let port: UInt16 = 1000

let startData = Data(bytes: [0x24, 0x12, 0x00, 0x03, 0xC1, 0x01, 0xff, 0x69, 0x42])
let endData = Data(bytes: [0x24, 0x12, 0x00, 0x03, 0xC8, 0x01, 0xff, 0x69, 0x42])

let period = 0.02


class DataAgent: NSObject {
    
    var timer: DispatchSourceTimer!
    var syncTimeData: Data {
        let date = Date()
        let bytes = [0x24, 0x12, 0x00, 8, 0xC7, UInt8(date.year%1000), UInt8(date.month), UInt8(date.day), UInt8(date.hour), UInt8(date.minute), UInt8(date.second), 0xff, 0x69, 0x42]
        return Data(bytes: bytes)
    }
    
    typealias handle = () -> ()
    var connectHandle: handle!
    var disconnectHandle: handle!
    
    override init() {
        super.init()
        Socket.share.delegate = self
    }
    
    var cacheData = Data()// data from tcp
    var cacheValue1 = [UInt16]()// first belt data array
    var cacheValue2 = [UInt16]()// second belt data array
    
    typealias driveCurveClosure = (Double, Double) -> ()
    
    func startDriveCurveView(handle: @escaping driveCurveClosure) {
        timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
        timer.schedule(deadline: .now(), repeating: period)
        timer.setEventHandler(handler: {
            if let value1 = self.cacheValue1.first, let value2 = self.cacheValue2.first {
                handle(3300 - Double(value1), 3300 - Double(value2))
                self.cacheValue1.removeSubrange(Range(0...9))
                self.cacheValue2.removeSubrange(Range(0...9))
            }
        })
        timer.resume()
    }
    
    func stopDriveCurveView() {
        timer.cancel()
        timer = nil
    }
    
}

//MARK: SocketDelegate
extension DataAgent: SocketDelegate {
    func socketDidConnectedToHost(sock: GCDAsyncSocket) {
        connectHandle()
//        printLog("socket connect success")
        usleep(50000)
        Socket.share.send(data: self.syncTimeData)
        usleep(50000)
        Socket.share.send(data: startData)
    }
    
    func socketDidDisconnect(withError err: Error?) {
        disconnectHandle()
        printLog("socket disconnect: \(String(describing: err))")
    }
    
    func socketDidReadData(data: Data) {
//        printLog("socket recieve data")
        unpack(data: data)
    }
}

//MARK: Data Parse
extension DataAgent {
    private func unpack(data: Data) {
        cacheData.append(data)
        print(cacheData as NSData)
        while cacheData.count > 4 {
            let bytes = cacheData.bytes
            guard bytes.first == 0x24 && bytes[1] == 0x12 else {
                for (index, byte) in bytes.enumerated() {
                    if byte == 0x24 && cacheData.count > index+1 && bytes[index+1] == 0x12{
                        cacheData.removeSubrange(Range(0...index-1))
                        printLog("😆😆😆")
                        break
                    }
                }
                return
            }
            
            let dataLength: UInt = UInt(bytes[2])<<8 + UInt(bytes[3])//有效数据长度
            let totalLength = 4 + dataLength + 2//数据包长度
            
            guard cacheData.count >= totalLength else { return } //返回继续追加数据
            guard bytes[Int(totalLength-2)] == 0x69 && bytes[Int(totalLength-1)] == 0x42 else {
                var tempIndex = 0
                for (index, byte) in bytes.enumerated() {
                    if byte == 0x24 && cacheData.count > index + 1 && bytes[index + 1] == 0x12 {
                        tempIndex += 1
                        if tempIndex == 2 {
                            cacheData.removeSubrange(Range(0...index-1))
                            printLog("😆😆😆")
                            break
                        }
                    }
                }
                return
            }
            let currentData = cacheData.subdata(in: Range(7...Int(totalLength-4)))
            parsePack(data: currentData)
            cacheData.removeSubrange(Range(0...Int(totalLength-1)))
        }
    }
    
    private func parsePack(data: Data) {
        let bytes = data.bytes
        for (index ,_) in bytes.enumerated() {
            if index%4 == 0 {
                let value1 = UInt16(bytes[index]) << 8 | UInt16(bytes[index+1])
                let value2 = UInt16(bytes[index+2]) << 8 | UInt16(bytes[index+3])
                cacheValue1.append(value1)
                cacheValue2.append(value2)
            }
        }
    }
    
}


//let value1 = UnsafePointer([value, bytes[index+1]]).withMemoryRebound(to: UInt16.self, capacity: 1) { $0.pointee }
//let value2 = UnsafePointer([bytes[index+2], bytes[index+3]]).withMemoryRebound(to: UInt16.self, capacity: 1) { $0.pointee }







