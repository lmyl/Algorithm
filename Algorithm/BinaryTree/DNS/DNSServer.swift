//
//  DNSServer.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/20.
//

import Foundation

class DNSDomainNode {
    var childsNodes: [Character : DNSDomainNode] = [:]
    var domain: String?
    
    func getNode(for id: Character) -> DNSDomainNode? {
        childsNodes[id]
    }
    
    func setNode(for id: Character, to: DNSDomainNode?) {
        childsNodes[id] = to
    }
    
    var isEmpty: Bool {
        childsNodes.isEmpty && domain == nil
    }
}

/// 实现IP地址至域名的哈希映射，采用了哈希树
class DNSServer {
    private var searchRoot = DNSDomainNode()
    
    private var numberSet = Set<Character>(["0","1","2","3","4","5","6","7","8","9"])
    private var pointsSet = Set<Character>(["."])
    
    private func sum(for source: [Character]) -> Int {
        source.map{
            Int(String($0))!
        }.reduce(0, {
            $0 * 10 + $1
        })
    }
    
    private func verify(for source: [Character]) -> Bool {
        if sum(for: source) > 255 {
            return false
        }
        if source.count >= 2 && source[0] == "0" && source[1] == "0" {
            return false
        }
        return true
    }
    
    func query(for ip: String) -> String? {
        var continueNumberCharacter: [Character] = []
        var totalPointCount = 0
        
        var currentNode = searchRoot
        for char in ip.unicodeScalars {
            let character = Character(char)
            if numberSet.contains(character) {
                if continueNumberCharacter.count == 3 {
                    return nil
                } else {
                    continueNumberCharacter.append(character)
                    if !verify(for: continueNumberCharacter) {
                        return nil
                    }
                    if let node = currentNode.getNode(for: character) {
                        currentNode = node
                    } else {
                        return nil
                    }
                }
            } else if pointsSet.contains(character) {
                if continueNumberCharacter.count == 0 || totalPointCount == 3 {
                    return nil
                } else {
                    if let node = currentNode.getNode(for: character) {
                        continueNumberCharacter = []
                        totalPointCount += 1
                        currentNode = node
                    } else {
                        return nil
                    }
                }
            } else {
                return nil
            }
        }
        
        if totalPointCount == 3 {
            return currentNode.domain
        } else {
            return nil
        }
    }
    
    func set(ip: String, to domain: String) -> Bool {
        var continueNumberCharacter: [Character] = []
        var totalPointCount = 0
        
        var currentNode = searchRoot
        for char in ip.unicodeScalars {
            let character = Character(char)
            if numberSet.contains(character) {
                if continueNumberCharacter.count == 3 {
                    return false
                } else {
                    continueNumberCharacter.append(character)
                    if !verify(for: continueNumberCharacter) {
                        return false
                    }
                    if let node = currentNode.getNode(for: character) {
                        currentNode = node
                    } else {
                        let node = DNSDomainNode()
                        currentNode.setNode(for: character, to: node)
                        currentNode = node
                    }
                }
            } else if pointsSet.contains(character) {
                if continueNumberCharacter.count == 0 || totalPointCount == 3 {
                    return false
                } else {
                    if let node = currentNode.getNode(for: character) {
                        continueNumberCharacter = []
                        totalPointCount += 1
                        currentNode = node
                    } else {
                        let node = DNSDomainNode()
                        currentNode.setNode(for: character, to: node)
                        continueNumberCharacter = []
                        totalPointCount += 1
                        currentNode = node
                    }
                }
            } else {
                return false
            }
        }
        
        if currentNode === searchRoot {
            return false
        }
        
        if totalPointCount != 3 {
            return false
        }
        
        currentNode.domain = domain
        return true
    }
    
    func clear(ip: String) -> Bool {
        var continueNumberCharacter: [Character] = []
        var totalPointCount = 0
        
        var traceNodes: [(Character?, DNSDomainNode)] = [(nil, searchRoot)]
        var currentNode = searchRoot
        for char in ip.unicodeScalars {
            let character = Character(char)
            if numberSet.contains(character) {
                if continueNumberCharacter.count == 3 {
                    return false
                } else {
                    continueNumberCharacter.append(character)
                    if !verify(for: continueNumberCharacter) {
                        return false
                    }
                    if let node = currentNode.getNode(for: character) {
                        traceNodes.append((character, node))
                        currentNode = node
                    } else {
                        return true
                    }
                }
            } else if pointsSet.contains(character) {
                if continueNumberCharacter.count == 0 || totalPointCount == 3 {
                    return false
                } else {
                    if let node = currentNode.getNode(for: character) {
                        continueNumberCharacter = []
                        totalPointCount += 1
                        traceNodes.append((character, node))
                        currentNode = node
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
        
        if currentNode === searchRoot {
            return false
        }
        if totalPointCount != 3 {
            return false
        }
        var traceCount = traceNodes.count
        if traceCount <= 1 {
            return false
        }
        
        while traceCount >= 2 {
            let nowNode = traceNodes[traceCount - 1]
            let parentNode = traceNodes[traceCount - 2]
            parentNode.1.setNode(for: nowNode.0!, to: nil)
            if !parentNode.1.isEmpty {
                return true
            }
            traceCount -= 1
        }
        return true
    }
}
