//
//  PractiseStack.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2020/8/21.
//  Copyright © 2020 List. All rights reserved.
//

import UIKit



class PractiseStack: NSObject {
    
    override init() {
        super.init()
        
        // testMinInStack()
        
    }

}


//MARK: -  在0(1)求栈的最小值
// https://github.com/zhulintao/CodingInterviewChinese2/blob/master/30_MinInStack/StackWithMin.h

func testMinInStack() {
    let stack = Stack<Int>()
    stack.push(3)
    testCaseMinInStack(stack: stack, expect: 3)
    stack.push(4)
    testCaseMinInStack(stack: stack, expect: 3)
    stack.push(2)
    testCaseMinInStack(stack: stack, expect: 2)
    stack.push(3)
    testCaseMinInStack(stack: stack, expect: 2)
    let _ = stack.pop()
    testCaseMinInStack(stack: stack, expect: 2)
    let _ = stack.pop()
    testCaseMinInStack(stack: stack, expect: 3)
    let _ = stack.pop()
    testCaseMinInStack(stack: stack, expect: 3)
    stack.push(0)
    testCaseMinInStack(stack: stack, expect: 0)
}

func testCaseMinInStack<T>(stack:Stack<T>,expect:Int) {
    let min = stack.min() ?? 0
    if min == expect {
        debugPrint("testCaseMinInStack_success",String(expect))
    } else {
        debugPrint("testCaseMinInStack_faliure",String(expect))
    }
}


class Stack<T:BinaryInteger>: NSObject {
    var elements:[T] = []
    var assistArray:[T] = []
    
    func push(_ element:T) {
        elements.append(element)
        if let min = assistArray.last ,element < min {
            assistArray.append(element)
        } else {
            assistArray.append(assistArray.last ?? element)
        }
    }
    
    func pop() -> T? {
        assistArray.removeLast()
        return elements.removeLast()
    }
    
    func min() -> T? {
        return assistArray.last
    }
}
