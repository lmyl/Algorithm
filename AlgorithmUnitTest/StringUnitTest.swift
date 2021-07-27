//
//  StringUnitTest.swift
//  AlgorithmUnitTest
//
//  Created by 刘洋 on 2021/7/27.
//
import XCTest
@testable
import Algorithm

class StringUnitTest: XCTestCase {
    func testAllPermutations() throws {
        let string = "abc"
        let results = ["abc", "acb", "bac", "bca", "cba", "cab"]
        let tesetResults = allPermutations(for: string)
        XCTAssert(tesetResults.count == results.count)
        for result in tesetResults {
            XCTAssertTrue(results.contains(result))
        }
    }
    
    func testAllPermutationsWithoutRepeat() throws {
        let string = "aba"
        let results = ["aba", "aab", "baa"]
        let tesetResults = allPermutationsWithoutRepeat(for: string)
        XCTAssert(tesetResults.count == results.count)
        for result in tesetResults {
            XCTAssertTrue(results.contains(result))
        }
    }
    
    
}
