//
//  Stack.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/14.
//

import Foundation

protocol StackProxy {
    associatedtype Element
    
    func push(element: Element)
    
    func pop() -> Element?
    
    var top: Element? {get}
    
    var isEmpty: Bool {get}
    
    var size: Int {get}
}

class Stack<T>: StackProxy {
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

class MinStack<T: Comparable>: Stack<T> {
    private var minStack = Stack<T>()
    
    override func push(element: T) {
        if let top = minStack.top {
            if top > element {
                minStack.push(element: element)
            } else {
                minStack.push(element: top)
            }
            super.push(element: element)
        } else {
            super.push(element: element)
            minStack.push(element: element)
        }
    }
    
    override func pop() -> T? {
        _ = minStack.pop()
        return super.pop()
    }
    
    var min: T? {
        minStack.top
    }
}
