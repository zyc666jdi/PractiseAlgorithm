//
//  PractiseListNodePrint.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/22.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

open class ListNode<T>: NSObject {
    var value:T
    var next:ListNode?
    
    init(value:T) {
        self.value = value
        self.next = nil
    }
}



class practiseListNode: NSObject {
    
    override init() {
        super.init()
        
    }
    
    //MARK: 在一个排序的链表中,删除重复的节点
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/18_02_DeleteDuplicatedNode/DeleteDuplicatedNode.cpp
    func deleteRepeateNode(headNode:inout ListNode<Any>?) {
        guard let _ = headNode else {return}
        var preNode:ListNode<Any>? = nil
        var curNode:ListNode<Any>? = headNode
        while curNode != nil {
            var nextNode:ListNode<Any>? = curNode?.next
            if nextNode?.value != curNode.value || nextNode? == nil {
                preNode = curNode
                curNode = curNode.next
            } else {
                while nextNode.next.value,nextNode?.next.value == curNode.value {
                    nextNode? = nextNode?.next
                }
                if  preNode == nil { // 删除的节点是头结点
                    headNode = nextNode
                } else {
                    preNode.next = nextNode?
                }
                curNode = nextNode?
            }
        }
    }
    
    
    //MARK:  在O(1)的时间内,删除一个节点,假设该节点位于链表内
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/18_01_DeleteNodeInList/DeleteNodeInList.cpp
    func deleteListNode(pHead:inout ListNode<Any>? , deleteNode:ListNode<Any>?) {
        guard let _ = pHead,let delete = deleteNode else {return}
        if delete.next != nil { // 被删节点还有尾结点
            let nextNode = delete.next!
            delete.value = nextNode.value
            delete.next = nextNode.next
            
        } else if delete.next == nil { // 被删节点位于尾结点
            var node:ListNode? = pHead
            while node?.next != deleteNode {
                node = node?.next
            }
            node?.next = nil
            
        } else if pHead == deleteNode { // 被删节点位于头节点,并且链表只有一个节点
            pHead = nil
        }
    }
}












class PractiseListNodePrint: NSObject {
    
    func printListNodeValueBackward(node:ListNode<Any>?) { // 倒叙打印链表
        guard let aNode = node else {return}
        var stack = [ListNode<Any>]()
        while aNode.next != nil {
            stack.append(aNode)
        }
        for item in stack{
            print(item.value)
        }
    }
    
    func recursionPrintListNodeBackward(node:ListNode<Any>?){ // 用递归倒叙打印链表
        guard let aNode = node else {return}
        if aNode.next != nil {
            self.recursionPrintListNodeBackward(node: aNode.next)
        }
        print(aNode.value)
    }
}
