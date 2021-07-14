//
//  ListSolution.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/12.
//

import Foundation

/// 不带头节点的单链表逆序
/// - Parameter list: 链表第一个节点
func reverse<T>(for list: ListNode<T>?) -> ListNode<T>? {
    guard var first = list else {
        return nil
    }
    
    var nextNode = first.next
    first.next = nil
    
    while let next = nextNode {
        nextNode = next.next
        next.next = first
        first = next
    }
    
    return first
}

/// 不带头节点的单链表逆序输出
/// - Parameter list: 链表第一个节点
func reversePrint<T>(for list: ListNode<T>?) -> String {
    
    guard let list = list else {
        return ""
    }
    
    func reverseNextPrint<T>(for current: ListNode<T>) -> String {
        if let next = current.next {
            return reverseNextPrint(for: next) + "\(current.value),"
        } else {
            return "\(current.value),"
        }
    }
    
    var result = ""
    if let next = list.next {
        result = reverseNextPrint(for: next)
    }
    
    return result + "\(list.value)"
}


/// 删除链表重复元素
/// - Parameter list: 链表第一个元素
func removeRepeate<T: Hashable>(for list: ListNode<T>?) {
    var values: Set<T> = []
    
    guard var front = list else {
        return
    }
    
    var nextNode = front.next
    values.insert(front.value)
    
    while let node = nextNode {
        if values.contains(node.value) {
            nextNode = node.next
            front.next = nextNode
        } else {
            values.insert(node.value)
            front = node
            nextNode = node.next
        }
    }
    
}

/// 删除有序链表中重复的元素
/// - Parameter sortList: 链表第一个元素
func removeRepeate<T: Equatable>(in sortList: ListNode<T>?) {
    guard var front = sortList else {
        return
    }
    
    var nextNode = front.next
    while let next = nextNode {
        if next.value != front.value {
            front = next
            nextNode = next.next
        } else {
            nextNode = next.next
            front.next = nextNode
        }
    }
}

/// 对两个链表表示的整数求和，链表从数字的个位开始依次表示各个位
/// - Parameters:
///   - first: 第一个链表
///   - second: 第二个链表
/// - Returns: 求和链表
func sumIntergateList(first: ListNode<Int>, second: ListNode<Int>) -> ListNode<Int> {
    var sum = first.value + second.value
    var remain = sum % 10
    var front = sum / 10
    let result = ListNode(value: remain)
    var trail = result
    
    var currentFirst = first.next
    var currentScond = second.next
    
    while !(currentFirst == nil && currentScond == nil) {
        if let currentF = currentFirst, let currentS = currentScond {
            sum = currentF.value + currentS.value + front
            currentFirst = currentF.next
            currentScond = currentS.next
        } else if let currentF = currentFirst {
            sum = currentF.value + front
            currentFirst = currentF.next
        } else if let currentS = currentScond {
            sum = currentS.value + front
            currentScond = currentS.next
        }
        
        remain = sum % 10
        front = sum / 10
        let new = ListNode(value: remain)
        trail.next = new
        trail = new
    }
    
    if front > 0 {
        let new = ListNode(value: front)
        trail.next = new
        trail = new
    }
    
    return result
}

/// 对链表进行重排序，将链表对折后合并
/// - Parameter list: 链表的第一个元素
func rearrange<T>(for list: ListNode<T>?) {
    var slow = list
    guard slow != nil else {
        return
    }
    
    var quick = slow
    
    while let next = quick?.next {
        if let nextToNext = next.next {
            quick = nextToNext
            slow = slow?.next
        } else {
            break
        }
    }
    
    let middle = slow?.next
    slow?.next = nil
    
    let anotherList = reverse(for: middle)
    
    var currentL = list
    var currentR = anotherList
    while currentL != nil, currentR != nil {
        let nextL = currentL?.next
        let nextR = currentR?.next
        currentL?.next = currentR
        currentR?.next = nextL
        currentL = nextL
        currentR = nextR
    }
}

func middle<T>(for list: ListNode<T>?) -> ListNode<T>? {
    var slow = list
    guard slow != nil else {
        return nil
    }
    
    var quick = slow
    
    while let next = quick?.next {
        if let nextToNext = next.next {
            quick = nextToNext
            slow = slow?.next
        } else {
            break
        }
    }
    
    return slow
}

/// 寻找链表中最后第k个元素
/// - Parameters:
///   - list: 链表的第一个元素
///   - rank: 序数K
/// - Returns: 倒数第k个元素
func last<T>(for list: ListNode<T>?, rank: Int) -> T? {
    var distance = 0
    var slow = list
    var quick = slow
    
    while quick != nil {
        if distance < rank {
            quick = quick?.next
            distance += 1
        } else {
            quick = quick?.next
            slow = slow?.next
        }
    }
    
    if distance < rank {
        return nil
    } else {
        return slow?.value
    }
}

/// 将链表向右旋转
/// - Parameters:
///   - list: 链表的第一个元素
///   - rank: 旋转点
/// - Returns: 旋转后的链表
func rotateRight<T>(for list: ListNode<T>?, rank: Int) -> ListNode<T>? {
    var distance = 0
    var slow = list
    var quick = slow
    
    while quick?.next != nil {
        if distance < rank {
            quick = quick?.next
            distance += 1
        } else {
            quick = quick?.next
            slow = slow?.next
        }
    }
    
    if distance < rank {
        return list
    }
    
    let next = slow?.next
    slow?.next = nil
    quick?.next = list
    
    return next
}


/// 单链表是否有环
/// - Parameter list: 链表的第一个元素
/// - Returns: `true` 表示有环， `false`表示没有
func isRing<T>(for list: ListNode<T>?) -> Bool {
    var slow = list
    guard slow != nil else {
        return false
    }
    
    var quick = slow?.next
    
    while quick != nil {
        if quick === slow {
            return true
        }
        quick = quick?.next?.next
        slow = slow?.next
    }
    
    return false
}

/// 单链表是否有环
/// - Parameter list: 链表的第一个元素
/// - Returns: 表示环入口的位置
func isRing<T>(for list: ListNode<T>?) -> ListNode<T>? {
    var slow = list
    guard slow != nil else {
        return nil
    }
    
    var quick = slow
    
    while quick != nil {
        quick = quick?.next?.next
        slow = slow?.next
        if quick === slow {
            break
        }
    }
    
    if quick == nil {
        return nil
    }
    
    var standard = list
    
    while standard !== quick {
        standard = standard?.next
        quick = quick?.next
    }
    
    return quick
}

/// 翻转相邻元素
/// - Parameter list: 链表的第一个元素
/// - Returns: 新的链表
func flipAdjacentElement<T>(for list: ListNode<T>?) -> ListNode<T>? {
    guard list != nil else {
        return nil
    }
    var current = list
    let next = list?.next
    
    if next == nil {
        return list
    }
    
    let first = next
    var nextGroup = next?.next
    
    next?.next = current
    current?.next = nil
    
    while nextGroup != nil {
        if let nextToNext = nextGroup?.next {
            let nextToGroup = nextToNext.next
            nextToNext.next = nextGroup
            nextGroup?.next = nil
            current?.next = nextToNext
            current = nextGroup
            nextGroup = nextToGroup
        } else {
            current?.next = nextGroup
            current = nextGroup
            break
        }
    }
    
    return first
}

/// 将链表以K个结点为一组进行翻转，不足K的组不进行翻转
/// - Parameters:
///   - list: 需要翻转的链表
///   - groupCapcity: 组的大小
/// - Returns: 翻转后的链表
func flipAdjacentElement<T>(for list: ListNode<T>?, groupCapcity: Int) -> ListNode<T>? {
    if list == nil {
        return nil
    }

    var left = list
    var right = left
    var groupSize = 1
    var isFirstGroup = true
    var first: ListNode<T>?
    var lastTrail: ListNode<T>?
    
    while right != nil {
        if groupSize < groupCapcity {
            right = right?.next
            groupSize += 1
        } else {
            let nextGroup = right?.next
            right?.next = nil
            let reverseList = reverse(for: left)
            if isFirstGroup {
                isFirstGroup.toggle()
                first = reverseList
            } else {
                lastTrail?.next = reverseList
            }
            lastTrail = left
            left = nextGroup
            right = nextGroup
            groupSize = 1
        }
    }
    
    if isFirstGroup {
        return list
    } else if left != nil {
        lastTrail?.next = left
    }
    
    return first
}

/// 合并两个升序链表
/// - Parameters:
///   - first: 升序链表
///   - second: 升序链表
/// - Returns: 合并后的升序链表
func combineAscendingOrderList<T: Comparable>(for first: ListNode<T>?, and second: ListNode<T>?) -> ListNode<T>? {
    var left = first
    var right = second
    
    var first: ListNode<T>?
    var trail: ListNode<T>?
    
    func selectNode(for node: ListNode<T>) {
        node.next = nil
        if first == nil {
            first = node
            trail = node
        } else {
            trail?.next = node
        }
        trail = node
    }
    
    while let leftNode = left, let rightNode = right {
        if leftNode.value < rightNode.value {
            left = leftNode.next
            selectNode(for: leftNode)
        } else {
            right = rightNode.next
            selectNode(for: rightNode)
        }
    }
    
    while let leftNode = left {
        left = leftNode.next
        selectNode(for: leftNode)
    }
    
    while let rightNode = right {
        right = rightNode.next
        selectNode(for: rightNode)
    }
    
    return first
}

/// 删除链表中的指定结点
/// - Parameter node: 指定结点
/// - Returns: 是否可以删除此结点
func removeNodeFromList<T>(for node: ListNode<T>?) -> Bool {
    guard let node = node, let next = node.next else {
        return false
    }
    node.value = next.value
    node.next = next.next
    return true
}

/// 在链表指定结点前插入新的结点
/// - Parameters:
///   - new: 新的结点
///   - before: 指定结点
func insertNodeBeforeNodeInList<T>(for new: ListNode<T>, before: ListNode<T>) {
    let temp = before.value
    before.value = new.value
    new.value = temp
    new.next = before.next
    before.next = new
}

/// 判断两个单链表是否相交，链表均不带环
/// - Parameters:
///   - first: 单链表
///   - second: 单链表
/// - Returns: `true`相交，`false`不相交
func isCross<T>(for first: ListNode<T>?, and second: ListNode<T>?) -> Bool {
    if first == nil || second == nil {
        return false
    }
    
    var left = first
    var right = second
    
    while left?.next != nil {
        left = left?.next
    }
    
    while right?.next != nil {
        right = right?.next
    }
    
    if left === right {
        return true
    } else {
        return false
    }
}

/// 判断两个单环的单链表是否相交，两个链表至少一个带环
/// - Parameters:
///   - first: 单链表
///   - second: 单链表
/// - Returns: `true`相交，`false`不相交
func isCrossWithRing<T>(for first: ListNode<T>?, and second: ListNode<T>?) -> Bool {
    var quick = first
    var slow = first
    while quick != nil {
        quick = quick?.next?.next
        slow = slow?.next
        if quick === slow {
            break
        }
    }
    
    if quick == nil {
        return false
    }
    
    var quickSecond = second
    var slowSecond = second
    while quickSecond != nil {
        quickSecond = quickSecond?.next?.next
        slowSecond = slowSecond?.next
        if quickSecond === slowSecond {
            break
        }
    }
    
    if quickSecond == nil {
        return false
    }
    
    var standard = quick
    
    repeat  {
        if standard === quickSecond {
            return true
        }
        standard = standard?.next
    } while standard !== quick
    
    return false
    
}

/// 沿着链表next指针遍历是一个普通单链表，但是mutationsNext指针是随机指向其他结点的指针，翻转变异链表，要求所有指针反向
/// - Parameter list: 变异链表
/// - Returns: 翻转后的链表
func reverseMutationsList<T>(for list: MutationsListNode<T>?) -> MutationsListNode<T>? {
    if list == nil {
        return nil
    }
    
    var first = list
    var next = first?.next
    first?.next = nil
    
    while next != nil {
        let nextToNext = next?.next
        next?.next = first
        first = next
        next = nextToNext
    }
    
    next = first
    while next != nil {
        let anotherNode = next?.mutationsNext
        anotherNode?.mutationsNext = next
        next = next?.next
    }
    
    return first
}

/// 每个结点有两个指针，可以指向为空，也可以指向其他结点，其指向的结点的值大于此结点，将此异形链表展开成单链表
/// - Parameter list: 异形链表
/// - Returns: 新的单链表
/// - note: 此方法每次读取数组中最小的结点，然后加入此结点的左右两个结点，数组的结构构成一个堆
func flattenSortTreeMutationsList<T: Comparable>(for list: MutationsListNode<T>?) -> ListNode<T>? {
    if list == nil {
        return nil
    }
    var first: ListNode<T>?
    var trail: ListNode<T>?
    var nodeCaches = [list!]
    
    func adjustHeap(start: Int, end: Int) {
        var parent = start
        var son = 2 * start + 1
        
        while son <= end {
            if son + 1 <= end {
                if nodeCaches[son].value > nodeCaches[son + 1].value {
                    son = son + 1
                }
            }
            if nodeCaches[parent].value > nodeCaches[son].value {
                let tempNode = nodeCaches[son]
                nodeCaches[son] = nodeCaches[parent]
                nodeCaches[parent] = tempNode
                parent = son
                son = 2 * parent + 1
            } else {
                break
            }
        }
    }
    
    func fetchMinElement() -> MutationsListNode<T> {
        let minElement = nodeCaches[0]
        let count = nodeCaches.count
        if count <= 1 {
            nodeCaches = []
        } else {
            let last = nodeCaches[count - 1]
            nodeCaches[0] = last
            nodeCaches.removeLast()
            adjustHeap(start: 0, end: count - 2)
        }
        
        return minElement
    }
    
    func append(element: MutationsListNode<T>) {
        nodeCaches.append(element)
        let end = nodeCaches.count - 1
        var son = end
        var parent = (son - 1) / 2
        
        while son >= 1 {
            if nodeCaches[son].value < nodeCaches[parent].value {
                let tempNode = nodeCaches[son]
                nodeCaches[son] = nodeCaches[parent]
                nodeCaches[parent] = tempNode
                son = parent
                parent = (son - 1) / 2
            } else {
                break
            }
        }
    }
    
    while !nodeCaches.isEmpty {
        let minNode = fetchMinElement()
        let newNode = ListNode(value: minNode.value)
        if first == nil {
            first = newNode
            trail = first
        } else {
            trail?.next = newNode
            trail = newNode
        }
        if let leftNode = minNode.next {
            append(element: leftNode)
        }
        if let rightNode = minNode.mutationsNext {
            append(element: rightNode)
        }
    }
    
    return first
}


/// 有序链表中主链表指向下一个指针，还有一个指针指向此结点头的链表，可以理解结构为在晾晒架上挂长黄瓜，将此异形链表展开成单链表
/// - Parameter list: 异形链表
/// - Returns: 新的单链表
/// - note: 此方法递归的合并链表结点的左右结点，最后展平到mutationsNext指针上
func flattenSortMutationsList<T: Comparable>(for list: MutationsListNode<T>?) -> MutationsListNode<T>? {
    func merge(left: MutationsListNode<T>?, right: MutationsListNode<T>?) -> MutationsListNode<T>? {
        if left == nil && right == nil {
            return nil
        } else if left != nil && right != nil {
            if left!.value < right!.value {
                left!.mutationsNext = merge(left: left!.mutationsNext, right: right!)
                return left
            } else {
                right!.mutationsNext = merge(left: left!, right: right!.mutationsNext)
                return right
            }
        } else if left != nil {
            return left
        } else {
            return right
        }
    }
    
    if list == nil {
        return nil
    }
    
    let flattenPart = flattenSortMutationsList(for: list!.next)
    list?.next = nil
    return merge(left: list, right: flattenPart)
}
