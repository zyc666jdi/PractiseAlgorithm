//
//  PractiseBinaryTree.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/25.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

class BinaryTree: NSObject {
    var value:Int
    var left:BinaryTree?
    var right:BinaryTree?
    
    init(value:Int,left:BinaryTree?,right:BinaryTree?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

class BinaryTreeExtension: NSObject {
    var value:Int
    var left:BinaryTreeExtension?
    var right:BinaryTreeExtension?
    weak var parent:BinaryTreeExtension?
    
    init(value:Int,left:BinaryTreeExtension?,right:BinaryTreeExtension?,parent:BinaryTreeExtension?) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
    }
}

class PractiseBinaryTree: NSObject {
    
    override init() {
        super.init()
        let preOrder:[Int] = [1,2,4,7,3,5,6,8]
        let inOrder:[Int] = [4,7,2,1,5,3,8,6]
        let _ = self.construcCoreBinaryTree(startPreOrderIndex: 0, endPrePrderIndex: 7, preOrder: preOrder, startInorderIndex: 0, endInorderIndex: 7, inOrder: inOrder)
    }
    
    //MARK: 根据前序排列和中序排列,重建二叉树
    func construcBinayTree(preOrder:[Int],inOrder:[Int],length:Int) -> BinaryTree?{
        if preOrder.count == 0 || inOrder.count == 0 || length == 0 {
            return nil
        }
        return self.construcCoreBinaryTree(startPreOrderIndex: 0, endPrePrderIndex: length - 1, preOrder: preOrder, startInorderIndex: 0, endInorderIndex: length - 1, inOrder: inOrder)
    }
    
    func  construcCoreBinaryTree(startPreOrderIndex:Int,endPrePrderIndex:Int,preOrder:[Int],startInorderIndex:Int,endInorderIndex:Int,inOrder:[Int]) ->BinaryTree? {
        let headTreeValue = preOrder[0]
        let rootTree = BinaryTree.init(value: headTreeValue, left: nil, right: nil)
        var headInOrderIndex = 0
        for _ in startInorderIndex...endInorderIndex {
            if headTreeValue != inOrder[headInOrderIndex] {
                headInOrderIndex += 1
            }
        }
        if headInOrderIndex > endInorderIndex {
            return nil
        }
        let leftLength = headInOrderIndex
        if headInOrderIndex > 0 {
            rootTree.left = self.construcCoreBinaryTree(startPreOrderIndex: 1, endPrePrderIndex:1 + leftLength, preOrder: preOrder, startInorderIndex: 0, endInorderIndex: leftLength - 1, inOrder: inOrder)
        }
        if endInorderIndex - headInOrderIndex > 0 {
            rootTree.right = self.construcCoreBinaryTree(startPreOrderIndex: (1 + leftLength) + 1, endPrePrderIndex: endPrePrderIndex, preOrder: preOrder, startInorderIndex: headInOrderIndex + 1, endInorderIndex: endInorderIndex, inOrder: inOrder)
        }
        return rootTree
    }
    
    //MARK: 给定一个二叉树,和一个点,找出中序排序的下一个节点
    func nextBinaryTreeInOrder(node:BinaryTreeExtension) -> BinaryTreeExtension? {
        var nextNode:BinaryTreeExtension? = nil
        if node.right != nil {
            nextNode = node.right
            while nextNode?.left != nil {
                nextNode = nextNode?.left
            }
        } else if node.parent != nil {
            var currentNode:BinaryTreeExtension? = node
            var parentNode:BinaryTreeExtension? = currentNode?.parent
            while parentNode != nil,parentNode?.right == currentNode {
                currentNode = nextNode?.parent
                parentNode = parentNode?.parent
            }
            nextNode = parentNode
        }
        return nextNode
    }

}
