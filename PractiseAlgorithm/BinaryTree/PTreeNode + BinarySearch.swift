//
//  PTreeNode + BinarySearch.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/6/14.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution {
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? { // 删除搜索二叉树的节点✅
        var findnode:TreeNode? = root
        var findFather:TreeNode? = nil
        // find node
        while findnode != nil {
            if findnode!.val == key {
                break
            } else if  key < findnode!.val {
                findFather = findnode
                findnode = findnode?.left
            } else if key > findnode!.val {
                findFather = findnode
                findnode = findnode!.right
            }
        }
        // 没有这个节点
        if findnode == nil {
            return root
        }
        // delete
        // 度为2的节点,等价于找出新的被删除的节点(前驱节点或后继节点)
        if findnode?.left != nil,findnode?.right != nil {
            var predecessor = findnode?.left
            var predecessorFather = findnode
            while predecessor?.right != nil {
                predecessorFather = predecessor
                predecessor = predecessor?.right
            }
            findnode?.val = predecessor?.val ?? 0
            findnode = predecessor
            findFather = predecessorFather
        }
        // 找出被删除节点的替代节点
        let replaceNode:TreeNode? = findnode?.left != nil ? findnode?.left : findnode?.right
        if replaceNode != nil { // 查找的节点只有一个子节点
            if findFather == nil { // 查找的节点根节点
                return replaceNode
            } else {
                if findFather?.left?.val == findnode?.val ?? 0 {
                    findFather?.left = replaceNode
                } else {
                    findFather?.right = replaceNode
                }
            }
        } else { // 查找的节点是叶子节点
            if findFather == nil { // 查找的节点根节点  // 不可以用findNode.val == root.val判断是不是根节点,因为根节点的值可能已经改变
                return nil
            } else {
                if findFather?.left?.val == findnode?.val ?? 0 {
                    findFather?.left = nil
                } else {
                    findFather?.right = nil
                }
            }
        }
        return root
    }
    
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? { // ✅搜索二叉树的查找
        // find node
        var findnode:TreeNode? = root
        while findnode != nil {
            if findnode!.val == val {
                break
            } else if  val < findnode!.val {
                findnode = findnode?.left
            } else if val > findnode!.val {
                findnode = findnode!.right
            }
        }
        return findnode
    }
    
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? { // ✅搜索二叉树的添加
        // find node
        if root == nil {
            return TreeNode.init(val)
        }
        var findnode:TreeNode? = root
        while findnode != nil {
            if findnode!.val == val {
                break
            } else if  val < findnode!.val {
                if findnode?.left != nil {
                    findnode = findnode?.left
                } else {
                    findnode?.left = TreeNode.init(val)
                    break
                }
            } else if val > findnode!.val {
                if findnode?.right != nil {
                    findnode = findnode!.right
                } else {
                    findnode?.right = TreeNode.init(val)
                    break
                }
            }
        }
        return root
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool { // ✅是否是搜索二叉树
        // 中序遍历
        guard let root = root else {return true}
        var stack:[TreeNode] = []
        var elements:[Int] = []
        var auxiliaryNode:TreeNode? = root
        while stack.count > 0 || auxiliaryNode != nil {
            while auxiliaryNode != nil {
                stack.append(auxiliaryNode!)
                auxiliaryNode = auxiliaryNode?.left
            }
            if stack.count == 0 {
                break
            }
            let top = stack.removeLast()
            if elements.count > 0 {
                if elements.last! >= top.val {
                    return false
                }
            }
            elements.append(top.val)
            if top.right != nil {
                auxiliaryNode = top.right
            }
        }
        return true
    }
    
    func getMinimumDifference(_ root: TreeNode?) -> Int { // ✅二叉搜索树任意两节点的差的最小值
        if root == nil {
            return 0
        }
        // 中序遍历
        var stack:[TreeNode] = []
        var array:[Int] = []
        var minValue:Int = 1000000
        var auxiliaryNode:TreeNode? = root
        while array.count > 0 || auxiliaryNode != nil {
            while auxiliaryNode != nil {
                stack.append(auxiliaryNode!)
                auxiliaryNode = auxiliaryNode?.left
            }
            if stack.count == 0 {
                break
            }
            let topNode = stack.removeLast()
            if array.count > 0 {
                let lastValue:Int = array.last!
                if minValue > abs(lastValue - topNode.val) {
                    minValue = abs(lastValue - topNode.val)
                }
            }
            array.append(topNode.val)
            if topNode.right != nil {
                auxiliaryNode = topNode.right
            }
        }
        return minValue
    }
    
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {// ✅二叉搜索树位于[]范围的所有值之和
        // 中序遍历
        var stack:[TreeNode] = []
        // var values:[Int] = []
        var auxiliaryNode:TreeNode? = root
        var result:Int = 0
        while stack.count > 0 || auxiliaryNode != nil {
            while auxiliaryNode != nil {
                stack.append(auxiliaryNode!)
                auxiliaryNode = auxiliaryNode?.left
            }
            if stack.count == 0 {
                break;
            }
            let topNode:TreeNode = stack.removeLast()
            if topNode.val >= low,topNode.val <= high {
                result += topNode.val
            } else if topNode.val > high {
                break
            }
            // values.append(topNode.val)
            if topNode.right != nil {
                auxiliaryNode = topNode.right
            }
        }
        return result
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? { // ✅二叉搜索树的最近公共祖先
        guard let pNode = p,let qNode = q else {return nil}
        var node:TreeNode? = root
        let minValue:Int = min(pNode.val, qNode.val)
        let maxValue:Int = max(pNode.val, qNode.val)
        while node != nil {
            let nodeValue:Int = node?.val ?? 0
            if nodeValue == pNode.val {
                return p
            } else if nodeValue == qNode.val {
                return q
            } else if nodeValue > minValue,nodeValue < maxValue {
                return node
            } else if nodeValue < minValue {
                node = node?.right
            } else if nodeValue > maxValue {
                node = node?.left
            }
        }
        return nil
    }
    
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int { // ✅二叉搜索树种第k小的元素
        // 中序遍历
        var stack:[TreeNode] = []
        var elements:[Int] = []
        var auxiliaryNode:TreeNode? = root
        while stack.count > 0 || auxiliaryNode != nil {
            while auxiliaryNode != nil {
                stack.append(auxiliaryNode!)
                auxiliaryNode = auxiliaryNode?.left
            }
            if stack.count == 0 {break}
            let topNode = stack.removeLast()
            if elements.count == k - 1 {
                return topNode.val
            }
            elements.append(topNode.val)
            if topNode.right != nil {
                auxiliaryNode = topNode.right
            }
        }
        return 0
    }
    
    // 中序遍历是从小到大的顺序
    // 有两个顺序不对 X(i) > X(i+1) , Y(i) > Y(i+ 1)    X(i+1),Y(i)是交换位置的量那个节点
    // 1个顺序不对 X(i) > X(i+1),则X(i) < X(i+1是交换位置的两个节点
    func recoverTree(_ root: TreeNode?) { // 替换两个节点的位置的搜索二叉树,使其变回搜索二叉树
        var stack:[TreeNode] = []
        var auxiliaryNode:TreeNode? = root
        var Xnode:TreeNode? = nil
        var Ynode:TreeNode? = nil
        var lastNode:TreeNode? = nil
        while stack.count > 0 || auxiliaryNode != nil {
            while auxiliaryNode != nil {
                stack.append(auxiliaryNode!)
                auxiliaryNode = auxiliaryNode?.left
            }
            let topNode = stack.removeLast()
            if lastNode != nil{
                if lastNode!.val > topNode.val {
                    Ynode = topNode
                    if Xnode == nil {
                        Xnode = lastNode
                    } else {
                        break;
                    }
                }
            }
            lastNode = topNode
            if topNode.right != nil {
                auxiliaryNode = topNode.right
            }
        }
        let val = Xnode?.val ?? 0
        Xnode?.val = Ynode?.val ?? 0
        Ynode?.val = val
    }
}

class BSTIterator { // 二叉树迭代器
    var stack:[TreeNode] = []
    var auxiliaryNode:TreeNode? = nil

    init(_ root: TreeNode?) {
        self.auxiliaryNode = root
    }
    
    func next() -> Int {
        while auxiliaryNode != nil {
            stack.append(auxiliaryNode!)
            auxiliaryNode = auxiliaryNode?.left
        }
        if stack.count == 0 {return 0}
        let top = stack.removeLast()
        let value = top.val
        if top.right != nil {
            auxiliaryNode = top.right
        }
        return value
    }
    
    func hasNext() -> Bool {
        return (stack.count > 0 || auxiliaryNode != nil)
    }
}
