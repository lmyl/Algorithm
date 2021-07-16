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
}

