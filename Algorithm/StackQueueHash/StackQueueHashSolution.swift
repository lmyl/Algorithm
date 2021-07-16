//
//  StackQueueHashSolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/14.
//

import Foundation

/// 翻转栈
/// - Parameter statck: 栈
func reverse<T>(statck: Stack<T>) {
    var cache: [T] = []
    while !statck.isEmpty {
        cache.append(statck.pop()!)
    }
    for element in cache {
        statck.push(element: element)
    }
}

/// 排序，栈顶最小
/// - Parameter stack: 栈
func sort<T: Comparable>(stack: Stack<T>) {
    if stack.isEmpty {
        return
    }
    
    func bubble(stack: Stack<T>) -> Bool {
        if stack.isEmpty {
            return false
        }
        let top = stack.pop()!
        var isExchange = bubble(stack: stack)
        if let newTop = stack.top {
            if newTop < top {
                let temp = stack.pop()!
                stack.push(element: top)
                stack.push(element: temp)
                isExchange = true
            } else {
                stack.push(element: top)
            }
        } else {
            stack.push(element: top)
        }
        return isExchange
    }
    
    let isExchange = bubble(stack: stack)
    if isExchange {
        let top = stack.pop()!
        sort(stack: stack)
        stack.push(element: top)
    } else {
        return
    }
}


/// 给定入栈顺序和可能的出栈顺序,判断是否可以满足指定的出栈顺序
/// - Parameters:
///   - inputs: 入栈顺序
///   - outputs: 可能的出栈顺序
/// - Returns: 是否满足
func isSatisfiedForStack<T: Equatable>(inputs: [T], outputs: [T]) -> Bool {
    guard inputs.count == outputs.count else {
        return false
    }
    
    let stack = Stack<T>()
    
    var outputStatsfied = outputs.startIndex
    
    for input in inputs {
        stack.push(element: input)
        
        while !stack.isEmpty {
            if let top = stack.top, top == outputs[outputStatsfied] {
                _ = stack.pop()
                outputStatsfied += 1
            } else {
                break
            }
        }
    }
    
    if stack.isEmpty {
        return true
    } else {
        return false
    }
}
