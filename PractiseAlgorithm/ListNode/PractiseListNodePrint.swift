//
//  PractiseListNodePrint.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/22.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

class ListNode: NSObject {
    var value:Int
    var next:ListNode?
    
    init(value:Int) {
        self.value = value
        self.next = nil
    }
}

class PractiseListNodePrint: NSObject {
    func printListNodeValueBackward(node:ListNode?) { // 倒叙打印链表
        guard let aNode = node else {return}
        var stack = [ListNode]()
        while aNode.next != nil {
            stack.append(aNode)
        }
        for item in stack{
            print(item.value)
        }
    }
    
    func recursionPrintListNodeBackward(node:ListNode?){ // 用递归倒叙打印链表
        guard let aNode = node else {return}
        if aNode.next != nil {
            self.recursionPrintListNodeBackward(node: aNode.next)
        }
        print(aNode.value)
    }
}
