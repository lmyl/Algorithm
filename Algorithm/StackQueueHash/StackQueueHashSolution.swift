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

/// 根据每一段路线，恢复出整个路线，路线不带环，且路线只有一个起点和一个终点
/// - Parameter source: 路线段
/// - Returns: 整个路线
func generateRouteLine(for source: [String: String]) -> [String] {
    guard let first = source.first else {
        return []
    }
    var reverse: [String: String] = [:]
    for (key, value) in source {
        reverse[value] = key
    }
    
    var fragmentStart = first.key
    var fragmentEnd = first.value
    var rightSource: [String] = [fragmentEnd]
    var leftSource: [String] = [fragmentStart]
    
    while let end = source[fragmentEnd] {
        fragmentEnd = end
        rightSource.append(end)
    }
    
    while let start = reverse[fragmentStart] {
        fragmentStart = start
        leftSource.append(start)
    }
    
    return leftSource.reversed() + rightSource
}

/// 从数组中找出a+b=c+d，其中abcd均互不为同一个元素
/// - Parameter source: 数据源
/// - Returns: 查找出来的元素
func fourSum<T: AdditiveArithmetic & Comparable & Hashable>(for source: [T]) -> ((T, T), (T, T))? {
    guard source.count >= 4 else {
        return nil
    }
    var sumMap: [T: (Int, Int)] = [:]
    
    for index in 0 ..< source.count {
        let value1 = source[index]
        for another in (index + 1) ..< source.count {
            let value2 = source[another]
            let sum = value2 + value1
            if let coupleIndex = sumMap[sum] {
                if coupleIndex.0 == index || coupleIndex.0 == another || coupleIndex.1 == index || coupleIndex.1 == another {
                    continue
                } else {
                    return ((source[coupleIndex.0], source[coupleIndex.1]), (value1, value2))
                }
            } else {
                sumMap[sum] = (index, another)
            }
        }
    }
    
    return nil
}
