//
//  User.swift
//  Algorithm
//
//  Created by 刘洋 on 2021/7/15.
//

import Foundation

class User: Equatable {
    let uuid: Int
    let name: String
    var location: Int?
    
    init(uuid: Int, name: String) {
        self.name = name
        self.uuid = uuid
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uuid == rhs.uuid && lhs.name == rhs.name
    }
}


/// 排队系统，用户可以知道自己的排名，任何用户可以中途离队，只要有用户离队，就需要更受影响用户的排名
class QueuingSystem {
    private var queue: [User] = []
    
    func enQueue(user: User) {
        user.location = queue.count + 1
        queue.append(user)
    }
    
    func leaveQueue(user: User) {
        if let findIndex = queue.firstIndex(of: user) {
            for index in (findIndex + 1) ..< self.size {
                queue[index].location = queue[index].location! - 1
            }
            queue[findIndex].location = nil
            queue.remove(at: findIndex)
        }
    }
    
    func deQueue() -> User? {
        if let first = queue.first {
            leaveQueue(user: first)
            return first
        } else {
            return nil
        }
    }
    
    private var size: Int {
        queue.count
    }
}
