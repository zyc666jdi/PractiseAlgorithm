//
//  PractiseListNodePrint.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/22.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

open class ListNode<T:Equatable>: NSObject { // 遵守Equatable协议,可以用 == 判断相等
    var value:T
    var next:ListNode?
    
    init(_ value:T) {
        self.value = value
        self.next = nil
    }
    
    static func  constructListNode(arr:[T]) -> ListNode? { // 构造一个链表
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
    
    static func  constructCircleListNode(arr:[T],entryPoint:T) -> ListNode? { // 构造一个带环的链表
        guard let firstElement = arr.first else {return nil}
        let head:ListNode? = ListNode.init(firstElement)
        var node:ListNode? = head
        var entryNode:ListNode? = nil
        for (index,item) in arr.enumerated(){
            if index > 0 {
                node?.next = ListNode.init(item)
                if  item == entryPoint {
                    entryNode = node?.next
                }
                node = node?.next
            }
        }
        node?.next = entryNode
        return head
    }
}



class practiseListNode: NSObject {
    
    override init() {
        super.init()
       // testFindLastNodeInListNode()
        
       testFindCircleJoinNodeInListNode()
    }
    
    // MARK: - 找出链表中环的节点
    func testFindCircleJoinNodeInListNode() {
        testCaseFindCircleJoinNodeInListNode(arr: [1,2,3,4,5], expect: 3)
    }
    
    func testCaseFindCircleJoinNodeInListNode(arr:[Int],expect:Int){
        let head = ListNode.constructCircleListNode(arr: arr, entryPoint: expect)
        let circleNode = self.findCircleJoinNodeInListNode(head: head!)
        if circleNode?.value == expect {
            print("testCaseFindCircleJoinNodeInListNode_success",arr)
        } else {
            print("testCaseFindCircleJoinNodeInListNode_failure",arr)
        }
    }
    
    func findCircleJoinNodeInListNode<T>(head:ListNode<T>) -> ListNode<T>? {
        guard let node = findCircleInListNode(head: head) else {return nil}
        let circleCount = nodeCountInCircle(node: node)
        let joinNode = findCircleNodeInListNode(head: head, circleNodeCount: circleCount)
        return joinNode
    }
    
    
   private func findCircleInListNode<T>(head:ListNode<T>)-> ListNode<T>? { // 判断链表是否有环
           var pHead:ListNode<T> = head;
           var pTail:ListNode<T> = head;
           while pHead.next != nil,pHead.next?.next != nil {
               pHead = pHead.next!.next!
               pTail = pTail.next!
               if pHead == pTail {
                   return pHead
               }
           }
           return nil;
       }
       
      private func nodeCountInCircle<T>(node:ListNode<T>?)-> Int { // 已知环中的一个点,求环中点的个数
        guard var current = node?.next else {return 0}
           var nodeCount:Int = 1
           while current.next != nil,current != node! {
               current = current.next!
               nodeCount += 1
           }
           return nodeCount
       }
       
      private func findCircleNodeInListNode<T>(head:ListNode<T>,circleNodeCount:Int) -> ListNode<T>{ // 寻找链表环的节点
           var pHead:ListNode<T> = head
           var pTail:ListNode<T> = head
           for _ in 0 ..< circleNodeCount {
               pHead = pHead.next!
           }
           while pHead != pTail {
               pHead = pHead.next!
               pTail = pTail.next!
           }
           return pHead;
       }
    
    // MARK: - 求一个链表中倒数第k个节点
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/22_KthNodeFromEnd/KthNodeFromEnd.cpp
    
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
    func deleteListNode<T>(pHead:inout ListNode<T>? , deleteNode:ListNode<T>?) {
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
    
    func printListNodeValueBackward<T>(node:ListNode<T>?) { // 倒叙打印链表
        guard let aNode = node else {return}
        var stack = [ListNode<T>]()
        while aNode.next != nil {
            stack.append(aNode)
        }
        for item in stack{
            print(item.value)
        }
    }
    
    func recursionPrintListNodeBackward<T>(node:ListNode<T>?){ // 用递归倒叙打印链表
        guard let aNode = node else {return}
        if aNode.next != nil {
            self.recursionPrintListNodeBackward(node: aNode.next)
        }
        print(aNode.value)
    }
}
