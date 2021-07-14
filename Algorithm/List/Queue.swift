//
//  Queue.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/14.
//

import Foundation

class Queue<T> {
    private var source: [T] = []
    
    func push(element: T) {
        source.append(element)
    }
    
    func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return source.removeFirst()
        }
    }
    
    private var isEmpty: Bool {
        source.isEmpty
    }
    
    var heade: T? {
        source.first
    }
    
    var trail: T? {
        source.last
    }
    
    var size: Int {
        source.count
    }
}
