//
//  ListSolutionUnitTest.swift
//  AlgorithmUnitTest
//
//  Created by 刘洋 on 2021/7/12.
//

import XCTest

@testable
import Algorithm

class AlgorithmUnitTest: XCTestCase {
    
    var emptyList = ListNode<Int>.makeList(for: [])
    var oneElementList = ListNode.makeList(for: [1])
    var twoElementList = ListNode.makeList(for: [1, 2])
    var thereElementList = ListNode.makeList(for: [1, 2, 3])
    var manyElementListV1 = ListNode.makeList(for: Array(1 ... 10))
    var manyElementListV2 = ListNode.makeList(for: Array(1 ... 11))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReverseList() throws {
        var result = reverse(for: emptyList)?.description
        XCTAssert(result == nil)
        
        result = reverse(for: oneElementList)?.description
        XCTAssert(result! == "1")
        
        result = reverse(for: twoElementList)?.description
        XCTAssert(result! == "2,1")
        
        result = reverse(for: thereElementList)?.description
        XCTAssert(result! == "3,2,1")
        
        result = reverse(for: manyElementListV1)?.description
        XCTAssert(result! == "10,9,8,7,6,5,4,3,2,1")
    }
    
    func testReverseListPrint() throws {
        var result = reversePrint(for: emptyList)
        XCTAssert(result == "")
        
        result = reversePrint(for: oneElementList)
        XCTAssert(result == "1")
        
        result = reversePrint(for: twoElementList)
        XCTAssert(result == "2,1")
        
        result = reversePrint(for: thereElementList)
        XCTAssert(result == "3,2,1", result)
        
        result = reversePrint(for: manyElementListV1)
        XCTAssert(result == "10,9,8,7,6,5,4,3,2,1")
    }
    
    func testremoveRepeateForList() throws {
        removeRepeate(for: emptyList)
        var result = emptyList?.description
        XCTAssert(result == nil)
        
        removeRepeate(for: oneElementList)
        result = oneElementList?.description
        XCTAssert(result! == "1")
        
        removeRepeate(for: twoElementList)
        result = twoElementList?.description
        XCTAssert(result! == "1,2")
        
        let customList = ListNode.makeList(for: [1,3,1,5,5,7])
        removeRepeate(for: customList)
        result = customList?.description
        XCTAssert(result! == "1,3,5,7", result!)
    }
    
    func testremoveRepeateForSortList() throws {
        removeRepeate(in: emptyList)
        var result = emptyList?.description
        XCTAssert(result == nil)
        
        removeRepeate(in: oneElementList)
        result = oneElementList?.description
        XCTAssert(result! == "1")
        
        removeRepeate(in: twoElementList)
        result = twoElementList?.description
        XCTAssert(result! == "1,2")
        
        let customList = ListNode.makeList(for: [1,1,3,3,5,7])
        removeRepeate(in: customList)
        result = customList?.description
        XCTAssert(result! == "1,3,5,7", result!)
    }
    
    func testSumIntergateList() throws {
        var sum = sumIntergateList(first: oneElementList!, second: twoElementList!).description
        XCTAssert(sum == "2,2", sum)
        
        sum = sumIntergateList(first: twoElementList!, second: thereElementList!).description
        XCTAssert(sum == "2,4,3", sum)
        
        let customList = ListNode.makeList(for: [9,9,9])
        sum = sumIntergateList(first: customList!, second: oneElementList!).description
        XCTAssert(sum == "0,0,0,1", sum)
        
        sum = sumIntergateList(first: customList!, second: thereElementList!).description
        XCTAssert(sum == "0,2,3,1", sum)
        
    }
    
    func testRearrangeForList() throws {
        rearrange(for: emptyList)
        var result = emptyList?.description
        XCTAssert(result == nil)
        
        rearrange(for: oneElementList)
        result = oneElementList?.description
        XCTAssert(result! == "1")
        
        rearrange(for: twoElementList)
        result = twoElementList?.description
        XCTAssert(result! == "1,2")
        
        rearrange(for: thereElementList)
        result = thereElementList?.description
        XCTAssert(result! == "1,3,2")
        
        rearrange(for: manyElementListV1)
        result = manyElementListV1?.description
        XCTAssert(result! == "1,10,2,9,3,8,4,7,5,6")
        
        rearrange(for: manyElementListV2)
        result = manyElementListV2?.description
        XCTAssert(result! == "1,11,2,10,3,9,4,8,5,7,6")
    }
    
    func testMiddleForList() throws {
        var result = middle(for: emptyList)?.value
        XCTAssert(result == nil)
        
        result = middle(for: oneElementList)?.value
        XCTAssert(result == 1)
        
        result = middle(for: twoElementList)?.value
        XCTAssert(result == 1)
        
        result = middle(for: thereElementList)?.value
        XCTAssert(result == 2)
        
        result = middle(for: manyElementListV1)?.value
        XCTAssert(result == 5)
        
        result = middle(for: manyElementListV2)?.value
        XCTAssert(result == 6)
    }
    
    func testLastForList() throws {
        var result = last(for: emptyList, rank: 2)
        XCTAssert(result == nil)
        
        result = last(for: oneElementList, rank: 2)
        XCTAssert(result == nil)
        
        result = last(for: oneElementList, rank: 1)
        XCTAssert(result == 1)
        
        result = last(for: twoElementList, rank: 2)
        XCTAssert(result == 1)
        
        result = last(for: thereElementList, rank: 1)
        XCTAssert(result == 3)
        
        result = last(for: thereElementList, rank: 11)
        XCTAssert(result == nil)
    }
    
    func testRotateRightForList() throws {
        var result = rotateRight(for: emptyList, rank: 2)?.description
        XCTAssert(result == nil)
        
        result = rotateRight(for: oneElementList, rank: 2)?.description
        XCTAssert(result! == "1")
        
        var custom = ListNode.makeList(for: [1])
        result = rotateRight(for: custom, rank: 1)?.description
        XCTAssert(result! == "1")
        
        result = rotateRight(for: twoElementList, rank: 1)?.description
        XCTAssert(result! == "2,1", result!)
        
        custom = ListNode.makeList(for: [1, 2])
        result = rotateRight(for: custom, rank: 2)?.description
        XCTAssert(result! == "1,2", result!)
        
        result = rotateRight(for: thereElementList, rank: 1)?.description
        XCTAssert(result! == "3,1,2")
        
        custom = ListNode.makeList(for: [1, 2, 3])
        result = rotateRight(for: custom, rank: 2)?.description
        XCTAssert(result! == "2,3,1")
        
        custom = ListNode.makeList(for: [1, 2, 3])
        result = rotateRight(for: custom, rank: 3)?.description
        XCTAssert(result! == "1,2,3")
    }
    
    func testIsRingForList() throws {
        var result: Bool = isRing(for: emptyList)
        XCTAssert(!result)
        
        result = isRing(for: oneElementList)
        XCTAssert(!result)
        
        result = isRing(for: twoElementList)
        XCTAssert(!result)
        
        result = isRing(for: thereElementList)
        XCTAssert(!result)
                
        var custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        var trailNode = trail(for: custom)
        trailNode?.next = custom?.next
        result = isRing(for: custom)
        XCTAssert(result)
        
        custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        trailNode = trail(for: custom)
        trailNode?.next = custom?.next?.next
        result = isRing(for: custom)
        XCTAssert(result)
        
        custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        trailNode = trail(for: custom)
        trailNode?.next = trailNode
        result = isRing(for: custom)
        XCTAssert(result)
    }
    
    func testIsRingLocationForList() throws {
        var result: Int? = isRing(for: emptyList)?.value
        XCTAssert(result == nil)
        
        result = isRing(for: oneElementList)?.value
        XCTAssert(result == nil)
        
        result = isRing(for: twoElementList)?.value
        XCTAssert(result == nil)
        
        result = isRing(for: thereElementList)?.value
        XCTAssert(result == nil)
        
        
        var custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        var trailNode = trail(for: custom)
        trailNode?.next = custom
        result = isRing(for: custom)?.value
        XCTAssert(result == 1)
        
        custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        trailNode = trail(for: custom)
        trailNode?.next = custom?.next?.next
        result = isRing(for: custom)?.value
        XCTAssert(result == 3)
        
        custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        trailNode = trail(for: custom)
        trailNode?.next = trailNode
        result = isRing(for: custom)?.value
        XCTAssert(result == 8)
        
        custom = ListNode.makeList(for: [1,2,3,4,5,6,7,8])
        trailNode = trail(for: custom)
        trailNode?.next = custom?.next?.next?.next?.next?.next
        result = isRing(for: custom)?.value
        XCTAssert(result == 6)
    }
    
    func testFlipAdjacentElementForList() throws {
        var result = flipAdjacentElement(for: emptyList)?.description
        XCTAssert(result == nil)
        
        result = flipAdjacentElement(for: oneElementList)?.description
        XCTAssert(result! == "1")
        
        result = flipAdjacentElement(for: twoElementList)?.description
        XCTAssert(result! == "2,1")
        
        result = flipAdjacentElement(for: thereElementList)?.description
        XCTAssert(result! == "2,1,3")
        
        result = flipAdjacentElement(for: manyElementListV1)?.description
        XCTAssert(result! == "2,1,4,3,6,5,8,7,10,9")
        
        result = flipAdjacentElement(for: manyElementListV2)?.description
        XCTAssert(result! == "2,1,4,3,6,5,8,7,10,9,11")
    }
    
    func testFlipAdjacentElementForListWithK() throws {
        var result = flipAdjacentElement(for: emptyList, groupCapcity: 0)?.description
        XCTAssert(result == nil)
        
        var customList = ListNode<Int>.makeList(for: [])
        result = flipAdjacentElement(for: customList, groupCapcity: 1)?.description
        XCTAssert(result == nil)
        
        result = flipAdjacentElement(for: oneElementList, groupCapcity: 1)?.description
        XCTAssert(result! == "1")
        
        customList = ListNode.makeList(for: [1])
        result = flipAdjacentElement(for: customList, groupCapcity: 2)?.description
        XCTAssert(result! == "1")
        
        result = flipAdjacentElement(for: twoElementList, groupCapcity: 1)?.description
        XCTAssert(result! == "1,2")
        
        customList = ListNode.makeList(for: [1, 2])
        result = flipAdjacentElement(for: customList, groupCapcity: 2)?.description
        XCTAssert(result! == "2,1")
        
        customList = ListNode.makeList(for: [1, 2])
        result = flipAdjacentElement(for: customList, groupCapcity: 3)?.description
        XCTAssert(result! == "1,2")
        
        result = flipAdjacentElement(for: thereElementList, groupCapcity: 1)?.description
        XCTAssert(result! == "1,2,3")
        
        customList = ListNode.makeList(for: [1, 2, 3])
        result = flipAdjacentElement(for: customList, groupCapcity: 2)?.description
        XCTAssert(result! == "2,1,3")
        
        customList = ListNode.makeList(for: [1, 2, 3])
        result = flipAdjacentElement(for: customList, groupCapcity: 3)?.description
        XCTAssert(result! == "3,2,1")
        
        customList = ListNode.makeList(for: [1, 2, 3])
        result = flipAdjacentElement(for: customList, groupCapcity: 4)?.description
        XCTAssert(result! == "1,2,3")
        
        result = flipAdjacentElement(for: manyElementListV1, groupCapcity: 5)?.description
        XCTAssert(result! == "5,4,3,2,1,10,9,8,7,6")
        
        result = flipAdjacentElement(for: manyElementListV2, groupCapcity: 4)?.description
        XCTAssert(result! == "4,3,2,1,8,7,6,5,9,10,11")
    }
    
    func trail<T>(for list: ListNode<T>?) -> ListNode<T>? {
        var current = list
        if current == nil {
            return nil
        }
        while current?.next != nil {
            current = current?.next
        }
        
        return current
    }
}
