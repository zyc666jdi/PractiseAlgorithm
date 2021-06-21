//
//  PQueue.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/3/18.
//  Copyright © 2021 List. All rights reserved.
//

import UIKit

// 高性能队列的实现
struct PQueue<T> { // ✅
    private var array:[T?] = Array.init(repeating: nil, count: 20) // 一段连续的内存的数组
    private var index:Int = 0 // 队列首部的index
    private(set) var cotentSize = 0 // 队列的长度
    
    // 入队列
    mutating func pushToBack(element:T?){
        self.array[(index + cotentSize ) % self.array.count]  = element
        cotentSize += 1
    }
    
    // 出队列
    mutating func popFromFront()->T?{
        if cotentSize == 0 {
            return nil
        }
        let result = self.array[index]
        self.array[(index ) % self.array.count] = nil
        cotentSize -= 1
        if index == array.count - 1{
            index = 0
        } else {
            index += 1
        }
        return result
    }
    
    // 队列头部的元素
    mutating func peekFromFront()->T?{
        if cotentSize == 0 {
            return nil
        }
        let result = self.array[index]
        return result
    }
    
    // 队列尺寸
    func size() -> Int{
        return cotentSize
    }
    
    // 队列是否为空
    func isEmpty() -> Bool{
        return self.size() > 0 ? false: true
    }
    
}
    
// 用栈实现队列,性能较差
class PxQueue<T>: NSObject { // ✅
    private var inStack:[T] = []
    private var outStack:[T] = []
    
    // 入队列
    func pushToBack(element:T){
        inStack.append(element)
    }
    
    // 出队列
    func popFromFront()->T?{
        if outStack.count == 0 {
            while inStack.count > 0 {
                if let last = inStack.popLast() {
                    outStack.append(last)
                }
            }
        }
        return outStack.popLast()
    }
    
    // 出队列
    func peekFromFront()->T?{
        if outStack.count == 0 {
            while inStack.count > 0 {
                if let last = inStack.popLast() {
                    outStack.append(last)
                }
            }
        }
        return outStack.last
    }
    
    // 队列尺寸
    func size() -> Int{
        return (inStack.count + outStack.count)
    }
    
    // 队列是否为空
    func isEmpty() -> Bool{
        return self.size() > 0 ? false: true
    }
}
