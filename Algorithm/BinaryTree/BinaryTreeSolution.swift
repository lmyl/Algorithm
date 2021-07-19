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

/// 使用递归的方法层序遍历二叉树
/// - Parameter root: 根结点
/// - Returns: 遍历后的字符串
func levelTraversalByRecursion<T>(for root: BinaryTreeNode<T>) -> String {
    func level(for root: BinaryTreeNode<T>) -> Int {
        var leftLevel = 0
        var rightLevel = 0
        if let left = root.left {
            leftLevel = level(for: left)
        }
        
        if let right = root.right {
            rightLevel = level(for: right)
        }
        
        return 1 + max(leftLevel, rightLevel)
    }
    
    let level = level(for: root)
    
    func levelTraversal(for root: BinaryTreeNode<T>, level: Int) -> String {
        if level == 1 {
            return "\(root.value),"
        }
        
        var result = ""
        if let left = root.left {
            result += levelTraversal(for: left, level: level - 1)
        }
        
        if let right = root.right {
            result += levelTraversal(for: right, level: level - 1)
        }
        
        return result
    }
    
    var result = ""
    for lev in 1 ... level {
        var resultLev = levelTraversal(for: root, level: lev)
        if !resultLev.isEmpty {
            resultLev.removeLast()
            resultLev += "\n"
        }
        if lev == level {
            resultLev.removeLast()
        }
        result += resultLev
    }
    
    return result
}


/// 如何求一颗二叉树的最大子树和
/// - Parameter root: 根结点
/// - Returns: 最大子树和 和对应的根结点
func maximumSubTreeSum<T: Comparable & AdditiveArithmetic>(for root: BinaryTreeNode<T>) -> (max: T, node: BinaryTreeNode<T>) {
    
    func maximumSubTreeSumAndCurrentSubTreeSum(for root: BinaryTreeNode<T>) -> (current: T, max: T, maxNode: BinaryTreeNode<T>) {
        var current = root.value
        var max: T?
        var maxNode: BinaryTreeNode<T>?
        if let left = root.left {
            let mix = maximumSubTreeSumAndCurrentSubTreeSum(for: left)
            current += mix.current
            max = mix.max
            maxNode = mix.maxNode
        }
        
        if let right = root.right {
            let mix = maximumSubTreeSumAndCurrentSubTreeSum(for: right)
            current += mix.current
            if let maxValue = max {
                if maxValue < mix.max {
                    max = mix.max
                    maxNode = mix.maxNode
                }
            } else {
                max = mix.max
                maxNode = mix.maxNode
            }
        }
        
        if let maxValue = max {
            if maxValue < current {
                max = current
                maxNode = root
            }
        } else {
            max = current
            maxNode = root
        }
        
        return (current, max!, maxNode!)
    }
    
    let maxAndNode = maximumSubTreeSumAndCurrentSubTreeSum(for: root)
    return (maxAndNode.max, maxAndNode.maxNode)
}

/// 判断两个二叉树是否相等，同样的结构，同样的值
/// - Parameters:
///   - first: 第一个二叉树
///   - second: 第二个二叉树
/// - Returns: 是否相等
func equalBinaryTree<T: Equatable>(for first: BinaryTreeNode<T>, second: BinaryTreeNode<T>) -> Bool {
    guard first.value == second.value else {
        return false
    }
    
    var result = false
    if let leftF = first.left {
        if let leftS = second.left {
            result = equalBinaryTree(for: leftF, second: leftS)
        } else {
            result = false
        }
    } else {
        if let _ = second.left {
            result = false
        } else {
            result = true
        }
    }
    
    guard result else {
        return false
    }
    
    if let rightF = first.right {
        if let rightS = second.right {
            result = equalBinaryTree(for: rightF, second: rightS)
        } else {
            result = false
        }
    } else {
        if let _ = second.right {
            result = false
        } else {
            result = true
        }
    }
    
    return result
}

/// 将二元查找树转换为有序的双向链表，不允许创建新节点
/// - Parameter root: 根结点
/// - Returns: 链表头节点
func convertSearchBinaryTreeToDoubleDirectList<T>(for root: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
    func convertSearchBinaryTree(for root: BinaryTreeNode<T>) -> (heade: BinaryTreeNode<T>, trail: BinaryTreeNode<T>) {
        var leftList: (heade: BinaryTreeNode<T>, trail: BinaryTreeNode<T>)?
        if let left = root.left {
            leftList = convertSearchBinaryTree(for: left)
        }
        var rightList: (heade: BinaryTreeNode<T>, trail: BinaryTreeNode<T>)?
        if let right = root.right {
            rightList = convertSearchBinaryTree(for: right)
        }
        var result = (root, root)
        root.left = nil
        root.right = nil
        if let left = leftList {
            left.trail.left = result.0
            result.0.right = left.trail
            result = (left.heade, result.1)
        }
        
        if let right = rightList {
            right.heade.right = result.1
            result.1.left = right.heade
            result = (result.0, right.trail)
        }
        
        return result
    }
    
    return convertSearchBinaryTree(for: root).heade
}

/// 判断一个序列是不是二叉树的后序遍历
/// - Parameters:
///   - root: 根结点
///   - sequence: 后序遍历序列
/// - Returns: 是否满足后序遍历序列
func isFollowUpTraversal<T: Equatable>(for root: BinaryTreeNode<T>, sequence: [T]) -> Bool {
    var count = 0
    var temp: [T] = []
    func isFollowUpTraversal(for root: BinaryTreeNode<T>) -> Bool {
        if let left = root.left {
            if !isFollowUpTraversal(for: left) {
                return false
            }
        }
        
        if let right = root.right {
            if !isFollowUpTraversal(for: right) {
                return false
            }
        }
        
        temp.append(root.value)
        count += 1
        
        if sequence.count < count {
            return false
        }
        
        if root.value != sequence[count - 1] {
            return false
        } else {
            return true
        }
    }
    
    guard isFollowUpTraversal(for: root) else {
        return false
    }
    
    if count != sequence.count {
        return false
    }
    
    return true
}

/// 寻找二叉树上任意两个结点的最近共同父节点
/// - Parameters:
///   - root: 根结点
///   - first: 第一个结点
///   - second: 第二个结点
/// - Returns: 公共父节点
func findCommonParentForBinaryTree<T: Comparable>(for root: BinaryTreeNode<T>, first: BinaryTreeNode<T>, second: BinaryTreeNode<T>) -> BinaryTreeNode<T>? {

    func findTrace(for root: BinaryTreeNode<T>, node: BinaryTreeNode<T>) -> [BinaryTreeNode<T>] {
        if root === node {
            return [node]
        }
        
        if let left = root.left {
            let trace = findTrace(for: left, node: node)
            if !trace.isEmpty {
                return [root] + trace
            }
        }
        
        if let right = root.right {
            let trace = findTrace(for: right, node: node)
            if !trace.isEmpty {
                return [root] + trace
            }
        }
        
        return []
    }
    
    let parentsF = findTrace(for: root, node: first)
    let parentsS = findTrace(for: root, node: second)
    
    if parentsF.isEmpty || parentsS.isEmpty || parentsF[0] !== parentsS[0] {
        return nil
    }
    
    let countF = parentsF.count
    let countS = parentsS.count
    
    var current = 0
    while current < min(countF, countS) {
        if parentsS[current] !== parentsF[current] {
            return parentsS[current - 1]
        }
        current += 1
    }
    return parentsS[current - 1]
}

/// 求二叉树中两个结点之间的距离
/// - Parameters:
///   - root: 根结点
///   - first: 第一个结点
///   - second: 第二个结点
/// - Returns: 距离
func distanceBetweenWithNodes<T>(for root: BinaryTreeNode<T>, first: BinaryTreeNode<T>, second: BinaryTreeNode<T>) -> Int? {
    func findTrace(for root: BinaryTreeNode<T>, node: BinaryTreeNode<T>) -> [BinaryTreeNode<T>] {
        if root === node {
            return [node]
        }
        
        if let left = root.left {
            let trace = findTrace(for: left, node: node)
            if !trace.isEmpty {
                return [root] + trace
            }
        }
        
        if let right = root.right {
            let trace = findTrace(for: right, node: node)
            if !trace.isEmpty {
                return [root] + trace
            }
        }
        
        return []
    }
    
    let parentsF = findTrace(for: root, node: first)
    let parentsS = findTrace(for: root, node: second)
    
    if parentsF.isEmpty || parentsS.isEmpty || parentsF[0] !== parentsS[0] {
        return nil
    }
    
    let countF = parentsF.count
    let countS = parentsS.count
    
    var current = 0
    while current < min(countF, countS) {
        if parentsS[current] !== parentsF[current] {
            break
        }
        current += 1
    }
    
    current -= 1
    let leftDistance = countF - 1 - current
    let rightDistance = countS - 1 - current
    
    return leftDistance + rightDistance
}
