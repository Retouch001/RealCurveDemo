//
//  SocketManager.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/31.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation


protocol SocketDelegate: class {
    func socketDidConnectedToHost(sock: GCDAsyncSocket)
    func socketDidDisconnect(withError err: Error?)
    func socketDidReadData(data: Data)
}

class Socket: NSObject {
    typealias connectCompletion = (_ error: Error?) -> Void

    static let share = Socket()
    
    var socket: GCDAsyncSocket!
    
    weak var delegate: SocketDelegate?
    
    override init() {
        super.init()
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    func connect(toHost: String, onPort: UInt16, completion: @escaping connectCompletion) {
        do {
            try socket.connect(toHost: toHost, onPort: onPort, withTimeout: -1)
        } catch let error {
            completion(error)
        }
    }
    
    func send(data: Data) {
        if socket.isConnected {
            socket.write(data, withTimeout: -1, tag: 0)
            socket.readData(withTimeout: -1, tag: 0)
        }
    }
    
    func disconnect() {
        socket.disconnect()
    }
}

extension Socket: GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        //printLog("socket connect success")
        delegate?.socketDidConnectedToHost(sock: sock)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        delegate?.socketDidDisconnect(withError: err)
        //printLog("socket disconnect:\(String(describing: err?.localizedDescription))")
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
//        printLog("socket write data success")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        delegate?.socketDidReadData(data: data)
        sock.readData(withTimeout: -1, tag: 0)
    }
}
