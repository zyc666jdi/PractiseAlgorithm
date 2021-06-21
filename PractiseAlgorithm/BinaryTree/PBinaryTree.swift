//
//  PBinaryTree.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/3/24.
//  Copyright © 2021 List. All rights reserved.
//

import UIKit


public class PTreeNode<T:Equatable> {
    public var val: T
    public var left: PTreeNode?
    public var right: PTreeNode?
    
    public init(_ val: T) {
        self.val = val
    }
    
    public init (val:T ,left:PTreeNode? ,right:PTreeNode?){
        self.val = val
        self.left = left
        self.right = right
    }
    
}

// 二叉树 BinaryTree
//        1          第1层
//      /   \
//     2     3       第i层,最多有2(i-1)个节点
//    / \   /  \
//   4   5 6    7
//  /
// 8                 高度为h时,最多有2(h)  - 1 个节点

// 二叉树的性质#1:  n = n0  +  n1  + n2    // n为总节点数,n0表示度为0的节点--------- 总节点数与degree的关系
// 二叉树的性质#2:   n1 + 2 * n2 = n - 1 =  n0 + n1 + n2 -1 即:n2 = n0 - 1 // 二叉树的总边数推导---------度为0与度为2的关系






// 完全二叉树 Complete BinaryTrey #1                  #2
//        1                              //         1
//      /   \                            //       /   \
//     2     3                           //      2     3
//    / \   /  \                         //     / \   /  \
//   4   5 6    7                        //    4   5 6    7
//  /                                    //   / \
// 8                                     //  8   9

// n1 为1 或者0
// 最少有2(h-1) 节点 ,      // 完全二叉树 n 与 h 的关系
// 最多有2(h) - 1节点
// 2(h-1) <= n < 2(h)
//  h - 1 <= log2(n) < h
//  h = floor(log2(n)) + 1  // 完全二叉树 h 与 n的关系



// 如果一颗完全二叉树有768的节点,求叶子节点的个数
// n = n1 + n2 + n0
//
// n -1 = 2 * n2  + n1 = n1 + n2 + n0 -1
// n2 =  n0 -1
// n = 2*n0  - 1 + n1
// 完全二叉树的n1 为 0 或1
// n1=0 => n0 = (n + 1)/ 2 (n 为奇数)
// n1=1 => n0 = (n / 2) (n为偶数)
// n0 = floor(n + 1) / 2
// n0 = 384


