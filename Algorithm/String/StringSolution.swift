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
