//
//  PStack.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/3/20.
//  Copyright © 2021 List. All rights reserved.
//

import UIKit

// MARK: - 用队列实现栈
class MyStack {
    var cacheQueue:PQueue<Int> = PQueue<Int>() // 储存queue
    var auxQueue:PQueue<Int> = PQueue<Int>() // 辅助queue
    

    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Push element x onto stack. */
    func push(_ x: Int) {
        auxQueue.pushToBack(element: x)
        while cacheQueue.size() > 0 {
            auxQueue.pushToBack(element: cacheQueue.popFromFront())
        }
        var tmpQueue = cacheQueue
        cacheQueue = auxQueue
        auxQueue = tmpQueue
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        return cacheQueue.popFromFront() ?? 0
    }
    
    /** Get the top element. */
    func top() -> Int {
        return cacheQueue.peekFromFront() ?? 0
    }
    
    /** Returns whether the stack is empty. */
    func empty() -> Bool {
        return cacheQueue.isEmpty()
    }
}
    
