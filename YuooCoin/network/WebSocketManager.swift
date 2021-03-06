//
//  WebSocketManager.swift
//  CryptExchange
//
//  Created by Yao Wang on 1/26/21.
//

import Foundation

func delay(_ delay:Double, closure:@escaping () -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}


final class WebSocketManager {
    static let shared = WebSocketManager()
    private var webSocketTask: URLSessionWebSocketTask?
    private var jsonDecoder = JSONDecoder()
    private var jsonEncoder = JSONEncoder()
    
    
    func connect(url: URL)-> Bool {
        disconnect()
        
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        return webSocketTask != nil
    }
    
    
    func disconnect() {
        print("disconnect")
        webSocketTask?.cancel()
        webSocketTask = nil
    }
    
    func send<T: Codable>(message: T) {
        if let jsonData = try? jsonEncoder.encode(message), let jsonStr = String(data: jsonData, encoding: .utf8) {
            self.webSocketTask?.send(.string(jsonStr)) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    // recusive version onmessage
    func readMessage<T: Codable>( after: Double, onMessage: @escaping (T) -> ()) {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(.string(let str)):
                if let data = try? JSONDecoder().decode(T.self, from: Data(str.utf8)) {
                    onMessage(data)
                    delay(after) {
                        self?.readMessage(after: after, onMessage: onMessage)
                    } 
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self?.disconnect()
            default:
                self?.disconnect()
            }
        }
    }
    
    // just once onmessage
    func readMessageOnce<T: Codable>( onMessage: @escaping (T) -> () ) {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(.string(let str)):
                if let list = try? JSONDecoder().decode(T.self, from: Data(str.utf8)) {
                    DispatchQueue.main.async {
                        onMessage(list)
                    }
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self?.disconnect()
            default:
                self?.disconnect()
            }
        }
    }
}
