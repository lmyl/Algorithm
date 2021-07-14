//
//  StackQueueHashUnitTest.swift
//  AlgorithmUnitTest
//
//  Created by 刘洋 on 2021/7/14.
//

import XCTest
@testable
import Algorithm

class StackQueueHashUnitTest: XCTestCase {
    let defaultStack: Stack<Int> = {
        let stack = Stack<Int>()
        let source = 1 ... 5
        for element in source {
            stack.push(element: element)
        }
        return stack
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReverseStack() throws {
        reverse(statck: defaultStack)
        var result: [Int] = []
        while !defaultStack.isEmpty {
            result.append(defaultStack.pop()!)
        }
        XCTAssert(Array(1 ... 5) == result)
    }

    func testSortStack() throws {
        sort(stack: defaultStack)
        var result: [Int] = []
        while !defaultStack.isEmpty {
            result.append(defaultStack.pop()!)
        }
        XCTAssert(Array(1 ... 5) == result)
        
        let stack = Stack<Int>()
        let source = [1,6,5,4,3,2]
        for element in source {
            stack.push(element: element)
        }
        sort(stack: stack)
        result = []
        while !stack.isEmpty {
            result.append(stack.pop()!)
        }
        XCTAssert(Array(1 ... 6) == result)
    }
}


