//
//  ArraySolutionUnitTest.swift
//  AlgorithmUnitTest
//
//  Created by 刘洋 on 2021/7/21.
//

import XCTest
@testable
import Algorithm

class ArraySolutionUnitTest: XCTestCase  {
    func testFindOnlyRepeatOneElementFrom1_1000() throws {
        var source = Array(1 ... 1000)
        let repeatElement = Int.random(in: 1 ... 1000)
        source.append(repeatElement)
        source.shuffle()
        
        let find = findOnlyRepeatOneElementFrom1_1000(input: source)
        XCTAssert(find == repeatElement)
    }
    
    func testFindRepeatElementFrom() throws {
        var source = Array(1 ... 1000)
        var repeatElement: [Int] = []
        
        let start = Int.random(in: 1 ... 990)
        repeatElement.append(contentsOf: start ..< start + 10)
        
        source.append(contentsOf: repeatElement)
        source.shuffle()
        
        let find = findRepeatElementFrom(max: 1000, source: source)
        XCTAssert(find.sorted() == repeatElement)
    }
    
    func testFindMinAndMax() throws {
        let source = Array(1 ... 1000).shuffled()
        XCTAssert(findMinAndMax(from: source) == (1000, 1))
        
        XCTAssert(findMinAndMax(from: [1]) == (1, 1))
    }
    
    func testMakeSpinSortArray() throws {
        let source = Array(1 ... 9)
        
        for location in 0 ... 9 {
            let spinLocation = location
            let left = Array(source.prefix(spinLocation))
            let right = Array(source.suffix(source.count - spinLocation))
            let result = right + left
            let final = makeSpinSortArray(for: source, spin: spinLocation)
            XCTAssert(final == result, "\(result) \(final)")
        }
    }
    
    func testFindLossElement() throws {
        var source = Array(1 ... 1000)
        let lossElementIndex = Int.random(in: 0 ... 999)
        let lossElement = source[lossElementIndex]
        source.remove(at: lossElementIndex)
        
        XCTAssert(findLossElement(for: source) == lossElement)
    }
    
    func testFindOddTimesOfNumber() throws {
        var source = Array(1 ... 1000)
        source = source + source
        let one = Int.random(in: 1 ... 500)
        let two = Int.random(in: 501 ... 1000)
        source.append(contentsOf: [one, two])
        source.shuffle()
        XCTAssert(findOddTimesOfNumber(from: source) == (one, two))
    }
    
    func testFindKSmallNumber() throws {
        let source = Array(1 ... 1000)
        var rank = 1
        var small = source[rank - 1]
        var final = source.shuffled()
        var result = findKSmallNumber(from: final, rank: rank)
        XCTAssert(result == small)
        
        rank = 1000
        small = source[rank - 1]
        final = source.shuffled()
        result = findKSmallNumber(from: final, rank: rank)
        XCTAssert(result == small)
        
        rank = Int.random(in: 1 ... 1000)
        small = source[rank - 1]
        final = source.shuffled()
        result = findKSmallNumber(from: final, rank: rank)
        XCTAssert(result == small)
    }
    
    func testFindMinimumCommonMultiple() throws {
        var source = [1]
        XCTAssert(findMinimumCommonMultiple(for: source) == 1)
        
        source = [1, 2]
        XCTAssert(findMinimumCommonMultiple(for: source) == 2)
        
        source = [1, 2, 3]
        XCTAssert(findMinimumCommonMultiple(for: source) == 6)
        
        source = [1, 2, 3, 4]
        XCTAssert(findMinimumCommonMultiple(for: source) == 12)
        
        source = [1, 2, 3, 4, 5]
        XCTAssert(findMinimumCommonMultiple(for: source) == 60)
        
        source = [7, 8, 9, 11, 14]
        XCTAssert(findMinimumCommonMultiple(for: source) == 5544)
    }
    
    func testFind3rdMaxNumber() throws {
        var source = [1]
        XCTAssert(find3rdMaxNumber(from: source) == source)
        
        source = [1, 2, 3]
        XCTAssert(find3rdMaxNumber(from: source) == source)
        
        source = [7, 8, 9, 11, 14]
        XCTAssert(find3rdMaxNumber(from: source) == Array(source.sorted().suffix(3)))
    }
    
    func testFindSmallestDistance() throws {
        var source = [4,5,6,4,7,4,6,4,7,8,5,6,4,3,10,8]
        XCTAssert(findSmallestDistance(from: source, left: 4, right: 8) == 2)
        
        source = [4,5,6,4,7,4,6,4,8,5,6,4,3,10,8]
        XCTAssert(findSmallestDistance(from: source, left: 4, right: 8) == 1)
        
        source = [4,5,6,8,4,7,4,6,4,5,6,4,3,10,8]
        XCTAssert(findSmallestDistance(from: source, left: 4, right: 8) == 1)
    }
    
    func testFindSmallestTriadDistance() throws {
        let one = [3,4,5,7,15]
        let two = [10, 12, 14, 16, 17]
        let three = [20, 21, 23, 24, 37, 30]
        
        let find = findSmallestTriadDistance(for: one, two: two, three: three)
        XCTAssert(find == 5)
    }
    
    func testFindMinAbs() throws {
        var source = [-10,-5,-2,7,15,50]
        XCTAssert(findMinAbs(from: source) == 2)
        
        source = [-10,-5,7,15,50]
        XCTAssert(findMinAbs(from: source) == 5)
        
        source = [-10,7,15,50]
        XCTAssert(findMinAbs(from: source) == 7)
        
        source = [7,15,50]
        XCTAssert(findMinAbs(from: source) == 7)
        
        source = [-27,-15,-5]
        XCTAssert(findMinAbs(from: source) == 5)
    }
    
    func testFindMaxContinueSum() throws {
        var source = [1,-2,4,8,-4,7,-1,-5]
        var result = findMaxContinueSum(for: source)
        XCTAssert(result! == (15, 2, 5))
        
        source = [1,-2,-4,-8,-4,7,-1,-5]
        result = findMaxContinueSum(for: source)
        XCTAssert(result! == (7, 5, 5))
        
        source = [-10,-2,-4,-8,-4,-7,-1,-5]
        result = findMaxContinueSum(for: source)
        XCTAssert(result! == (-1, 6, 6))
    }
    
    func testFindOnceAppeare() throws {
        var source = [1,2,4,5,6,4,2]
        var result = findOnceAppeare(for: source)
        XCTAssertTrue([1,5,6].contains(result))
        
        source = [1,2,3,4,4,5,5,8,8,0,0]
        result = findOnceAppeare(for: source)
        XCTAssertTrue([1,2,3].contains(result))
    }
    
    func testFindMiddleNumber() throws {
        var source = [7,5,3,1,11,9]
        var result = findMiddleNumber(for: source)
        XCTAssert(result == 6)
        
        source = [7,5,3,1,11,9,6]
        result = findMiddleNumber(for: source)
        XCTAssert(result == 6)
    }
    
    func testFindNonEmptySubSet() throws {
        var source = [1]
        XCTAssert(findNonEmptySubSet(for: source) == [[1]])
        
        source = [1, 2]
        XCTAssert(findNonEmptySubSet(for: source) == [[1], [1,2], [2]])
        
        source = [1, 2, 3]
        XCTAssert(findNonEmptySubSet(for: source) == [[1], [1,2], [2], [1,3], [1,2,3], [2,3], [3]])
    }
    
    func testCyclicRightShift() throws {
        let source = [1, 2, 3]
        XCTAssert(cyclicRightShift(for: source, location: 0) == [1,2,3])
        XCTAssert(cyclicRightShift(for: source, location: 1) == [2,3,1])
        XCTAssert(cyclicRightShift(for: source, location: 2) == [3,1,2])
        XCTAssert(cyclicRightShift(for: source, location: 3) == [1,2,3])
        XCTAssert(cyclicRightShift(for: source, location: 4) == [2,3,1])
        XCTAssert(cyclicRightShift(for: source, location: 5) == [3,1,2])
    }
    
    func testSearchInTwoDimensionalArray() throws {
        let source = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        let set = Set(source.flatMap({$0}))
        for value in set {
            XCTAssertTrue(searchInTwoDimensionalArray(for: source, element: value))
        }
        
        for value in [-10,3,5,14,16] {
            XCTAssertFalse(searchInTwoDimensionalArray(for: source, element: value))
        }
    }
    
    func testCoverageTheMostPoint() throws {
        let source = [1,3,7,8,10,11,12,13,15,16,17,19,25]
        XCTAssert(coverageTheMostPoint(for: source, stick: 8) == (7, [7,8,10,11,12,13,15]))
        XCTAssert(coverageTheMostPoint(for: source, stick: 7) == (7, [10,11,12,13,15,16,17]))
        XCTAssert(coverageTheMostPoint(for: source, stick: 3) == (4, [10,11,12,13]))
        XCTAssert(coverageTheMostPoint(for: source, stick: 2) == (3, [10,11,12]))
        XCTAssert(coverageTheMostPoint(for: source, stick: 1) == (2, [7,8]))
    }
}
