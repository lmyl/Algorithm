//
//  ListNode.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/12.
//

import Foundation

class ListNode<T> {
    var value: T
    
    var next: ListNode<T>?
    
    init(value: T, next: ListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}
