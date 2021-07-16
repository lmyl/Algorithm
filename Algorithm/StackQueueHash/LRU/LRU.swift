//
//  LRU.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/16.
//

import Foundation

class Page: Identifiable {
    let uuid: Int
    
    init(uuid: Int) {
        self.uuid = uuid
    }
    
    var id: Int {
        uuid
    }
}

/// 页面替换的LRU算法
class LRUCache<T: Identifiable> {
    private let maxSize: Int
    
    private var headeQueue: DoubleDirectListNode<T>?
    private var trailQueue: DoubleDirectListNode<T>?
    private var currentSize: Int = 0
    
    private var cacheMap: [T.ID: DoubleDirectListNode<T>] = [:]
    
    init(maxSize: Int) {
        self.maxSize = maxSize
    }
    
    func push(content: T) {
        guard fetch(id: content.id) == nil else {
            return
        }
        let newNode = DoubleDirectListNode(value: content)
        setCache(id: content.id, content: newNode)
        push(content: newNode)
    }
    
    private func push(content: DoubleDirectListNode<T>) {
        while currentSize >= maxSize {
            _ = deQueue()
        }
        if let trail = trailQueue {
            trail.next = content
            content.previous = trail
            trailQueue = content
        } else {
            trailQueue = content
            headeQueue = content
        }
        currentSize += 1
        
    }
    
    private func deQueue() -> DoubleDirectListNode<T>? {
        if let heade = headeQueue {
            headeQueue = heade.next
            if let nextHead = headeQueue {
                nextHead.previous = nil
                heade.next = nil
            } else {
                trailQueue = nil
            }
            clearCache(id: heade.value.id)
            currentSize -= 1
            return heade
        } else {
            return nil
        }
    }
    
    private func query(id: T.ID) -> DoubleDirectListNode<T>? {
        cacheMap[id]
    }
    
    private func setCache(id: T.ID, content: DoubleDirectListNode<T>) {
        cacheMap[id] = content
    }
    
    private func clearCache(id: T.ID) {
        cacheMap[id] = nil
    }
    
    func fetch(id: T.ID) -> T? {
        guard let node = query(id: id) else {
            return nil
        }
        if let previousNode = node.previous, let nextNode = node.next {
            previousNode.next = nextNode
            nextNode.previous = previousNode
            node.next = nil
            node.previous = nil
        } else if let previousNode = node.previous {
            previousNode.next = nil
            node.previous = nil
            trailQueue = previousNode
        } else if let nextNode = node.next {
            headeQueue = nextNode
            node.next = nil
        } else {
            trailQueue = nil
            headeQueue = nil
        }
        currentSize -= 1
        
        push(content: node)
        
        return node.value
    }
}



