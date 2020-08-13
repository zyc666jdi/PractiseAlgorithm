//
//  PractiseBinaryTree.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/25.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

open class BinaryTree<T:BinaryInteger>: NSObject {
    var value:T
    var left:BinaryTree?
    var right:BinaryTree?
    
    init(_ value:T,_ left:BinaryTree?, _ right:BinaryTree?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    init(value:T) {
        self.value = value
        self.left = nil
        self.right = nil
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
//        let preOrder:[Int] = [1,2,4,7,3,5,6,8]
//        let inOrder:[Int] = [4,7,2,1,5,3,8,6]
//        let _ = self.construcCoreBinaryTree(startPreOrderIndex: 0, endPrePrderIndex: 7, preOrder: preOrder, startInorderIndex: 0, endInorderIndex: 7, inOrder: inOrder)
        
        testTreeHasSubTree()
        
        
    }
    
    //MARK: - 二叉树是否包含另一个二叉树
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/26_SubstructureInTree/SubstructureInTree.cpp
    
    func testTreeHasSubTree () {
        testCasetreeHasSubTree1()
        testCasetreeHasSubTree2()
    }
    // 树中结点含有分叉，树B是树A的子结构
    //                  8                8
    //              /       \           / \
    //             8         7         9   2
    //           /   \
    //          9     2
    //               / \
    //              4   7
    func testCasetreeHasSubTree1() {
        var aTree = BinaryTree.init(2, BinaryTree.init(value: 4), BinaryTree.init(value: 7))
        aTree = BinaryTree.init(8, BinaryTree.init(value: 9), aTree)
        aTree = BinaryTree.init(8, aTree, BinaryTree.init(value: 7))
        let subTree = BinaryTree.init(8, BinaryTree.init(value: 9), BinaryTree.init(value: 2))
        if treeHasSubTree(aTree: aTree, subTree: subTree) {
            print("treeHasSubTree1_success")
        } else {
             print("treeHasSubTree1_faliure")
        }
    }
    
    // 树中结点含有分叉，树B不是树A的子结构
    //                  8                8
    //              /       \           / \
    //             8         7         9   2
    //           /   \
    //          9     3
    //               / \
    //              4   7
    func testCasetreeHasSubTree2(){
        var aTree = BinaryTree.init(3, BinaryTree.init(value: 4), BinaryTree.init(value: 7))
        aTree = BinaryTree.init(8, BinaryTree.init(value: 9), aTree)
        aTree = BinaryTree.init(8, aTree, BinaryTree.init(value: 7))
        let subTree = BinaryTree.init(8, BinaryTree.init(value: 9), BinaryTree.init(value: 2))
        if treeHasSubTree(aTree: aTree, subTree: subTree) {
            print("treeHasSubTree2_noContain_failure")
        } else {
             print("treeHasSubTree2_noContain_success")
        }
    }
    
    func treeHasSubTree<T>(aTree:BinaryTree<T>?,subTree:BinaryTree<T>?) -> Bool {
        guard let a = aTree ,let sub = subTree else {return false}
        if treeNodeContainSubTree(aTree: a, subTree: sub) {
            return true
        } else {
            return treeHasSubTree(aTree: a.left, subTree: subTree) || treeHasSubTree(aTree: a.right, subTree: subTree) // 不可以先判断A的子节点 == subTree的根节点,再判断A的左右及子树与subTree相等
        }
    }
        
    private func treeNodeContainSubTree<T>(aTree:BinaryTree<T>?,subTree:BinaryTree<T>?) -> Bool {
        guard let sub = subTree  else {return true}
        guard let a = aTree else {return false}
        if a.value == sub.value { // 如果T是float类型,不可以用== ,用 -0.0000001 < minus(T) < 0.0000001
            return treeNodeContainSubTree(aTree: a.left, subTree: sub.left) &&  treeNodeContainSubTree(aTree: a.right, subTree: sub.right)
        } else {
            return false
        }
    }
    
    
    //MARK: 根据前序排列和中序排列,重建二叉树
    func construcBinayTree(preOrder:[Int],inOrder:[Int],length:Int) -> BinaryTree<Int>?{
        if preOrder.count == 0 || inOrder.count == 0 || length == 0 {
            return nil
        }
        return self.construcCoreBinaryTree(startPreOrderIndex: 0, endPrePrderIndex: length - 1, preOrder: preOrder, startInorderIndex: 0, endInorderIndex: length - 1, inOrder: inOrder)
    }
    
    func  construcCoreBinaryTree(startPreOrderIndex:Int,endPrePrderIndex:Int,preOrder:[Int],startInorderIndex:Int,endInorderIndex:Int,inOrder:[Int]) ->BinaryTree<Int>? {
        let headTreeValue = preOrder[0]
        let rootTree = BinaryTree.init( headTreeValue,  nil,  nil)
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
