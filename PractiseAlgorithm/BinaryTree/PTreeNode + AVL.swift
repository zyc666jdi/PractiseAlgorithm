//
//  PTreeNode + AVL.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/5/27.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution {
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        func coreNodeHeight(_ node:TreeNode?) -> (Int,Bool) {
            guard let no = node else {return (0,true)}
            let (leftHeight,leftIsBalance) = coreNodeHeight(no.left)
            let (rightHeight,rightIsBalance) = coreNodeHeight(no.right)
            if !leftIsBalance || !rightIsBalance || abs(leftHeight - rightHeight) > 1  {
                return (0,false)
            }
            return (1 + max(leftHeight, rightHeight),true)
        }
        let (_,isBalance) = coreNodeHeight(root)
        return isBalance

    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? { // ✅从排序数组构造AVL树
        func coreSortedArrayToBST(leftIndex:Int,rightIndex:Int) ->TreeNode? {
            if leftIndex > rightIndex {
                return nil
            } else if leftIndex == rightIndex {
                return TreeNode.init(nums[leftIndex])
            } else {
                let midIndex = (rightIndex - leftIndex + 1) / 2 + leftIndex // 向下取整
                let node = TreeNode.init(nums[midIndex])
                node.left = coreSortedArrayToBST(leftIndex: leftIndex, rightIndex: midIndex - 1)
                node.right = coreSortedArrayToBST(leftIndex: midIndex + 1, rightIndex: rightIndex)
                return node
            }
        }
        return coreSortedArrayToBST(leftIndex: 0, rightIndex: nums.count - 1)
    }
    
}
