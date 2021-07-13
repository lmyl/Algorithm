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
