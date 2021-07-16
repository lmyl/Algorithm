//
//  Queue.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/14.
//

import Foundation

protocol QueueProxy {
    associatedtype Element
    
    func push(element: Element)
    
    func pop() -> Element?
    
    var heade: Element? {get}
    
    var trail: Element? {get}
    
    var size: Int {get}
}

class Queue<T>: QueueProxy {
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

class QueueStack<T>: QueueProxy {
    private var input = Stack<T>()
    private var output = Stack<T>()
    
    
    func push(element: T) {
        input.push(element: element)
    }
    
    func pop() -> T? {
        if output.isEmpty {
            while !input.isEmpty {
                output.push(element: input.pop()!)
            }
        }
        return output.pop()
    }
    
    var heade: T? {
        if output.isEmpty {
            while !input.isEmpty {
                output.push(element: input.pop()!)
            }
        }
        return output.top
    }
    
    var trail: T? {
        if input.isEmpty {
            while !output.isEmpty {
                input.push(element: output.pop()!)
            }
        }
        return input.top
    }
    
    var size: Int {
        input.size + output.size
    }
}


