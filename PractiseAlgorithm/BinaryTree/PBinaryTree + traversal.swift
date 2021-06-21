//
//  PBinaryTree + traversal.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/4/8.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

// 二叉树的遍历

// 1.前序遍历   * ______  ________  逆波兰表达式,前缀运算

// 2.中序遍历  _______ * _________  中缀运算

// 3.后续遍历  ______ ______ *  逆波兰表达式 , 后缀运算

// 4.层级遍历   计算二叉树的高度,是否为完全二叉树


// 1.前序遍历
func preorderTree<T>(node:PTreeNode<T>?) -> [T]{ // 迭代法 iteration ✅
    guard let node = node else {return[]}
    var array:[PTreeNode<T>] = []
    var list:[T] = []
    array.append(node)
    while array.count > 0 {
        let node:PTreeNode<T> = array.removeLast()
        list.append(node.val)
        if let rightNode = node.right{
            array.append(rightNode)
        }
        if let leftNode = node.left {
            array.append(leftNode)
        }
    }
    return list
}

func preorderTreeRecursion<T>(node:PTreeNode<T>?) -> [T]{ // 递归法 recursion ✅
    
    func corePreorder<T>(node:PTreeNode<T>?, list:inout [T]){
        guard let node = node else {return}
        list.append(node.val)
        corePreorder(node: node.left, list: &list)
        corePreorder(node: node.right, list: &list)
    }
    
    var list:[T] = []
    corePreorder(node: node, list: &list)
    return list
}

// 2.中序遍历
func inorderTree<T>(root:PTreeNode<T>?) -> [T]{ // 迭代法 iteration ✅
    guard let root = root else {return[]}
    var array:[PTreeNode<T>] = []
    var list:[T] = []
    var node:PTreeNode<T>? = root
    while array.count > 0 || node != nil {
        if node != nil {
            array.append(node!)
            node = node?.left
        } else {
            if array.count == 0 {
                break
            }
            let topNode = array.removeLast()
            list.append(topNode.val)
            if topNode.right != nil {
                node = topNode.right
            }
        }
    }
    return list
}

func inorderTreeRecursion<T>(root:PTreeNode<T>?) -> [T]{ // ✅
    
    func coreInorder<T>(root:PTreeNode<T>?,list: inout [T]) {
        guard let root = root else {return}
        if root.left != nil {
            coreInorder(root: root.left, list: &list)
        }
        list.append(root.val)
        if root.right != nil {
            coreInorder(root: root.right, list: &list)
        }
        
    }
    
    guard let root = root else {return[]}
    var list:[T] = []
    coreInorder(root: root, list: &list)
    return list
}

// 3.后续遍历 ,用递归的方法都可以用栈重写,为深度优化
func postorderTree<T>(root:PTreeNode<T>?) -> [T] { // ✅
    guard let root = root else {return []}
    var array:[PTreeNode<T>] = [root]
    var list:[T] = []
    var lastNode:PTreeNode<T>? = nil
    while array.count > 0  {
        guard let node = array.last else {return list}
        if ((node.left == nil && node.right == nil) || lastNode?.val == node.right?.val) {
            list.append(node.val)
            array.removeLast()
            lastNode = node
        } else {
            if node.right != nil {
                array.append(node.right!)
            }
            if node.left != nil {
                array.append(node.left!)
            }
        }
    }
    return list
}

func postorderTreeRecursion<T>(root:PTreeNode<T>?) -> [T] { // ✅
    
    func corePostorder<T>(node:PTreeNode<T>?,list:inout [T]) {
        guard let node = node else {return}
        if node.left != nil {
            corePostorder(node: node.left, list: &list)
        }
        if node.right != nil {
            corePostorder(node: node.right, list: &list)
        }
        list.append(node.val)
    }
    
    guard  let node = root else {return []}
    var list:[T] = []
    corePostorder(node: node, list: &list)
    return list
}

// 4.层序遍历level order 用队列结构,为广度优先的解法
func levelOrder<T>(root:PTreeNode<T>?) -> [T] {
    guard  let node = root else {return []}
    var list:[T] = []
    // var queue = PQueue<PTreeNode<T>>()
    var queue = PxQueue<PTreeNode<T>>()
    queue.pushToBack(element: node)
    while queue.size() > 0 {
        if let head = queue.popFromFront() {
            list.append(head.val)
            if head.left != nil {
                queue.pushToBack(element: head.left!)
            }
            if head.right != nil {
                queue.pushToBack(element: head.right!)
            }
        }
    }
    return list
}

