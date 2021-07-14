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
