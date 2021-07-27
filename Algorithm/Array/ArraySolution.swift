//
//  ArraySolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/21.
//

import Foundation

/// 1-1000其中有一个重复元素，共计1001个元素的数组，找出其中重复的元素
/// - Parameter source: 数组
/// - Returns: 重复的元素
func findOnlyRepeatOneElementFrom1_1000(input source: [Int]) -> Int {
    let sum = source.reduce(0, +)
    return sum - 1001 * 500
}

/// 1-n其中有m个重复元素，共计n+m个元素的数组，找出其中所有重复的元素
/// - Parameters:
///   - max: 数组最大值n
///   - source: 数组
/// - Returns: 重复的序列
func findRepeatElementFrom(max: Int, source: [Int]) -> [Int] {
    let repeatCount = source.count - max
    var copySource = source
    var start = 0
    var findRepeatCount = 0
    var repeatElement: [Int] = []
    
    while findRepeatCount < repeatCount {
        if copySource[start] > 0 {
            copySource[start] = -copySource[start]
            start = -copySource[start]
        } else {
            findRepeatCount += 1
            repeatElement.append(start)
            start = max + findRepeatCount
        }
    }
    
    return repeatElement
}

/// 找出数组中最大的和最小的元素，元素两两均不相同
/// - Parameter source: 数组
/// - Returns: 最大值和最小值
func findMinAndMax<T: Comparable>(from source: [T]) -> (max: T, min: T) {
    var max = source[0]
    var min = source[0]
    
    for element in source {
        if element > max {
            max = element
        } else if element < min {
            min = element
        } else {
            continue
        }
    }
    
    return (max, min)
}

/// 给出从小到大排序的数组经过一个元素旋转后的数组，找出原有序数组的最小值，12345->34512，最小元素就是1
/// - Parameter source: 旋转后的数组
/// - Returns: 最小的元素
func findMinInSpinSortArray<T: Comparable>(from source: [T]) -> T {
    if source.count == 1 {
        return source[0]
    }
    var currentIndex = 1
    while currentIndex < source.count && source[currentIndex - 1] < source[currentIndex] {
        currentIndex += 1
    }
    if currentIndex < source.count {
        return source[currentIndex]
    } else {
        return source[0]
    }
}

/// 将数组的前k个元素移动到数组后面，返回新的数组
/// - Parameters:
///   - source: 原数组
///   - location: 前k个元素
/// - Returns: 旋转后的数组
func makeSpinSortArray<T: Comparable>(for source: [T], spin location: Int) -> [T] {
    if location < 1 || location >= source.count {
        return source
    }
    var copySource = source
    
    func reverse(start: Int, end: Int) {
        var left = start
        var right = end
        while left < right {
            let temp = copySource[left]
            copySource[left] = copySource[right]
            copySource[right] = temp
            left += 1
            right -= 1
        }
    }
    
    reverse(start: 0, end: location - 1)
    reverse(start: location, end: source.count - 1)
    reverse(start: 0, end: source.count - 1)
    
    return copySource
}

/// 1-n共n-1个整数，少了一个整数，且n-1个元素的数组无序，找出缺失的数组
/// - Parameter source: 数组
/// - Returns: 缺失的元素
func findLossElement(for source: [Int]) -> Int {
    let max = source.count + 1
    var standard = 0
    for element in 1 ... max {
        standard = standard ^ element
    }
    
    for element in source {
        standard = standard ^ element
    }
    
    return standard
}

/// 数组中只有两个数字出现了奇数次，另外的数次全部出现了偶数次，求那两个出现奇数次的数字
/// - Parameter source: 数组
/// - Returns: 两个出现奇数次的数字
func findOddTimesOfNumber(from source: [Int]) -> (min: Int, max: Int) {
    let xorSum = source.reduce(0, {
        $0 ^ $1
    })
    
    var count = 0
    while (xorSum >> count) & 1 == 0 {
        count += 1
    }
    
    var oneXorSum = 0
    var zeroXorSum = 0
    
    for element in source {
        if (element >> count) & 1 == 0 {
            zeroXorSum = zeroXorSum ^ element
        } else {
            oneXorSum = oneXorSum ^ element
        }
    }
    
    let zeroXor = zeroXorSum ^ xorSum
    let oneXor = oneXorSum ^ xorSum
    if zeroXor < oneXor {
        return (zeroXor, oneXor)
    } else {
        return (oneXor, zeroXor)
    }
}

func findKSmallNumber<T: Comparable>(from source: [T], rank: Int) -> T? {
    guard source.count >= rank && rank >= 1 else {
        return nil
    }
    
    var results: [T] = []
    
    func adjustHeapDown(start: Int, end: Int) {
        var parent = start
        var son = 2 * parent + 1
        
        while son <= end {
            if son < end {
                if results[son] < results[son + 1] {
                    son += 1
                }
            }
            if results[parent] < results[son] {
                let temp = results[parent]
                results[parent] = results[son]
                results[son] = temp
                
                parent = son
                son = 2 * parent + 1
            } else {
                break
            }
        }
    }
    
    func adjustHeapUp(start: Int, end: Int) {
        if start >= end {
            return
        }
        var son = end
        var parent = (son - 1) / 2
        
        while parent >= start {
            if results[son] > results[parent] {
                let temp = results[son]
                results[son] = results[parent]
                results[parent] = temp
                
                son = parent
                if son == 0 {
                    break
                } else {
                    parent = (son - 1) / 2
                }
                
            } else {
                break
            }
        }
    }
    
    func downHeap() {
        adjustHeapDown(start: 0, end: results.count - 1)
    }
    
    func upHeap() {
        adjustHeapUp(start: 0, end: results.count - 1)
    }
    
    func push(element: T) {
        if results.isEmpty {
            results.append(element)
        } else if results.count == rank {
            if element > results[0] {
                return
            } else {
                results[0] = element
                downHeap()
            }
        } else {
            results.append(element)
            upHeap()
        }
    }
    
    for element in source {
        push(element: element)
    }
    
    return results[0]
}


/// 求数组中的最小公倍数
/// - Parameter source: 数组
/// - Returns: 最小公倍数
func findMinimumCommonMultiple(for source: [Int]) -> Int {
    var maxValue = source[0]
    for element in source {
        if maxValue < element {
            maxValue = element
        }
    }
    if maxValue == 1 {
        return 1
    }
    if maxValue == 2 {
        return 2
    }
    
    var magicalitiesCount: [Int: Int] = [:]
    var records = Array<Bool>.init(repeating: true, count: maxValue)
    records[0] = false

    for element in stride(from: 2, through: Int(sqrt(Double(maxValue))), by: 1) {
        if records[element - 1] {
            for factor in stride(from: element * element, through: maxValue, by: element) {
                records[factor - 1] = false
            }
        }
    }
    
    var magicalities: [Int] = []
    for index in 0 ..< maxValue {
        if records[index] {
            magicalitiesCount[index + 1] = 0
            magicalities.append(index + 1)
        }
    }
    
    for element in source {
        if let count = magicalitiesCount[element] {
            magicalitiesCount[element] = max(count, 1)
            continue
        }
        var elementMagicalitiesCount: [Int: Int] = [:]
        var remain = element
        while remain > 1 {
            if magicalitiesCount[remain] != nil {
                if let count = elementMagicalitiesCount[remain] {
                    elementMagicalitiesCount[remain] = count + 1
                } else {
                    elementMagicalitiesCount[remain] = 1
                }
                break
            }
            let flag = Int(sqrt(Double(remain)))
            for prime in magicalities {
                if prime > flag {
                    fatalError("Error")
                }
                if remain % prime == 0 {
                    if let count = elementMagicalitiesCount[prime] {
                        elementMagicalitiesCount[prime] = count + 1
                    } else {
                        elementMagicalitiesCount[prime] = 1
                    }
                    remain = remain / prime
                    break
                }
            }
        }
        magicalitiesCount = magicalitiesCount.merging(elementMagicalitiesCount, uniquingKeysWith: {
            max($0, $1)
        })
    }
    
    func pow(_ value: Int, _ index: Int) -> Int {
        if index == 0 {
            return 1
        }
        var sum = 1
        for _ in 1 ... index {
            sum *= value
        }
        return sum
    }
    
    return magicalitiesCount.reduce(1, {
        $0 * pow($1.key, $1.value)
    })
    
}

/// 找到数组中的前三名
/// - Parameter source: 数组
/// - Returns: 前三名元素
func find3rdMaxNumber<T: Comparable>(from source: [T]) -> [T] {
    if source.count <= 3 {
        return source.sorted()
    }
    var smallSource = Array(source.prefix(3)).sorted()
    
    for element in source.suffix(source.count - 3) {
        if element < smallSource[0] {
            continue
        } else if element < smallSource[1] {
            smallSource[0] = element
        } else if element < smallSource[2] {
            smallSource[0] = smallSource[1]
            smallSource[1] = element
        } else {
            smallSource[0] = smallSource[1]
            smallSource[1] = smallSource[2]
            smallSource[2] = element
        }
    }
    
    return smallSource
}

/// 一个数组，里面有重复的元素，给定两个数，计算出这两个数字的最小距离
/// - Parameters:
///   - source: 数组
///   - left: 第一个数字
///   - right: 第二个数字
/// - Returns: 最小距离
func findSmallestDistance<T: Equatable>(from source: [T], left: T, right: T) -> Int? {
    var previousLeftIndex: Int?
    var previousRightIndex: Int?
    
    var minDistance: Int?
    for (index, element) in source.enumerated() {
        if element == left {
            if previousLeftIndex == nil {
                if previousRightIndex == nil {
                    previousLeftIndex = index
                } else {
                    previousLeftIndex = index
                    minDistance = index - previousRightIndex!
                }
            } else if previousRightIndex == nil {
                previousLeftIndex = index
            } else if previousLeftIndex! > previousRightIndex! {
                previousLeftIndex = index
            } else {
                previousLeftIndex = index
                let diff = index - previousRightIndex!
                minDistance = min(minDistance!, diff)
            }
        } else if element == right {
            if previousRightIndex == nil {
                if previousLeftIndex == nil {
                    previousRightIndex = index
                } else {
                    previousRightIndex = index
                    minDistance = index - previousLeftIndex!
                }
            } else if previousLeftIndex == nil {
                previousRightIndex = index
            } else if previousLeftIndex! < previousRightIndex! {
                previousRightIndex = index
            } else {
                previousRightIndex = index
                let diff = index - previousLeftIndex!
                minDistance = min(minDistance!, diff)
            }
        }
    }
    
    return minDistance
}

/// 三个升序数组，每个数组分别取一个元素构成三元组，三元组的距离为三个元素之间的最小差值的绝对值，求这三个数组构成的所有三元组的最小距离
/// - Parameters:
///   - one: 第一个数组
///   - two: 第二个数组
///   - three: 第三个数组
/// - Returns: 最小的三元组距离
func findSmallestTriadDistance(for one: [Int], two: [Int], three: [Int]) -> Int? {
    if one.isEmpty || two.isEmpty || three.isEmpty {
        return nil
    }
    
    var currentLeftIndex = 0
    var currentMiddleIndex = 0
    var currentRightIndex = 0
    
    func computDistance(oneIndex: Int, twoIndex: Int, threeIndex: Int) -> (max: Int, location: ((Int, Int), (Int, Int)), dispose: (Int, Int)) {
        let diffOne = abs(one[oneIndex] - two[twoIndex])
        let diffTwo = abs(one[oneIndex] - three[threeIndex])
        let diffThree = abs(two[twoIndex] - three[threeIndex])
        
        var max = diffOne
        var location = ((1,oneIndex), (2, twoIndex))
        var dispose = (3, threeIndex)
        if max < diffTwo {
            max = diffTwo
            location = ((1,oneIndex), (3, threeIndex))
            dispose = (2, twoIndex)
        }
        
        if max < diffThree {
            max = diffThree
            location = ((2,twoIndex), (3, threeIndex))
            dispose = (1,oneIndex)
        }
        
        return (max, location, dispose)
    }
    
    func selected(for location: Int, index: Int) -> Int {
        switch location {
        case 1:
            return one[index]
        case 2:
            return two[index]
        case 3:
            return three[index]
        default:
            fatalError("Error")
        }
    }
    
    func updateIndex(location: Int, index: Int) -> Bool {
        switch location {
        case 1:
            let maxCount = one.count
            if index >= maxCount - 1 {
                return false
            } else {
                currentLeftIndex += 1
            }
        case 2:
            let maxCount = two.count
            if index >= maxCount - 1 {
                return false
            } else {
                currentMiddleIndex += 1
            }
        case 3:
            let maxCount = three.count
            if index >= maxCount - 1 {
                return false
            } else {
                currentRightIndex += 1
            }
        default:
            fatalError("Error")
        }
        return true
    }
    
    
    var currentMin: Int?
    
    while currentLeftIndex < one.count && currentMiddleIndex < two.count && currentRightIndex < three.count {
        let result = computDistance(oneIndex: currentLeftIndex, twoIndex: currentMiddleIndex, threeIndex: currentRightIndex)
        if let minValue = currentMin {
            currentMin = min(minValue, result.max)
        } else {
            currentMin = result.max
        }
        let selectedOne = selected(for: result.location.0.0, index: result.location.0.1)
        let selectedTwo = selected(for: result.location.1.0, index: result.location.1.1)
        if selectedOne < selectedTwo {
            if updateIndex(location: result.location.0.0, index: result.location.0.1) {
                continue
            } else {
                break
            }
        } else {
            if updateIndex(location: result.location.1.0, index: result.location.1.1) {
                continue
            } else {
                break
            }
        }
    }
    
    return currentMin
}

/// 找到升序数组中绝对值最小的元素
/// - Parameter source: 升序数组
/// - Returns: 绝对值最小的元素
func findMinAbs(from source: [Int]) -> Int? {
    guard source.count >= 1 else {
        return nil
    }
    
    func bianrySearch(for element: Int) -> Int {
        var start = 0
        var end = source.count - 1
        
        while start <= end {
            let middle = start + (end - start) / 2
            if source[middle] > element {
                end = middle - 1
            } else if source[middle] < element {
                start = middle + 1
            } else {
                return middle
            }
        }
        return start
    }
    
    let index = bianrySearch(for: 0)
    if index == source.count {
        return abs(source[index - 1])
    } else if index == 0 {
        return source[0]
    } else {
        return min(abs(source[index - 1]), source[index])
    }
}

/// 整数数组中可以有正数负数0，求所有子数组的最大和
/// - Parameter source: 数组
/// - Returns: 最大和
func findMaxContinueSum(for source: [Int]) -> (sum: Int, start: Int, end: Int)? {
    guard source.count > 0 else {
        return nil
    }
    var maxValue = source[0]
    var maxStart = 0
    var maxEnd = 0
    var currentStart = 0
    var currentEnd = 0
    var currentValue = 0
    var isIgnore = false
    for (index, element) in source.enumerated() {
        currentValue += element
        if isIgnore {
            currentStart = index
        }
        currentEnd = index
        if maxValue < currentValue {
            maxEnd = currentEnd
            maxStart = currentStart
            maxValue = currentValue
        }
        if currentValue < 0 {
            currentValue = 0
            isIgnore = true
        } else {
            isIgnore = false
        }
    }
    
    return (maxValue, maxStart, maxEnd)
}


/// 数组中有一些数字，只有三个数字出现了1次，其余的都出现了偶数次，求那三个数字中的任意一个数字
/// - Parameter source: 数组
/// - Returns: 数字
func findOnceAppeare(for source: [Int]) -> Int {
    guard source.count >= 3 else {
        fatalError("Error")
    }
    
    var xorSum = 0
    for element in source {
        xorSum = xorSum ^ element
    }
    
    var count = 0
    let intSize = MemoryLayout<Int>.stride
    while count < intSize {
        let flag = xorSum & 1
        var xor1Sum = 0
        var xor0Sum = 0
        for element in source {
            if (element >> count) & 1 == 0 {
                xor0Sum = xor0Sum ^ element
            } else {
                xor1Sum = xor1Sum ^ element
            }
        }
        if flag == 1 {
            if xor0Sum != 0 {
                return xor0Sum ^ xorSum
            }
        } else {
            if xor1Sum != 0 {
                return xor1Sum ^ xorSum
            }
        }
        count += 1
    }
    fatalError("Error!")
}


/// 找出数组中的中位数
/// - Parameter source: 数组
/// - Returns: 中位数
func findMiddleNumber(for source: [Int]) -> Double {
    guard !source.isEmpty else {
        fatalError("Error")
    }
    var copySource = source
    
    func quickSort(start: Int, end: Int, middle: Int) {
        let first = copySource[start]
        var currentHeade = start + 1
        var currentTrail = end
        while currentHeade <= currentTrail {
            while currentHeade <= currentTrail && copySource[currentHeade] <= first {
                currentHeade += 1
            }
            while currentHeade <= currentTrail && copySource[currentTrail] > first {
                currentTrail -= 1
            }
            if currentHeade <= currentTrail {
                let temp = copySource[currentHeade]
                copySource[currentHeade] = copySource[currentTrail]
                copySource[currentTrail] = temp
            }
        }
        if currentTrail > start {
            copySource[start] = copySource[currentTrail]
            copySource[currentTrail] = first
        }
        if currentTrail == middle {
            return
        } else if currentTrail < middle {
            quickSort(start: currentTrail + 1, end: end, middle: middle)
        } else if currentTrail > middle {
            quickSort(start: start, end: currentTrail - 1, middle: middle)
        }
    }
    
    if copySource.count % 2 == 0 {
        let middle = (copySource.count - 1) / 2
        quickSort(start: 0, end: copySource.count - 1, middle: middle)
        quickSort(start: middle + 1, end: source.count - 1, middle: middle + 1)
        return Double(copySource[middle] + copySource[middle + 1]) / 2
    } else {
        let middle = (copySource.count - 1) / 2
        quickSort(start: 0, end: copySource.count - 1, middle: middle)
        return Double(copySource[middle])
    }
}

/// 求出数组的所有非空子集
/// - Parameter source: 数组
/// - Returns: 所有的非空子集
func findNonEmptySubSet<T>(for source: [T]) -> [[T]] {
    var results: [[T]] = []
    
    for element in source {
        results = results + results.map{
            $0 + [element]
        }
        results.append([element])
    }
    
    return results
}

/// 对数组进行循环右移动，要求时间O(n)，空间上只允许使用两个附加变量
/// - Parameters:
///   - source: 数组
///   - location: 循环移位的位数
/// - Returns: 循环移位后的新数组
func cyclicRightShift<T>(for source: [T], location: Int) -> [T] {
    var copySource = source
    let index = location % source.count
    if index == 0 {
        return source
    }
    func reverse(left: Int, right: Int) {
        var current = left // 这是第一个附加变量
        while current < right + left - current {
            let temp = copySource[current] // 这是第二个附加变量
            copySource[current] = copySource[right + left - current]
            copySource[right + left - current] = temp
            current += 1
        }
    }
    
    reverse(left: 0, right: index - 1)
    reverse(left: index, right: source.count - 1)
    reverse(left: 0, right: source.count - 1)
    return copySource
}

/// 在从左到右从上到下递增的一个二维数组中，判断给定的数字是否在数组中
/// - Parameters:
///   - source: 二维数组
///   - element: 给定的数字
/// - Returns: 是否存在
func searchInTwoDimensionalArray<T: Comparable>(for source: [[T]], element: T) -> Bool {
    var currentX = 0
    var currentY = source.count - 1
    
    while currentX <= source[0].count - 1 && currentY >= 0 {
        let current = source[currentY][currentX]
        if current == element {
            return true
        } else if current > element {
            currentY -= 1
        } else {
            currentX += 1
        }
    }
    
    return false
}


/// 数轴上一系列点，一根长k的木棍最多可以覆盖多少个点
/// - Parameters:
///   - source: 数轴上面的点
///   - length: 木棍长度
/// - Returns: 最多覆盖的点数
func coverageTheMostPoint<T: Comparable & AdditiveArithmetic>(for source: [T], stick length: T) -> (length: Int, coverage: [T]) {
    guard source.count >= 2 else {
        return (source.count, source)
    }
    var maxPoint = 1
    var maxStart = 0
    var start = 0
    var end = 1
    
    while end < source.count {
        if source[end] - source[start] <= length {
            if end - start + 1 > maxPoint {
                maxPoint = end - start + 1
                maxStart = start
            }
            end += 1
        } else {
            while start < end {
                start += 1
                if source[end] - source[start] <= length {
                    break
                }
            }
        }
    }
    
    return (maxPoint, Array(source[maxStart ... (maxStart + maxPoint - 1)]))
}

/// 判断请求是否可以在指定空间内被处理
/// - Parameters:
///   - requests: 请求所消耗的资源信息，(请求编号，计算时所需空间R，存放结果所放空间O),R >= O
///   - space: 指定的空间大小
/// - Returns: 是否可以计算所有请求并保存所有结果,如果可以则按处理顺序返回请求编号，否则为空数组
func allRequestsCanBeProcessed<T: Comparable & AdditiveArithmetic>(for requests: [(Int, T, T)], in space: T) -> [Int] {
    let sortRequests = requests.sorted(by: {
        ($0.1 - $0.2) > ($1.1 - $1.2)
    })
    var remain = space
    var currentCount = 0
    while currentCount < sortRequests.count && remain >= sortRequests[currentCount].1 {
        remain -= sortRequests[currentCount].2
        currentCount += 1
    }
    
    if currentCount == sortRequests.count {
        return sortRequests.map{
            $0.0
        }
    } else {
        return []
    }
}

/// 根据数组A构造B，B[i] = A[0] * ... *A[n-1] / A[i]，构造过程不允许使用除法，O1空间复杂度，
/// On时间复杂度，除了遍历计数器和数组元素访问A[i]B[i]外不允许使用任何其他变量
/// - Parameter source: 初始数组
/// - Returns: 新数组
func makeSpecialArray<T: Numeric>(from source: [T]) -> [T] {
    guard source.count >= 1 else {
        return []
    }
    var results = Array<T>(repeating: source[0], count: source.count)
    var count = 0
    while count < source.count - 1 {
        if count == 0 {
            results[count + 1] = source[count]
        } else {
            results[count + 1] = source[count] * results[count]
        }
        count += 1
    }
    count = source.count - 1
    while count > 0 {
        if count == source.count - 1 {
            results[0] = source[count]
        } else {
            results[count] = results[count] * results[0]
            results[0] = source[count] * results[0]
        }
        count -= 1
    }
    return results
}

/// 多个矩阵相乘，找出操作所需乘法数量最小的数量
/// - Parameter source: 矩阵序列
/// - Returns: 最小的乘法数量
func matrixChainOrder(for source: [Int]) -> Int {
    guard source.count >= 3 else {
        return 0
    }
    var distances = Array<[Int]>.init(repeating: Array<Int>.init(repeating: -1, count: source.count - 1), count: source.count - 1)
    for index in 0 ..< source.count - 1 {
        distances[index][index] = 0
    }
    
    for chainLength in 2 ... (source.count - 1) {
        for start in 0 ... (source.count - chainLength - 1) {
            for middle in start ..< (start + chainLength - 1) {
                let distance = distances[start][middle] + distances[middle + 1][start + chainLength - 1] + source[start] * source[middle + 1] * source[start + chainLength]
                if distances[start][start + chainLength - 1] == -1 {
                    distances[start][start + chainLength - 1] = distance
                } else if distance < distances[start][start + chainLength - 1] {
                    distances[start][start + chainLength - 1] = distance
                }
            }
        }
    }
    
    return distances[0][source.count - 2]
}


/// 走迷宫，每一步只能向下或者向右，从左上方到右下方，每一个1表示有路，0表示无路
/// - Parameter sources: 迷宫
/// - Returns: 路径数组
func sloveMaze(for sources: [[Int]]) -> [(Int, Int)] {
    var copySource = sources
    var traceStack = [(-1, (0, 0))]
    let destionPoint = (copySource.count - 1, copySource[0].count - 1)
    
    while !traceStack.isEmpty {
        if traceStack.last!.1 == destionPoint {
            break
        }
        let current = traceStack.last!.1
        copySource[current.0][current.1] = 0
        if current.0 + 1 <= copySource.count - 1 && copySource[current.0 + 1][current.1] == 1 {
            traceStack.append((traceStack.count - 1,(current.0 + 1, current.1)))
            continue
        }
        if current.1 + 1 <= copySource[0].count - 1 && copySource[current.0][current.1 + 1] == 1 {
            traceStack.append((traceStack.count - 1,(current.0, current.1 + 1)))
            continue
        }
        traceStack.removeLast()
        
    }
    if traceStack.isEmpty {
        return []
    }
    var traces: [(Int, Int)] = []
    var currentIndex = traceStack.count - 1
    while currentIndex != 0 {
        traces.append(traceStack[currentIndex].1)
        currentIndex = traceStack[currentIndex].0
    }
    traces.append(traceStack[0].1)
    traces.reverse()
    
    return traces
}


/// 三个非递减排序的数组，找出其中所有的公共元素
/// - Parameters:
///   - first: 第一个数组
///   - second: 第二个数组
///   - third: 第三个数组
/// - Returns: 公共元素
func findCommonElement<T: Comparable & Hashable>(from first: [T], second: [T], third: [T]) -> [T] {
    guard first.count >= 1 && second.count >= 1 && third.count >= 1 else {
        return []
    }
    var commonElements: Set<T> = []
    var firstIndex = 0
    var secondIndex = 0
    var thirdIndex = 0
    
    while firstIndex < first.count && secondIndex < second.count && thirdIndex < third.count {
        if first[firstIndex] < second[secondIndex] && first[firstIndex] < third[thirdIndex] {
            firstIndex += 1
            continue
        }
        
        if second[secondIndex] < first[firstIndex] && second[secondIndex] < third[thirdIndex] {
            secondIndex += 1
            continue
        }
        
        if third[thirdIndex] < second[secondIndex] && third[thirdIndex] < first[firstIndex] {
            thirdIndex += 1
            continue
        }
        
        if first[firstIndex] == second[secondIndex] {
            if first[firstIndex] == third[thirdIndex] {
                commonElements.insert(first[firstIndex])
                firstIndex += 1
                secondIndex += 1
                thirdIndex += 1
                continue
            } else if first[firstIndex] < third[thirdIndex] {
                firstIndex += 1
                secondIndex += 1
                continue
            } else {
                thirdIndex += 1
                continue
            }
        } else if first[firstIndex] == third[thirdIndex] {
            if first[firstIndex] < second[secondIndex] {
                firstIndex += 1
                thirdIndex += 1
                continue
            } else if first[firstIndex] > second[secondIndex] {
                secondIndex += 1
                continue
            } else {
                fatalError("Error")
            }
        } else if second[secondIndex] == third[thirdIndex] {
            if second[secondIndex] < first[firstIndex] {
                secondIndex += 1
                thirdIndex += 1
                continue
            } else if second[secondIndex] > first[firstIndex] {
                firstIndex += 1
                continue
            } else {
                fatalError("Error")
            }
        } else {
            fatalError("Error")
        }
    }
    
    return Array(commonElements)
}

func sortLargeRepeatNumber<T: Comparable & Hashable>(for source: [T]) -> [T] {
    var sourceMap: [T: Int] = [:]
    for element in source {
        if let count = sourceMap[element] {
            sourceMap[element] = count + 1
        } else {
            sourceMap[element] = 1
        }
    }
    
    var sourceSort = sourceMap.map{
        $0.key
    }
    
    func adjustHeap(start: Int, end: Int) {
        var parent = start
        var son = 2 * parent + 1
        while son <= end {
            if son < end {
                if sourceSort[son + 1] > sourceSort[son] {
                    son = son + 1
                }
            }
            if sourceSort[parent] < sourceSort[son] {
                let temp = sourceSort[parent]
                sourceSort[parent] = sourceSort[son]
                sourceSort[son] = temp
                
                parent = son
                son = 2 * parent + 1
            } else {
                break
            }
        }
    }
    
    func makeHeap() {
        for start in Array(0 ... (sourceSort.count - 2) / 2).reversed() {
            adjustHeap(start: start, end: sourceSort.count - 1)
        }
    }
    
    func heapSort() {
        guard sourceSort.count >= 2 else {
            return
        }
        
        makeHeap()
        
        for end in Array(0 ... sourceSort.count - 2).reversed() {
            let temp = sourceSort[0]
            sourceSort[0] = sourceSort[end + 1]
            sourceSort[end + 1] = temp
            
            adjustHeap(start: 0, end: end)
        }
    }
    
    heapSort()
    
    var result: [T] = []
    for element in sourceSort {
        let count = sourceMap[element]!
        result.append(contentsOf: Array.init(repeating: element, count: count))
    }
    
    return result
}
