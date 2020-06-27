//
//  PractiseStackQueue.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/26.
//  Copyright © 2019 List. All rights reserved.
//

import Foundation

//MARK: 用两个栈实现一个队列
class constructQueue<T>: NSObject {
    var stack1:[T] = []
    var stack2:[T] = []
    
    func appentTail(element:T){
        self.stack1.append(element)
    }
    
    func deleteHead<T>() -> T? {
        var head:T? = nil
        if stack2.count == 0 {
            while stack1.count > 0 {
                let element = stack1.popLast()
                stack2.append(element!)
            }
        }
        if stack2.count > 0 {
            head = stack2.popLast() as? T
        }
        return head
    }
    
    func queueCount() -> Int {
        return (stack1.count + stack2.count)
    }
}

//MARK:用两个队列实现一个栈

//class construcStack<T>: NSObject {
//    var queue1:constructQueue = constructQueue()
//    var queue2:constructQueue = constructQueue()
//
//    func push(element:T){
//        queue1.appentTail(element: element)
//    }
//
//    func pop<T>() ->T? {
//        while queue1.queueCount() != 1 {
//            if let element:T = queue1.deleteHead() {
//                queue2.appentTail(element: element as? T)
//            }
//        }
//
//    }
//}
