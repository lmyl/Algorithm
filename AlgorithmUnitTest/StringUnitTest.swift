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
    
    func testFindMaxLengthCommonSubString() throws {
        let first = "abccade"
        let second = "dgcadde"
        let result = findMaxLengthCommonSubString(for: first, and: second)
        XCTAssert(result == "cad", result)
    }
    
    func testCompactString() throws {
        var string = "eeeeeaaaff"
        var result = compact(for: string)
        XCTAssert(result == "e5a3f2", result)
        
        string = "eeeeeaaasf"
        result = compact(for: string)
        XCTAssert(result == "e5a3sf", result)
        
        string = "eeeeebbbbbbbbbbbbaaasf"
        result = compact(for: string)
        XCTAssert(result == "e5b12a3sf", result)
    }
    
    func testReverseString() throws {
        let source = "abcdefg"
        XCTAssert(reverse(for: source) == "gfedcba")
    }
    
    func testReverseWords() throws {
        var source = "how are you"
        XCTAssert(reverseWords(for: source) == "you are how")
        
        source = "how are you "
        XCTAssert(reverseWords(for: source) == " you are how")
        
        source = " how are you "
        XCTAssert(reverseWords(for: source) == " you are how ")
        
        source = "    "
        XCTAssert(reverseWords(for: source) == "    ")
        
        source = " how   are   you "
        XCTAssert(reverseWords(for: source) == " you   are   how ")
    }
    
    func testIsTransparentString() throws {
        var first = "aaaabbc"
        var second = "abcbaaa"
        XCTAssertTrue(isTransparentString(for: first, and: second))
        
        first = "aaa abbc"
        second = "abcbaa a"
        XCTAssertTrue(isTransparentString(for: first, and: second))
        
        first = "aaa abbc"
        second = " abcbaa "
        XCTAssertFalse(isTransparentString(for: first, and: second))
        
        first = " "
        second = "   "
        XCTAssertFalse(isTransparentString(for: first, and: second))
        
        first = " "
        second = " "
        XCTAssertTrue(isTransparentString(for: first, and: second))
        
        first = ""
        second = ""
        XCTAssertTrue(isTransparentString(for: first, and: second))
    }
    
    func testContainsString() throws {
        var first = "abcdef"
        var second = "acf"
        XCTAssertTrue(contains(string: second, in: first))
        
        first = "abcdef"
        second = "acg"
        XCTAssertFalse(contains(string: second, in: first))
        
        first = "abcdef"
        second = ""
        XCTAssertTrue(contains(string: second, in: first))
    }
    
    func testRearrangeString() throws {
        let source = "AbcDef"
        let results = Array(rearrange(string: source))
        XCTAssert(results[4 ... 5] == ["A", "D"] || results[4 ... 5] == ["D", "A"])
    }
    
    func testClearInclusiveString() throws {
        var source = "(1,(2,3),(4,(5,6),7))"
        XCTAssert(clearInclusive(for: source) == "(1,2,3,4,5,6,7)")
        
        source = "(11,(2,3),(46,(5,66),7))"
        XCTAssert(clearInclusive(for: source) == "(11,2,3,46,5,66,7)")
        
        source = "(11,((2,3),45),(46,(5,66),7))"
        XCTAssert(clearInclusive(for: source) == "(11,2,3,45,46,5,66,7)")
        
        source = "(11,((2,3),45),(46,(5,66),7)),(4,5)"
        XCTAssert(clearInclusive(for: source) == nil)
        
        source = "((11,((2,3),45),(46,(5,66),7)),(4,5))"
        XCTAssert(clearInclusive(for: source) == "(11,2,3,45,46,5,66,7,4,5)")
        
        source = "(((11,((2,3),45),(46,(5,66),7)),(,5))"
        XCTAssert(clearInclusive(for: source) == nil)
    }
    
    func testJudgeInteger() throws {
        var source = "-543"
        XCTAssert(judgeInteger(for: source) == -543)
        
        source = "543"
        XCTAssert(judgeInteger(for: source) == 543)
        
        source = "+543"
        XCTAssert(judgeInteger(for: source) == 543)
        
        source = "++543"
        XCTAssert(judgeInteger(for: source) == nil)
        
        source = "-000"
        XCTAssert(judgeInteger(for: source) == 0)
    }
    
    func testMatchString() throws {
        var substring = "abababaabcbab"
        var pattern = "abaabc"
        XCTAssert(match(pattern: pattern, subString: substring) == 4)
        
        substring = "a"
        pattern = "b"
        XCTAssert(match(pattern: pattern, subString: substring) == nil)
    }
    
    func testMaxLengthBackSchist() throws {
        var source = "abcdefgfedxyz"
        XCTAssert(maxLengthBackSchist(for: source) == "defgfed")
        
        source = "abcbax"
        XCTAssert(maxLengthBackSchist(for: source) == "abcba")
    }
    
    func testDictionarySortString() throws {
        let source = ["bed", "dog", "dea", "ee"]
        XCTAssert(dictionarySort(for: source) == ["dea", "dog", "ee", "bed"])
    }
    
    func testContainRepeatCharacter() throws {
        var source = "good"
        XCTAssertTrue(containRepeatCharacter(for: source))
        
        source = "abc"
        XCTAssertFalse(containRepeatCharacter(for: source))
    }
    
    func testRemoveCharacter() throws {
        let source = "abcaabcxd"
        XCTAssert(removeCharacter(in: source, with: "a") == "bcbcxd")
        XCTAssert(removeCharacter(in: source, with: "b") == "acaacxd")
        XCTAssert(removeCharacter(in: source, with: "x") == "abcaabcd")
        XCTAssert(removeCharacter(in: source, with: "s") == "abcaabcxd")
    }
    
    func testSearchElementInDictionaryTree() throws {
        var result = searchElementInDictionaryTree(end: 10, sort: 1)
        XCTAssert(result == 1)
        
        result = searchElementInDictionaryTree(end: 10, sort: 2)
        XCTAssert(result == 10)
        
        result = searchElementInDictionaryTree(end: 10, sort: 3)
        XCTAssert(result == 2)
        
        result = searchElementInDictionaryTree(end: 10, sort: 4)
        XCTAssert(result == 3)
        
        result = searchElementInDictionaryTree(end: 10, sort: 10)
        XCTAssert(result == 9)
        
        result = searchElementInDictionaryTree(end: 100, sort: 3)
        XCTAssert(result == 100)
        
        result = searchElementInDictionaryTree(end: 100, sort: 5)
        XCTAssert(result == 12)
    }
    
    func testRemoveCharacterForAnother() throws {
        let source = "They are students"
        let another = "aeiou"
        XCTAssert(removeCharacter(in: source, for: another) == "Thy r stdnts")
    }
    
    func testFindMaxLengthStringComponentedByAnother() throws {
        let source = ["test", "tester", "testertest", "testing", "apple", "seattle", "banana", "batting", "ngcat", "batti", "bat", "testingtester", "testbattingcat", "testbattingcatappl"]
        XCTAssert(findMaxLengthStringComponentedByAnother(for: source) == "testbattingcat")
    }
    
    func testMaxCountForAppearContinuously() throws {
        var source = "cbaaabbcc"
        XCTAssert(maxCountForAppearContinuously(for: source) == 3)
        
        source = "abbc"
        XCTAssert(maxCountForAppearContinuously(for: source) == 2)
        
        source = "abc"
        XCTAssert(maxCountForAppearContinuously(for: source) == 1)
    }
    
    func testMaxLenghtIncreasingSubsequence() throws {
        let source = Array("xbcdza")
        XCTAssert(maxLenghtIncreasingSubsequence(for: source) == 4)
    }
    
    func testSpinString() throws {
        let source = "abcdefgh"
        XCTAssert(spin(for: source, location: 3) == "fghabcde")
    }
    
    func testMaxLengthCommonSubstring() throws {
        var source = "babcabc"
        XCTAssert(maxLengthCommonSubstring(for: source) == "abc")
        
        source = "babcabd"
        XCTAssert(maxLengthCommonSubstring(for: source) == "ab")
    }
    
    func testMaxSubsquenceInDictionarySort() throws {
        let source = "acbdxmng"
        XCTAssert(maxSubsquenceInDictionarySort(for: source) == "xng")
    }
    
    func testIsSpin() throws {
        let to = "waterbottle"
        let pattern = "erbottlewat"
        XCTAssertTrue(isSpin(for: pattern, to: to))
    }
    
    func testRemoveCombineSpace() throws {
        let source = "  i am   a  little    boy     "
        XCTAssert(removeCombineSpace(for: source) == "i am a little boy")
    }
    
    func testLevenshtein() throws {
        let from = "beiln"
        let to = "feiling"
        XCTAssert(levenshtein(from: from, to: to) == 3)
    }
    
    func testResolveRelativePath() throws {
        var from = "/qihoo/app/a/b/c/d/new.c"
        let to = "/qihoo/app/1/2/test.c"
        XCTAssert(resolveRelativePath(from: from, to: to) == "../../../../1/2/test.c")
        
        from = "/s/d/test.c"
        XCTAssert(resolveRelativePath(from: from, to: to) == "../../qihoo/app/1/2/test.c")
    }
    
    func testShortestChainLengthForTransform() throws {
        let source = ["pooN", "pbcc", "zamc", "poIc", "pbca", "pbIc", "poIN"]
        XCTAssert(shortestChainLengthForTransform(from: "TooN", to: "pbca", dictionary: source) == 7)
    }
}
