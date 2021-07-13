//
//  ListNode.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/12.
//

import Foundation


class ListNode<T>: CustomStringConvertible {
    var value: T
    
    var next: ListNode<T>?
    
    init(value: T, next: ListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
    
    static func makeList(for values: [T]) -> ListNode<T>? {
        var first: ListNode<T>?
        var trail = first
        
        for value in values {
            let node = ListNode(value: value)
            if first == nil {
                first = node
                trail = node
            } else {
                trail?.next = node
                trail = node
            }
        }
        
        return first
    }
    
    var description: String {
        var result = ""
        var current: ListNode? = self
        while let node = current {
            result += "\(node.value)"
            current = node.next
            if current != nil {
                result += ","
            }
        }
        return result
    }
    
}
