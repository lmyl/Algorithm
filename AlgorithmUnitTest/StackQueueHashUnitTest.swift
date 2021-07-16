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
    
    func testIsSatisfiedForStack() throws {
        XCTAssertTrue(isSatisfiedForStack(inputs: [1,2,3,4,5], outputs: [3,2,5,4,1]))
        XCTAssertFalse(isSatisfiedForStack(inputs: [1,2,3,4,5], outputs: [5,3,4,1,2]))
    }
    
    func testMinStack() throws {
        var stack = MinStack<Int>()
        var source = [1,6,5,4,3,2]
        var minSource = [1,1,1,1,1,1]
        for element in source {
            stack.push(element: element)
        }
        
        for min in minSource.reversed() {
            XCTAssert(stack.min! == min)
            _ = stack.pop()
        }
        
        stack = MinStack<Int>()
        source = [1,2,3,0,7,0,-1]
        minSource = [1,1,1,0,0,0,-1]
        
        for element in source {
            stack.push(element: element)
        }
        
        for min in minSource.reversed() {
            XCTAssert(stack.min! == min)
            _ = stack.pop()
        }
    }
    
    func testQueueStack() throws {
        let queue = QueueStack<Int>()
        XCTAssert(queue.heade == nil)
        
        queue.push(element: 1)
        XCTAssert(queue.heade == 1)
        XCTAssert(queue.trail == 1)
        
        queue.push(element: 2)
        XCTAssert(queue.heade == 1)
        XCTAssert(queue.trail == 2)
        
        XCTAssert(queue.pop() == 1)
        XCTAssert(queue.heade == 2)
        XCTAssert(queue.trail == 2)
        
        XCTAssert(queue.pop() == 2)
        XCTAssert(queue.heade == nil)
        XCTAssert(queue.trail == nil)
    }
    
    func testQueuingSystem() throws {
        var users: [User] = []
        let queuingSystem = QueuingSystem()
        
        for uuid in 1 ... 6 {
            let user = User(uuid: uuid, name: "\(uuid)")
            users.append(user)
            queuingSystem.enQueue(user: user)
        }
        
        for (index, user) in users.enumerated() {
            XCTAssert(user.location == index + 1)
        }
        
        _ = queuingSystem.deQueue()
        for index in 1 ..< users.count {
            XCTAssert(users[index].location == index)
        }
        
        queuingSystem.leaveQueue(user: users[3])
        XCTAssert(users[1].location == 1)
        XCTAssert(users[2].location == 2)
        XCTAssert(users[4].location == 3)
        XCTAssert(users[5].location == 4)
        
        queuingSystem.leaveQueue(user: users[5])
        XCTAssert(users[1].location == 1)
        XCTAssert(users[2].location == 2)
        XCTAssert(users[4].location == 3)
    }
    
    func testLRUCache() throws {
        let lruCache = LRUCache<Page>(maxSize: 3)
        XCTAssert(lruCache.fetch(id: 1) == nil)
        
        let one = Page(uuid: 1)
        lruCache.push(content: one)
        XCTAssert(lruCache.fetch(id: 1) === one)
        
        let two = Page(uuid: 2)
        lruCache.push(content: two)
        XCTAssert(lruCache.fetch(id: 2) === two)
        
        let three = Page(uuid: 3)
        lruCache.push(content: three)
        XCTAssert(lruCache.fetch(id: 3) === three)
        
        XCTAssert(lruCache.fetch(id: 1) === one)
        
        let four = Page(uuid: 4)
        lruCache.push(content: four)
        XCTAssert(lruCache.fetch(id: 4) === four)
        XCTAssert(lruCache.fetch(id: 2) == nil)
    }
    
    func testGenerateRouteLine() throws {
        var route = ["A": "B", "C": "D", "D": "A", "B": "E"]
        XCTAssert(generateRouteLine(for: route) == ["C", "D", "A", "B", "E"])
        
        route = ["C": "D", "D": "A"]
        XCTAssert(generateRouteLine(for: route) == ["C", "D", "A"])
    }
    
    func testFourSum() throws {
        var source = [1,1,1,1]
        var result = fourSum(for: source)
        XCTAssert(result != nil && result!.0.0 + result!.0.1 == result!.1.0 + result!.1.1)
        
        source = [3,4,7,10,20,9,8]
        result = fourSum(for: source)
        XCTAssert(result != nil && result!.0.0 + result!.0.1 == result!.1.0 + result!.1.1)
        
        source = [1,10,12,33,99,200]
        result = fourSum(for: source)
        XCTAssert(result == nil)
    }
}


