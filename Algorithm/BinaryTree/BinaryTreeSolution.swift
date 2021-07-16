//
//  BinaryTreeSolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/16.
//

import Foundation

/// 将有序数组变换为一个有序二叉树
/// - Parameter sortSource: 有序数组
/// - Returns: 有序二叉树
func generateBinaryTree<T>(from sortSource: [T]) -> BinaryTreeNode<T>? {
    guard !sortSource.isEmpty else {
        return nil
    }
    guard sortSource.count > 1 else {
        return BinaryTreeNode(value: sortSource[0])
    }
    
    let middleIndex = sortSource.count / 2
    let root = BinaryTreeNode(value: sortSource[middleIndex])
    let left = Array(sortSource[0 ..< middleIndex])
    let right = Array(sortSource[middleIndex + 1 ..< sortSource.count])
    let leftNode = generateBinaryTree(from: left)
    let rightNode = generateBinaryTree(from: right)
    root.left = leftNode
    root.right = rightNode
    
    return root
}
