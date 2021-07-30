//
//  StringSolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/27.
//

import Foundation

func allPermutations(for string: String) -> [String] {
    var characters = Array(string.unicodeScalars)
    
    var results: [String] = []
    
    func allPermutationsReverse(start: Int, end: Int) {
        if start >= end {
            results.append(String.init(String.UnicodeScalarView.init(characters)))
            return
        }
        for index in start ... end {
            let temp = characters[index]
            characters[index] = characters[start]
            characters[start] = temp
            allPermutationsReverse(start: start + 1, end: end)
            characters[start] = characters[index]
            characters[index] = temp
        }
    }
    
    allPermutationsReverse(start: 0, end: characters.endIndex - 1)
    return results
}

func allPermutationsWithoutRepeat(for string: String) -> [String] {
    var characters = Array(string.unicodeScalars)
    
    var results: [String] = []
    
    func allPermutationsReverseWithoutRepeat(start: Int, end: Int) {
        if start >= end {
            results.append(String.init(String.UnicodeScalarView.init(characters)))
            return
        }
        for index in start ... end {
            if index != start && characters[index] == characters[start] {
                continue
            }
            let temp = characters[index]
            characters[index] = characters[start]
            characters[start] = temp
            allPermutationsReverseWithoutRepeat(start: start + 1, end: end)
            characters[start] = characters[index]
            characters[index] = temp
        }
    }
    
    allPermutationsReverseWithoutRepeat(start: 0, end: characters.endIndex - 1)
    return results
}

/// 找到两个字符串的最长公共子串
/// - Parameters:
///   - first: 第一个字符串
///   - second: 第二个字符串
/// - Returns: 最长公共子串
func findMaxLengthCommonSubString(for first: String, and second: String) -> String {
    let firstCharacters = Array(first.unicodeScalars)
    let secondCharacters = Array(second.unicodeScalars)
    
    var maxStartInFirst: Int?
    var maxLength = 0
    for moveDistance in 0 ... firstCharacters.count + secondCharacters.count - 2 {
        let secondRangeEnd = moveDistance <= (firstCharacters.count - 1) ? secondCharacters.count - 1 : secondCharacters.count - 1 - (moveDistance - (firstCharacters.count - 1))
        let secondRangeStart = moveDistance <= (secondCharacters.count - 1) ? secondCharacters.count - 1 - moveDistance : 0
        let firstRangeEnd = moveDistance <= (firstCharacters.count - 1) ? moveDistance : firstCharacters.count - 1
        let firstRangeStart = moveDistance <= (secondCharacters.count - 1) ? 0 : moveDistance - (secondCharacters.count - 1)
        guard firstRangeEnd - firstRangeStart == secondRangeEnd - secondRangeStart else {
            fatalError("Error!")
        }
        var equalStart: Int?
        var equalLength = 0
        for count in 0 ... firstRangeEnd - firstRangeStart {
            if firstCharacters[firstRangeStart + count] == secondCharacters[secondRangeStart + count] {
                if equalLength == 0 {
                    equalStart = firstRangeStart + count
                }
                equalLength += 1
            } else {
                if equalLength > maxLength {
                    maxLength = equalLength
                    maxStartInFirst = equalStart
                }
                equalStart = nil
                equalLength = 0
            }
        }
        if equalLength > maxLength {
            maxLength = equalLength
            maxStartInFirst = equalStart
            equalStart = nil
            equalLength = 0
        }
    }
    
    if maxLength == 0 {
        return ""
    } else {
        return String.init(String.UnicodeScalarView.init(Array(firstCharacters[maxStartInFirst! ... (maxStartInFirst! + maxLength - 1)])))
    }
}


/// 对字符串进行原地压缩，aaabbcc -> a3b2c2
/// - Parameter string: 字符串
/// - Returns: 压缩后的字符串
func compact(for string: String) -> String {
    var characters = Array(string.unicodeScalars)
    var currentLocation = -1
    guard !characters.isEmpty else {
        return ""
    }
    var count = 0
    var scan = 0
    var flagCharacter = characters[0]
    while scan < characters.count {
        if characters[scan] == flagCharacter {
            count += 1
        } else {
            if count == 1 {
                currentLocation += 1
                characters[currentLocation] = flagCharacter
            } else {
                currentLocation += 1
                characters[currentLocation] = flagCharacter
                currentLocation += 1
                let countString = Array(String(count).unicodeScalars)
                characters.replaceSubrange(.init(currentLocation ... currentLocation + countString.count - 1), with: countString)
                currentLocation += countString.count - 1
            }
            flagCharacter = characters[scan]
            count = 1
        }
        scan += 1
    }
    if count == 1 {
        currentLocation += 1
        characters[currentLocation] = flagCharacter
    } else {
        currentLocation += 1
        characters[currentLocation] = flagCharacter
        currentLocation += 1
        let countString = Array(String(count).unicodeScalars)
        characters.replaceSubrange(.init(currentLocation ... currentLocation + countString.count - 1), with: countString)
        currentLocation += countString.count - 1
    }
    
    return String.init(String.UnicodeScalarView.init(Array(characters[0 ... currentLocation])))
}

/// 就地反转字符串
/// - Parameter string: 初识字符串
/// - Returns: 反转后的字符串
func reverse(for string: String) -> String {
    guard !string.isEmpty else {
        return ""
    }
    var characters = Array(string.unicodeScalars)
    var start = 0
    var end = characters.count - 1
    while start < end {
        let temp = characters[start]
        characters[start] = characters[end]
        characters[end] = temp
        start += 1
        end -= 1
    }
    return String(String.UnicodeScalarView.init(characters))
}

/// 就地按单词反转字符串
/// - Parameter string: 初识字符串
/// - Returns: 反转后的字符串
func reverseWords(for string: String) -> String {
    var characters = Array(reverse(for: string).unicodeScalars)
    var start = 0
    for index in 0 ..< characters.count {
        if characters[index] != " " {
            continue
        } else {
            var count = start
            var end = index - 1
            while count < end {
                let temp = characters[count]
                characters[count] = characters[end]
                characters[end] = temp
                
                count += 1
                end -= 1
            }
            
            start = index + 1
        }
    }
    
    var count = start
    var end = characters.count - 1
    while count < end {
        let temp = characters[count]
        characters[count] = characters[end]
        characters[end] = temp
        
        count += 1
        end -= 1
    }
    
    return String(String.UnicodeScalarView(characters))
}

/// 判断一个字符串是不是另一个字符串的换位字符串，即组成字母都一样
/// - Parameters:
///   - first: 第一个字符串
///   - second: 第二个字符串
/// - Returns: 是否是换位字符串
func isTransparentString(for first: String, and second: String) -> Bool {
    var firstMap: [Character: Int] = [:]
    for element in first {
        if var count = firstMap[element] {
            count += 1
            firstMap[element] = count
        } else {
            firstMap[element] = 1
        }
    }
    var secondMap: [Character: Int] = [:]
    for element in second {
        if var count = secondMap[element] {
            count += 1
            secondMap[element] = count
        } else {
            secondMap[element] = 1
        }
    }
    return firstMap == secondMap
}

/// 判断一个字符串是否包含另一个字符串，即一个字符串中出现的所有字符都出现在另一个字符串中
/// - Parameters:
///   - string: 待判断的字符串
///   - parent: 基准字符串，比`string`要长
/// - Returns: `parent`是否包含`string`
func contains(string: String, in parent: String) -> Bool {
    guard parent.count > string.count else {
        return false
    }
    
    let characters = Array(parent.unicodeScalars)
    let map = Set(characters)
    for element in string.unicodeScalars {
        if !map.contains(element) {
            return false
        }
    }
    return true
}

/// 对字符串进行排序，使得所有的小写字母排在大写字母之前
/// - Parameter string: 初始字符串
/// - Returns: 排序后的字符串
func rearrange(string: String) -> String {
    guard !string.isEmpty else {
        return ""
    }
    var characters = Array(string.unicodeScalars)
    
    var start = 0
    var end = characters.count - 1
    while start < end {
        while start < end && characters[start] <= Unicode.Scalar.init(122) && characters[start] >= Unicode.Scalar.init(97) {
            start += 1
        }
        while end > start && characters[end] <= Unicode.Scalar.init(90) && characters[end] >= Unicode.Scalar.init(65) {
            end -= 1
        }
        if end > start {
            let temp = characters[start]
            characters[start] = characters[end]
            characters[end] = temp
            
            end -= 1
            start += 1
        }
    }
    
    return String(String.UnicodeScalarView(characters))
}

/// 消除字符串的内嵌括号 (1,(2,3),(4,(5,6),7)) -> (1,2,3,4,5,6,7) ，括号内的元素是数字也有可能是另一个括号，如果表达式有误则报错。
/// - Parameter string: 初始字符串
/// - Returns: 消除后的字符串
func clearInclusive(for string: String) -> String? {
    let characters = Array(string.unicodeScalars)
    guard !characters.isEmpty else {
        return nil
    }
    
    var previous = characters[0]
    guard previous == "(" else {
        return nil
    }
    var enBracketCount = 1
    var results: [String.UnicodeScalarView.Element] = [previous]
    var count = 1
    while count < characters.count {
        switch previous {
        case "(":
            switch characters[count] {
            case "(":
                enBracketCount += 1
            case "0" ... "9":
                results.append(characters[count])
            default:
                return nil
            }
        case ")":
            switch characters[count] {
            case ")":
                enBracketCount -= 1
                if enBracketCount < 0 {
                    return nil
                }
            case "0" ... "9":
                results.append(characters[count])
            case ",":
                if enBracketCount == 0 {
                    return nil
                }
                results.append(characters[count])
            default:
                return nil
            }
        case ",":
            switch characters[count] {
            case "(":
                enBracketCount += 1
            case "0" ... "9":
                results.append(characters[count])
            default:
                return nil
            }
        case "0" ... "9":
            switch characters[count] {
            case ")":
                enBracketCount -= 1
                if enBracketCount < 0 {
                    return nil
                }
            case "0" ... "9", ",":
                results.append(characters[count])
            default:
                return nil
            }
        default:
            return nil
        }
        previous = characters[count]
        count += 1
    }
    
    if enBracketCount != 0 {
        return nil
    } else {
        results.append(")")
        return String(String.UnicodeScalarView(results))
    }
}


/// 判断一个字符串是否为整数
/// - Parameter string: 初始字符串
/// - Returns: 整数
func judgeInteger(for string: String) -> Int? {
    guard !string.isEmpty else {
        return nil
    }
    var sum = 0
    var position: Bool
    if string.first! == "-" && string.count >= 2 {
        position = false
    } else if string.first! >= "0" && string.first! <= "9" {
        sum = Int(String(string.first!))!
        position = true
    } else if string.first! == "+" && string.count >= 2 {
        position = true
    } else {
        return nil
    }
    var count = 1
    let characters = Array(string)
    while count < characters.count {
        switch characters[count] {
        case "0" ... "9":
            sum = sum * 10 + Int(String(characters[count]))!
        default:
            return nil
        }
        count += 1
    }
    return position ? sum : -sum
}

/// 字符串匹配KMP算法
/// - Parameters:
///   - pattern: 模式串
///   - subString: 子串
/// - Returns: 在子串中匹配到的索引
func match(pattern: String, subString: String) -> Int? {
    func generateNexts() -> [Int] {
        let patternCharacters = Array(pattern.unicodeScalars)
        guard patternCharacters.count >= 1 else {
            return []
        }
        var next = [-1]
        guard patternCharacters.count >= 2 else {
            return next
        }
        var count = 1
        var k = -1
        while count < patternCharacters.count {
            if k == -1 || patternCharacters[count - 1] == patternCharacters[k] {
                next.append(k+1)
                count += 1
                k += 1
            } else {
                k = next[k]
            }
        }
        return next
    }
    let nexts = generateNexts()
    let patternCharacters = Array(pattern.unicodeScalars)
    let subStringCharacters = Array(subString.unicodeScalars)
    var patternCount = 0
    var subStringCount = 0
    while patternCount < patternCharacters.count && subStringCount < subStringCharacters.count {
        if patternCount == -1 || patternCharacters[patternCount] == subStringCharacters[subStringCount] {
            patternCount += 1
            subStringCount += 1
        } else {
            patternCount = nexts[patternCount]
        }
    }
    
    if patternCount >= patternCharacters.count {
        return subStringCount - patternCharacters.count
    }
    return nil
}

/// 寻找最长的回文串
/// - Parameter string: 初始字符串
/// - Returns: 最长的回文串
func maxLengthBackSchist(for string: String) -> String {
    let characters = Array(string.unicodeScalars)
    guard !characters.isEmpty else {
        return ""
    }
    var informations: [[Bool]] = Array(repeating: Array(repeating: false, count: characters.count), count: characters.count)
    
    var maxLength = 1
    var maxStartIndex = 0
    
    for index in 0 ..< characters.count {
        informations[index][index] = true
    }
    
    for index in 0 ..< characters.count - 1 {
        if characters[index] == characters[index + 1] {
            if 2 > maxLength {
                maxLength = 2
                maxStartIndex = index
            }
            informations[index][index + 1] = true
        }
    }
    
    for step in 1 ... characters.count - 2 {
        for start in 1 ... characters.count - 1 - step {
            let end = start + step - 1
            if informations[start][end] && characters[start - 1] == characters[end + 1] {
                if end - start + 3 > maxLength {
                    maxLength = end - start + 3
                    maxStartIndex = start - 1
                }
                informations[start - 1][end + 1] = true
            }
        }
    }
    
    return String(String.UnicodeScalarView(characters[maxStartIndex ... maxStartIndex + maxLength - 1]))
}


/// 已知字母序列[d,g,e,c,f,b,o,a]
/// - Parameter strings: 一组字符串
/// - Returns: 排序好的字符串
func dictionarySort(for strings: [String]) -> [String] {
    let defineCharacters: [Character] = ["d", "g", "e", "c", "f", "b", "o", "a"]
    
    func convertSerialToIndex(for character: Character) -> Int {
        if let index = defineCharacters.firstIndex(of: character) {
            return index
        } else {
            fatalError("Error")
        }
    }
    
    class Node: Root {
        var value: Character
        var isWord = false
        
        init(value: Character) {
            self.value = value
        }
    }
    
    class Root {
        var subChild: [Node?] = Array.init(repeating: nil, count: 8)
        
        func child(for index: Int) -> Node? {
            subChild[index]
        }
        
        func set(child: Node?, for index: Int) {
            subChild[index] = child
        }
    }
    
    let root = Root()
    
    func insertWord(for word: String) {
        let characters = Array(word)
        guard !characters.isEmpty else {
            return
        }
        var current: Node
        if let head = root.child(for: convertSerialToIndex(for: characters[0])) {
            current = head
        } else {
            current = Node(value: characters[0])
            root.set(child: current, for: convertSerialToIndex(for: characters[0]))
        }
        
        for index in 1 ..< characters.count {
            let characterIndex = convertSerialToIndex(for: characters[index])
            if let node = current.child(for: characterIndex) {
                current = node
            } else {
                let new = Node(value: characters[index])
                current.set(child: new, for: characterIndex)
                current = new
            }
        }
        
        current.isWord = true
    }
    
    for word in strings {
        insertWord(for: word)
    }
    
    var sortWords: [String] = []
    var traces: [Character] = []
    func sortTree(for node: Node) {
        traces.append(node.value)
        if node.isWord {
            sortWords.append(String(traces))
        }
        for child in node.subChild where child != nil {
            sortTree(for: child!)
        }
        traces.removeLast()
    }
    
    func sortTree() {
        for head in root.subChild where head != nil {
            sortTree(for: head!)
        }
    }
    
    sortTree()
    return sortWords
}
