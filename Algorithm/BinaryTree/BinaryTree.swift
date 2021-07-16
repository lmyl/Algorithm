//
//  BinaryTree.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/16.
//

import Foundation

class BinaryTreeNode<T>: CustomStringConvertible {
    var value: T
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?
    
    init(value: T) {
        self.value = value
    }
    
    var description: String {
        var cacheParents = [self]
        var cacheSons: [BinaryTreeNode<T>] = []
        
        var result = ""
        while !cacheParents.isEmpty {
            let node = cacheParents.removeFirst()
            if let left = node.left {
                cacheSons.append(left)
            }
            if let right = node.right {
                cacheSons.append(right)
            }
            result += "\(node.value)"
            if !cacheParents.isEmpty {
                result += ","
            } else {
                cacheParents = cacheSons
                if !cacheSons.isEmpty {
                    result += "\n"
                }
                cacheSons = []
            }
        }
        
        return result
    }
}
