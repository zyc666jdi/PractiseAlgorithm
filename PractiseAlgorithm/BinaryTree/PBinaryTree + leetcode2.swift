//
//  PBinaryTree + leetcode2.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/4/25.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
    }
    public init (val:Int,subTrees:[Node]){
        self.val = val
        self.children = subTrees
    }
}

extension Solution {
    // MARK: - n叉树的前序遍历
    func preorder(_ root: Node?) -> [Int] {
        if root == nil {return []}
        var stack:[Node] = [root!]
        var valus:[Int] = []
        while stack.count > 0 {
            let top:Node = stack.removeLast()
            valus.append(top.val)
            while top.children.count > 0 {
                stack.append(top.children.removeLast())
            }
        }
        return valus
    }
    
    // MARK: - n叉树的后序遍历
    //       1①
    //    /  |  \
    //   2④ 3③  4②
    // 后续遍历倒着数
    func postorder(_ root: Node?) -> [Int] {
        if root == nil {return []}
        var stack:[Node] = [root!]
        var valus:[Int] = []
        var auxiliaryValues:[Int] = []
        while stack.count > 0 {
            let topNode = stack.removeLast()
            auxiliaryValues.append(topNode.val)
            // valus.insert(topNode.val, at: 0) // 这个方法性能较差
            if topNode.children.count > 0 {
                for node in topNode.children {
                    stack.append(node)
                }
            }
        }
        while auxiliaryValues.count > 0 {
            valus.append(auxiliaryValues.removeLast())
        }
        return valus
    }
    
    // MARK: - n叉树的最大深度
    func maxDepth(_ root: Node?) -> Int { // ✅
        if root == nil {return 0}
        var maxDepth = 1
        var stack:[(Node,Int)] = [(root!,1)]
        while stack.count > 0 {
            let (headNode,depth) = stack.removeLast()
            maxDepth = max(maxDepth, depth)
            for node in headNode.children {
                stack.append((node,depth + 1))
            }
        }
        return maxDepth
    }
    
    func maxDepthLowSpeed(_ root: Node?) -> Int { // ✅
        // 遍历 - 层序
        if root == nil {return 0}
        var maxDepth = 1
        var stack:[(Node,Int)] = [(root!,1)]
        while stack.count > 0 {
            let (headNode,depth) = stack.removeFirst() // 性能太差
            maxDepth = max(maxDepth, depth)
            if headNode.children.count > 0 {
                for node in headNode.children {
                    stack.append((node,depth + 1))
                }
            }
        }
        return maxDepth
    }
}
