//
//  StringSolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/27.
//

import Foundation

/// 字符串的全排列
/// - Parameter string: 初始字符串
/// - Returns: 全排列
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

/// 字符串的无重复全排列
/// - Parameter string: 初始字符串
/// - Returns: 全排列
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

/// 判断一个字符串是否包含重复的字符
/// - Parameter string: 初始字符串
/// - Returns: 是否具有相同的字符
func containRepeatCharacter(for string: String) -> Bool {
    let characters = Array(string)
    var charactersSet: Set<Character> = []
    
    for character in characters {
        if charactersSet.contains(character) {
            return true
        } else {
            charactersSet.insert(character)
        }
    }
    return false
}

/// 从字符串中移除指定的字符
/// - Parameters:
///   - string: 字符串
///   - with: 指定的字符
/// - Returns: 处理之后的字符串
func removeCharacter(in string: String, with: Character) -> String {
    var characters = Array(string)
    
    var appearCount = 0
    for (index, character) in characters.enumerated() {
        if character == with {
            appearCount += 1
        } else {
            characters[index - appearCount] = character
        }
    }
    
    if appearCount == 0 {
        return string
    }
    
    characters.removeSubrange(Range(characters.count - appearCount ... characters.count - 1))
    return String(characters)
}

/// 1-n共n个整数按照字典序排列，找到第k个数字
/// - Parameters:
///   - end: 表示n
///   - sort: 表示k
/// - Returns: 第k个数字
func searchElementInDictionaryTree(end: Int, sort: Int) -> Int? {
    var numberStack: [Int] = []
    var nodeStack: [(Int, Int)] = []
    
    func computeNumberStack() -> Int {
        var sum = 0
        for number in numberStack {
            sum = sum * 10 + number
        }
        return sum
    }
    
    if sort > end || sort <= 0 {
        return nil
    }
    
    if end <= 0 {
        return nil
    }
    
    let root = (-1, 1)
    nodeStack.append(root)
    
    var step = 0
    var needAdd = false
    while !nodeStack.isEmpty {
        var current = nodeStack.last!
        
        if step == sort {
            return computeNumberStack()
        }
        
        if needAdd {
            needAdd = false
            current.1 += 1
            if current.1 <= 9 {
                nodeStack.removeLast()
                nodeStack.append(current)
            } else {
                nodeStack.removeLast()
                numberStack.removeLast()
                needAdd = true
                continue
            }
        }
        
        numberStack.append(current.1)
        if computeNumberStack() > end {
            numberStack.removeLast()
            
            nodeStack.removeLast()
            numberStack.removeLast()
            needAdd = true
            continue
        }
        
        let new = (current.1, 0)
        nodeStack.append(new)
        step += 1
    }

    return nil
}

/// 从字符串中移除在另一个字符串出现的字符
/// - Parameters:
///   - string: 待移除的字符串
///   - for: 指定的字符串
/// - Returns: 处理之后的字符串
func removeCharacter(in string: String, for anOther: String) -> String {
    var characters = Array(string)
    let removedCharacters = Set(anOther)
    var appearCount = 0
    for (index, character) in characters.enumerated() {
        if removedCharacters.contains(character) {
            appearCount += 1
        } else {
            characters[index - appearCount] = character
        }
    }
    
    if appearCount == 0 {
        return string
    }
    
    characters.removeSubrange(Range(characters.count - appearCount ... characters.count - 1))
    return String(characters)
}

/// 寻找一个最长的字符串，这个字符串可以由数组中其他的字符串组合合成
/// - Parameter sources: 字符串数组
/// - Returns: 满足条件的最长的字符串
func findMaxLengthStringComponentedByAnother(for sources: [String]) -> String? {
    
    var sourceStrings = sources.map{
        ($0.count, $0)
    }
    
    func adjustHeap(start: Int, end: Int) {
        var parent = start
        var son = 2 * parent + 1
        
        while son <= end {
            if son + 1 <= end {
                if sourceStrings[son + 1].0 < sourceStrings[son].0 {
                    son += 1
                }
            }
            if sourceStrings[parent].0 > sourceStrings[son].0 {
                let temp = sourceStrings[parent]
                sourceStrings[parent] = sourceStrings[son]
                sourceStrings[son] = temp
                
                parent = son
                son = 2 * parent + 1
            } else {
                break
            }
        }
    }
    
    func makeHeap() {
        for index in stride(from: (sourceStrings.count - 2) / 2, through: 0, by: -1) {
            adjustHeap(start: index, end: sourceStrings.count - 1)
        }
    }
    
    func heapSort() {
        makeHeap()
        
        for end in stride(from: sourceStrings.count - 1, through: 1, by: -1) {
            let temp = sourceStrings[end]
            sourceStrings[end] = sourceStrings[0]
            sourceStrings[0] = temp
            
            adjustHeap(start: 0, end: end - 1)
        }
    }
    
    heapSort()
    
    let hashTable = Set(sources)
    
    func innerRecursion(string: String) -> Bool {
        if string.count == 1 {
            if hashTable.contains(string) {
                return true
            } else {
                return false
            }
        }
        let characters = Array(string)
        for index in 0 ..< characters.count - 1 {
            let left = characters[0 ... index]
            let leftString = String(left)
            let right = characters[index + 1 ... characters.count - 1]
            let rightString = String(right)
            if hashTable.contains(leftString) && hashTable.contains(rightString) {
                return true
            } else if hashTable.contains(leftString) && innerRecursion(string: rightString) {
                return true
            } else if hashTable.contains(rightString) && innerRecursion(string: leftString) {
                return true
            }
        }
        return false
    }
    
    for string in sourceStrings where string.0 > 1 {
        if innerRecursion(string: string.1) {
            return string.1
        }
    }
    
    return nil
}

/// 使用递归的方法，求字符串中连续出现相同字符的最大值
/// - Parameter string: 字符串
/// - Returns: 最大值
func maxCountForAppearContinuously(for string: String) -> Int {
    let characters = Array(string)
    guard characters.count > 0 else {
        return 0
    }
    var globeMax = 1
    
    func innerRecursion(start: Int) -> Int {
        
        if start == 0 {
            return 1
        }
        let trailLength = innerRecursion(start: start - 1)
        if characters[start - 1] == characters[start] {
            if trailLength + 1 > globeMax {
                globeMax = trailLength + 1
            }
            return trailLength + 1
        } else {
            return 1
        }
    }
    
    _ = innerRecursion(start: characters.count - 1)
    return globeMax
}

/// 求最长的递增子序列
/// - Parameter sources: 初始序列
/// - Returns: 最长递增子序列的长度
func maxLenghtIncreasingSubsequence<T: Comparable>(for sources: [T]) -> Int {
    
    var maxLengths = Array.init(repeating: 1, count: sources.count)
    
    for index in 0 ... sources.count - 1 {
        if index == 0 {
            maxLengths[index] = 1
        } else {
            var maxLength = 1
            for inner in 0 ... index - 1 {
                if sources[index] > sources[inner] {
                    maxLength = max(maxLength, maxLengths[inner] + 1)
                }
            }
            maxLengths[index] = maxLength
        }
    }
    
    return maxLengths.max()!
}


/// 旋转字符串，将尾部location长度的字符串放置到字符串头部
/// - Parameters:
///   - string: 初始字符串
///   - location: 旋转位置
/// - Returns: 旋转后的字符串
func spin(for string: String, location: Int) -> String {
    var characters = Array(string)
    if location >= characters.count || location <= 0 {
        return string
    }
    for index in 0 ... characters.count - location - 1 {
        if characters.count - location - 1 - index <= index {
            break
        }
        let temp = characters[index]
        characters[index] = characters[characters.count - location - 1 - index]
        characters[characters.count - location - 1 - index] = temp
    }
    
    for index in characters.count - location ... characters.count - 1 {
        if 2 * characters.count - 1 - location - index <= index {
            break
        }
        let temp = characters[index]
        characters[index] = characters[2 * characters.count - 1 - location - index]
        characters[2 * characters.count - 1 - location - index] = temp
    }
    
    for index in 0 ... characters.count - 1 {
        if characters.count - 1 - index <= index {
            break
        }
        let temp = characters[index]
        characters[index] = characters[characters.count - 1 - index]
        characters[characters.count - 1 - index] = temp
    }
    
    return String(characters)
}


/// 寻找一个字符串的最长重复子串
/// - Parameter string: 指定字符串
/// - Returns: 最长的重复子串
func maxLengthCommonSubstring(for string: String) -> String {
    let characters = Array(string)
    
    func makeNext(for start: Int) -> [Int] {
        if start == characters.count - 1 {
            return [-1]
        }
        var next = [-1]
        var index = 1
        var location = -1
        
        while index + start <= characters.count {
            if location == -1 || characters[location + start] == characters[index + start - 1] {
                location += 1
                index += 1
                next.append(location)
            } else {
                location = next[location]
            }
        }
        
        return next
    }
    
    var maxLength = -1
    var maxStart = -1
    for index in 0 ... characters.count - 1 {
        let next = makeNext(for: index)
        for location in 0 ... next.count - 1 {
            if maxLength < next[location] && next[location] != 0 {
                maxLength = next[location]
                maxStart = index + (location - 1) - maxLength + 1
            }
        }
    }
    
    if maxLength == -1 {
        return ""
    } else {
        return String(characters[maxStart ... maxStart + maxLength - 1])
    }
}

/// 给定一个字符串，求串中字典序最大的子序列，给定a0a1a2...an，首先在字符串a0a1a2...an找到最大的字符ai，
/// 然后在ai+1...an中找最大的字符aj，以此类推直到剩余的字符长度为0，将这些找到的字符排列在一起即为最大的子序列
/// - Parameter string: 给定一个字符串
/// - Returns: 最大的子序列
func maxSubsquenceInDictionarySort(for string: String) -> String {
    let characters = Array(string)
    guard !characters.isEmpty else {
        return ""
    }
    
    var result: [Character] = [characters.last!]
    
    var count = characters.count - 1
    while count >= 0 {
        if characters[count] > result.last! {
            result.append(characters[count])
        }
        count -= 1
    }
    
    result = result.reversed()
    return String(result)
}

/// 判断`to`是否可以由`source`经过旋转得到
/// - Parameters:
///   - source: 指定字符串
///   - to: 指定字符串
/// - Returns: 是否可以旋转得到
func isSpin(for source: String, to: String) -> Bool {
    guard source.count == to.count else {
        return false
    }
    let copySource = source + source
    return match(pattern: to, subString: copySource) != nil
}

/// 删除字符串首尾的空格，并合并字符串内部的多个连续的空格为一个空格
/// - Parameter string: 给定的字符串
/// - Returns: 操作后的字符串
func removeCombineSpace(for string: String) -> String {
    var characters = Array(string)
    
    var reallyIndex = 0
    var count = 0
    var isHeadSpace = true
    var isMiddleSpace = false
    while count < characters.count {
        if isHeadSpace && characters[count] == " " {
            count += 1
        } else if isHeadSpace && characters[count] != " " {
            isHeadSpace = false
            characters[reallyIndex] = characters[count]
            reallyIndex += 1
            count += 1
        } else if !isHeadSpace && characters[count] == " " {
            isMiddleSpace = true
            count += 1
        } else if !isHeadSpace && characters[count] != " " {
            if isMiddleSpace {
                isMiddleSpace = false
                characters[reallyIndex] = " "
                reallyIndex += 1
            }
            characters[reallyIndex] = characters[count]
            reallyIndex += 1
            count += 1
        }
    }
    
    if reallyIndex == 0 {
        return ""
    } else {
        return String(characters[0 ..< reallyIndex])
    }
}

/// 求两个字符串的编辑距离，可以进行增加替换删除将`from`变为`to`
/// - Parameters:
///   - from: 初始字符串
///   - to: 目标字符串
/// - Returns: 最小的距离
func levenshtein(from: String, to: String) -> Int {
    var distance: [[Int]] = Array(repeating: Array(repeating: -1, count: to.count + 1), count: from.count + 1)
    let charactersF = Array(from)
    let charactersT = Array(to)
    distance[0][0] = 0
    for index in 1 ... from.count {
        distance[index][0] = index
    }
    for index in 1 ... to.count {
        distance[0][index] = index
    }
    for indexF in 1 ... from.count {
        for indexT in 1 ... to.count {
            if charactersF[indexF - 1] == charactersT[indexT - 1] {
                distance[indexF][indexT] = min(distance[indexF - 1][indexT] + 1, distance[indexF][indexT - 1] + 1, distance[indexF - 1][indexT - 1])
            } else {
                distance[indexF][indexT] = min(distance[indexF - 1][indexT] + 1, distance[indexF][indexT - 1] + 1, distance[indexF - 1][indexT - 1] + 1)
            }
        }
    }
    return distance[from.count][to.count]
}


/// 根据两个文件的绝对路径计算相对路径
/// - Parameters:
///   - from: 起始文件路径
///   - to: 目标文件路径
/// - Returns: 起始到目标文件的相对路径
func resolveRelativePath(from: String, to: String) -> String {
    let fromComponents = from.split(separator: "/")
    let aimComponents = to.split(separator: "/").map({String($0)})
    
    var count = 0
    while count < fromComponents.count && count < aimComponents.count {
        if fromComponents[count] == aimComponents[count] {
            count += 1
        } else {
            break
        }
    }
    var results: [String] = []
    let pointsNumber = fromComponents.count - count - 1
    results.append(contentsOf: Array(repeating: "..", count: pointsNumber))
    results.append(contentsOf: aimComponents[count ... aimComponents.count - 1])
    return results.joined(separator: "/")
}

/// 将from变为to，一次只允许变换一个字符，且每次变换后的字符串均需要在给定的集合中，已知to在给定的集合中，且集合中的单词长度都一样
/// - Parameters:
///   - from: 起始字符串
///   - to: 目标字符串
///   - dictionary: 给定的字符串集合
/// - Returns: 变换所需的最小步骤数
func shortestChainLengthForTransform(from: String, to: String, dictionary: [String]) -> Int? {
    func isAdjacent(left: String, right: String) -> Bool {
        guard left.count == right.count else {
            return false
        }
        let leftCharacters = Array(left)
        let rightCharacters = Array(right)
        var diff = 0
        for index in 0 ..< leftCharacters.count {
            if leftCharacters[index] == rightCharacters[index] {
                continue
            } else {
                if diff == 0 {
                    diff += 1
                } else {
                    return false
                }
            }
        }
        
        if diff == 1 {
            return true
        } else {
            return false
        }
    }
    
    var queue = [(from, 1)]
    var copyDictionary = dictionary
    while !queue.isEmpty {
        let current = queue.removeFirst()
        if current.0 == to {
            return current.1
        }
        var removeCount = 0
        for index in 0 ..< copyDictionary.count {
            if isAdjacent(left: current.0, right: copyDictionary[index]) {
                removeCount += 1
                queue.append((copyDictionary[index], current.1 + 1))
            } else {
                copyDictionary[index - removeCount] = copyDictionary[index]
            }
        }
        copyDictionary = Array(copyDictionary.prefix(copyDictionary.count - removeCount))
    }
    return nil
}
