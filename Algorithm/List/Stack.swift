//
//  Stack.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/14.
//

import Foundation

class Stack<T> {
    private var source: [T] = []
    
    func push(element: T) {
        source.append(element)
    }
    
    func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return source.removeLast()
        }
    }
    
    var top: T? {
        source.last
    }
    
    var isEmpty: Bool {
        source.isEmpty
    }
    
    var size: Int {
        source.count
    }
    
}
