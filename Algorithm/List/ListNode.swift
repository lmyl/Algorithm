//
//  ListNode.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/12.
//

import Foundation

/// 带头指针的链表
class ListHeade<T>: CustomStringConvertible {
    var next: ListNode<T>?
    
    static func makeList(for values: [T]) -> ListHeade<T> {
        let heade = ListHeade()
        heade.next = ListNode.makeList(for: values)
        
        return heade
    }
    
    var description: String {
        self.next?.description ?? ""
    }
}

/// 普通单链表
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

class DoubleDirectListNode<T>: CustomStringConvertible {
    var value: T
    var next: DoubleDirectListNode<T>?
    var previous: DoubleDirectListNode<T>?
    
    init(value: T) {
        self.value = value
    }
    
    static func makeList(for values: [T]) -> DoubleDirectListNode<T>? {
        guard !values.isEmpty else {
            return nil
        }
        var first: DoubleDirectListNode<T>?
        var trail = first
        
        for value in values {
            let newNode = DoubleDirectListNode(value: value)
            if first == nil {
                first = newNode
                trail = newNode
            } else {
                trail?.next = newNode
                newNode.previous = trail
                trail = newNode
            }
        }
        return first
    }
    
    var description: String {
        var result = ""
        var current: DoubleDirectListNode? = self
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

/// 具有两个指针的变异链表
class MutationsListNode<T> {
    var value: T
    
    var next: MutationsListNode<T>?
    var mutationsNext: MutationsListNode<T>?
    
    init(value: T, next: MutationsListNode<T>? = nil, mutationsNext: MutationsListNode<T>? = nil) {
        self.value = value
        self.next = next
        self.mutationsNext = mutationsNext
    }
}
