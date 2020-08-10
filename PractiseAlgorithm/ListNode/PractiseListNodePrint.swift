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
    
    init(_ value:T) {
        self.value = value
        self.next = nil
    }
    
    static func  constructListNode(arr:[T]) -> ListNode? {
        guard let firstElement = arr.first else {return nil}
        let head:ListNode? = ListNode.init(firstElement)
        var node:ListNode? = head
        for (index,item) in arr.enumerated(){
            if index > 0 {
                node?.next = ListNode.init(item)
                node = node?.next
            }
        }
        return head
    }
}



class practiseListNode: NSObject {
    
    override init() {
        super.init()
        testFindLastNodeInListNode()
        
    }
    
    func testFindLastNodeInListNode() {
        let nodeDataSource = [1,2,3,4,5]
        testCaseFindLastNodeInListNode(arr: nodeDataSource, k: 1, expect: 5)
        testCaseFindLastNodeInListNode(arr: nodeDataSource, k: 5, expect: 1)
        testCaseFindLastNodeInListNode(arr: nodeDataSource, k: 0, expect: -1)
        testCaseFindLastNodeInListNode(arr: nodeDataSource, k: 6, expect: -1)
    }
    
    func testCaseFindLastNodeInListNode(arr:[Int],k:Int,expect:Int){
        let head = ListNode.constructListNode(arr: arr)
        let result = findLastNodeInListNode(head: head!, k: k)
        if result?.value ?? -1 == expect { // -1 代表非法输入
            print("testCaseFindLastNodeInListNode_surrcess",k)
        } else {
            print("testCaseFindLastNodeInListNode_failure",k)
        }
    }
    
    // MARK: - 求一个链表中倒数第k个节点
    func findLastNodeInListNode<T>(head:ListNode<T>?,k:Int) -> ListNode<T>? {
        if (head == nil) {
            return nil
        }
        if (k <= 0) {
            return nil
        }
        var node:ListNode<T>? = head
        var lastNode:ListNode<T>? = head
        for _ in 1..<k {
            if node != nil,node?.next != nil {
                node = node?.next
            } else {
                return nil // 节点不足k
            }
        }
        while node != nil,node?.next != nil {
            node = node?.next
            lastNode = lastNode?.next
        }
        return lastNode
    }
    
    
    
    
    //MARK: - 在一个排序的链表中,删除重复的节点
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/18_02_DeleteDuplicatedNode/DeleteDuplicatedNode.cpp
//    func deleteRepeateNode(headNode:inout ListNode<Any>?) {
//        guard let _ = headNode else {return}
//        var preNode:ListNode<Any>? = nil
//        var curNode:ListNode<Any>? = headNode
//        while curNode != nil {
//            var nextNode:ListNode<Any>? = curNode?.next
//            if nextNode?.value != curNode.value || nextNode? == nil {
//                preNode = curNode
//                curNode = curNode.next
//            } else {
//                while nextNode.next.value,nextNode?.next.value == curNode.value {
//                    nextNode? = nextNode?.next
//                }
//                if  preNode == nil { // 删除的节点是头结点
//                    headNode = nextNode
//                } else {
//                    preNode.next = nextNode?
//                }
//                curNode = nextNode?
//            }
//        }
//    }
    
    
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
