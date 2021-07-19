//
//  BinaryTreeUnitTest.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/16.
//

import XCTest
@testable
import Algorithm

class BinaryTreeUnitTest: XCTestCase {
    func testBinaryTreeDescription() throws {
        let root = BinaryTreeNode(value: 1)
        root.left = BinaryTreeNode(value: 2)
        root.right = BinaryTreeNode(value: 3)
        root.left?.left = BinaryTreeNode(value: 4)
        root.left?.right = BinaryTreeNode(value: 5)
        root.right?.left = BinaryTreeNode(value: 6)
        root.right?.right = BinaryTreeNode(value: 7)
        
        XCTAssert(root.description == "1\n2,3\n4,5,6,7")
    }
    
    func testGenerateBinaryTree() throws {
        let source = [1,2,3,4,5,6,7,8]
        let root = generateBinaryTree(from: source)
        
        XCTAssert(root!.description == "5\n3,7\n2,4,6,8\n1", root!.description)
    }
    
    func testLevelTraversalByRecursion() throws {
        let root = BinaryTreeNode(value: 1)
        root.left = BinaryTreeNode(value: 2)
        root.right = BinaryTreeNode(value: 3)
        root.left?.left = BinaryTreeNode(value: 4)
        root.left?.right = BinaryTreeNode(value: 5)
        root.right?.left = BinaryTreeNode(value: 6)
        root.right?.right = BinaryTreeNode(value: 7)
        
        XCTAssert(levelTraversalByRecursion(for: root) == "1\n2,3\n4,5,6,7")
    }
    
    func testMaximumSubTreeSum() throws {
        let root = BinaryTreeNode(value: 6)
        root.left = BinaryTreeNode(value: 3)
        root.right = BinaryTreeNode(value: -7)
        root.left?.left = BinaryTreeNode(value: -1)
        root.left?.right = BinaryTreeNode(value: 9)
        
        let maxAndNode = maximumSubTreeSum(for: root)
        XCTAssert(maxAndNode.max == 11)
        XCTAssert(maxAndNode.node === root.left)
    }
    
    func testEqualBinaryTree() throws {
        let root = BinaryTreeNode(value: 6)
        root.left = BinaryTreeNode(value: 3)
        root.right = BinaryTreeNode(value: -7)
        root.left?.left = BinaryTreeNode(value: -1)
        root.left?.right = BinaryTreeNode(value: 9)
        
        let rootTwo = BinaryTreeNode(value: 6)
        rootTwo.left = BinaryTreeNode(value: 3)
        rootTwo.right = BinaryTreeNode(value: -7)
        rootTwo.left?.left = BinaryTreeNode(value: -1)
        rootTwo.left?.right = BinaryTreeNode(value: 9)
        
        XCTAssert(equalBinaryTree(for: root, second: rootTwo) == true)
        
        let rootThree = BinaryTreeNode(value: 6)
        rootTwo.left = BinaryTreeNode(value: 3)
        rootTwo.right = BinaryTreeNode(value: -7)
        rootTwo.left?.left = BinaryTreeNode(value: -1)
        
        XCTAssert(equalBinaryTree(for: root, second: rootThree) == false)
        
        let rootFour = BinaryTreeNode(value: 6)
        rootFour.left = BinaryTreeNode(value: 3)
        rootFour.right = BinaryTreeNode(value: -7)
        rootFour.left?.left = BinaryTreeNode(value: -1)
        rootFour.left?.right = BinaryTreeNode(value: 10)
        
        XCTAssert(equalBinaryTree(for: rootTwo, second: rootFour) == false)
    }
    
    func testConvertSearchBinaryTreeToDoubleDirectList() throws {
        let root = BinaryTreeNode(value: 4)
        root.left = BinaryTreeNode(value: 2)
        root.right = BinaryTreeNode(value: 6)
        root.left?.left = BinaryTreeNode(value: 1)
        root.left?.right = BinaryTreeNode(value: 3)
        root.right?.left = BinaryTreeNode(value: 5)
        root.right?.right = BinaryTreeNode(value: 7)
        
        var list = convertSearchBinaryTreeToDoubleDirectList(for: root)
        var current: BinaryTreeNode<Int>? = list
        var result: [Int] = []
        while let node = current {
            result.append(node.value)
            current = node.left
        }
        XCTAssert(result == [1,2,3,4,5,6,7])
        
        let source = [1,2,3,4,5,6,7]
        let rootTwo = generateBinaryTree(from: source)
        list = convertSearchBinaryTreeToDoubleDirectList(for: rootTwo!)
        current = list
        result = []
        while let node = current {
            result.append(node.value)
            current = node.left
        }
        XCTAssert(result == source)
    }
    
    func testIsFollowUpTraversal() throws {
        let root = BinaryTreeNode(value: 4)
        root.left = BinaryTreeNode(value: 2)
        root.right = BinaryTreeNode(value: 6)
        root.left?.left = BinaryTreeNode(value: 1)
        root.left?.right = BinaryTreeNode(value: 3)
        root.right?.left = BinaryTreeNode(value: 5)
        root.right?.right = BinaryTreeNode(value: 7)
        
        XCTAssertTrue(isFollowUpTraversal(for: root, sequence: [1,3,2,5,7,6,4]))
        XCTAssertFalse(isFollowUpTraversal(for: root, sequence: [1,3,2,5,7,6]))
        XCTAssertFalse(isFollowUpTraversal(for: root, sequence: [1,3,2,5,7,6,4,8]))
        XCTAssertFalse(isFollowUpTraversal(for: root, sequence: [1,3,2,5,3,6,4]))
    }
    
    func testFindCommonParentForBinaryTree() throws {
        let root = generateBinaryTree(from: [1,2,3,4,5,6,7,8,9,10])!
        XCTAssert(findCommonParentForBinaryTree(for: root, first: root.left!.left!.left!, second: root.left!.right!) === root.left!)
        
        XCTAssert(findCommonParentForBinaryTree(for: root, first: root.left!.left!.left!, second: root.left!.right!.left!) === root.left!)
        
        XCTAssert(findCommonParentForBinaryTree(for: root, first: root.left!.left!.left!, second: root.left!) === root.left!)
    }
    
    func testDistanceBetweenWithNodes() throws {
        let root = generateBinaryTree(from: [1,2,3,4,5,6,7,8,9,10])!
        XCTAssert(distanceBetweenWithNodes(for: root, first: root.left!.left!.left!, second: root.left!.right!) == 3)
        
        XCTAssert(distanceBetweenWithNodes(for: root, first: root.left!.left!.left!, second: root.left!) == 2)
    }
}

