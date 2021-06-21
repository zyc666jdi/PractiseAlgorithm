//
//  PBinaryTree + leetcode.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/4/12.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

 //  Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


public class Solution {
    // MARK: - 反转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? { // ✅
        guard let root = root else {return nil}
        var array:[TreeNode] = []
        var node:TreeNode? = root
        while array.count > 0 || node != nil {
            if node != nil {
                array.append(node!)
                node = node?.left
            } else {
                if array.count == 0 {break}
                let TopNode:TreeNode = array.popLast()!
                let left = TopNode.left
                TopNode.left = TopNode.right
                TopNode.right = left
                if TopNode.left != nil {
                    node = TopNode.left
                }
            }
        }
        return root
    }
    
    
    func invertTreeRecursion(_ root: TreeNode?) -> TreeNode? { // ✅
        
        func coreInvertTree(_ node:TreeNode?){
            if node != nil {
                let left = node?.left
                node?.left = node?.right
                node?.right = left
            } else {
                return
            }
            coreInvertTree(node?.left)
            coreInvertTree(node?.right)
        }
        
        if root == nil {
            return nil
        }
        
        coreInvertTree(root)
        return root
        
    }
    // MARK: - 求二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int { // ✅
        guard let node = root else {return 0}
        var array:[TreeNode] = [node]
        var depthArray:[Int] = [1]
        var maxHeight:Int = 0
        while array.count > 0 {
            let topNode = array.removeLast()
            let topHeight = depthArray.removeLast()
            maxHeight = max(maxHeight, topHeight)
            if topNode.right != nil {
                array.append(topNode.right!)
                depthArray.append(topHeight + 1)
            }
            if topNode.left != nil {
                array.append(topNode.left!)
                depthArray.append(topHeight + 1)
            }
        }
        return maxHeight
    }
    
    func maxDepthRecursion(_ root: TreeNode?) -> Int { // ✅
        func coreDepth( node: TreeNode?,height:Int) ->Int{
            var maxHeight:Int = height
            if node?.left == nil,node?.right == nil {
                return maxHeight
            }
            if node?.left != nil {
                maxHeight = max(maxHeight, coreDepth(node: node?.left, height: height + 1))
            }
            if node?.right != nil {
                maxHeight = max(maxHeight, coreDepth(node: node?.right, height: height + 1))
            }
            return maxHeight
        }
        if root == nil {return 0}
        return coreDepth(node: root, height: 1)
    }
    
    // MARK: - 二叉树是否是完全
    
    // 是否是完全二叉树
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        // 用两个栈当队列使用
        var inArray:[TreeNode?] = []
        var outArray:[TreeNode?] = []
        func enqueue(node: TreeNode?){
            inArray.append(node)
        }
        func dequeue() -> TreeNode?{
            if outArray.count == 0 {
                while inArray.last != nil  {
                    outArray.append(inArray.removeLast())
                }
            }
            return outArray.removeLast()
        }
        
        func size() -> Int{
            return (inArray.count + outArray.count)
        }
        
        func isEmpty() -> Bool {
            return (inArray.count == 0 && outArray.count == 0)
        }
        guard let root = root else {return true}
        enqueue(node: root)
        var touchEnd:Bool = false
        while !isEmpty()  {
            let head:TreeNode? = dequeue()
            if head == nil {
                touchEnd = true
            } else {
                if touchEnd == true {
                    return false
                }
                enqueue(node: head?.left)
                enqueue(node: head?.right)
            }
        }
        return true
    }
    
    func isCompleteTree2(_ root: TreeNode?) -> Bool {
        // 用两个栈当队列使用
        var inArray:[TreeNode] = []
        var outArray:[TreeNode] = []
        func enqueue(node: TreeNode){
            inArray.append(node)
        }
        func dequeue() -> TreeNode?{
            if outArray.count == 0 {
                while inArray.last != nil  {
                    outArray.append(inArray.removeLast())
                }
            }
            if outArray.count == 0 {
                return nil
            } else {
                return outArray.removeLast()
            }
        }
        
        func size() -> Int{
            return (inArray.count + outArray.count)
        }
        
        guard let root = root else {return true}
        enqueue(node: root)
        var flag:Bool = false
        while size() > 0 {
            let node:TreeNode = dequeue()!
            if flag == true {
                if node.left != nil || node.right != nil {
                    return false
                }
                continue
            }
            if node.left != nil {
                enqueue(node: node.left!)
                if node.right != nil {
                    enqueue(node: node.right!)
                }
            }
            if node.left == nil ,node.right != nil {
                return false
            }
            if node.right == nil {
                flag = true
            }
            
        }
        return true
    }


    // MARK: - 前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {  // ✅
        guard let root = root else {return[]}
        var array:[TreeNode] = []
        var list:[Int] = []
        array.append(root)
        while array.count > 0 {
            let head:TreeNode = array.popLast()!
            list.append(head.val)
            if head.right != nil {
                array.append(head.right!)
            }
            if head.left != nil {
                array.append(head.left!)
            }
        }
        return list
    }
    
    func preorderTraversalRecursion(_ root: TreeNode?) -> [Int] {  // ✅
        
        func corePreorder(_ node:TreeNode?,array:inout [Int]){
            guard let node = node else {return}
            array.append(node.val)
            if node.left != nil {
                corePreorder(node.left, array: &array)
            }
            if node.right != nil {
                corePreorder(node.right, array: &array)
            }
        }
        
        guard let root = root else {return[]}
        var list:[Int] = []
        corePreorder(root, array: &list)
        return list
    }
    
    // MORRIS遍历
    //     1  ←------|
    //   /   \       |
    //  ①③  ③      |
    // 2       3     |
    //        ④     |
    //   ①②________|
    //
    // 1.找到左子树,最右边的节点 morstRight
    // 2.该mostRight.right为空,该节点指向自己,self = self.left
    // 3.该mostRight.right不为空,self = self.right,mostRight.right = nil
    // 4. 左子树为空时,self = slf.right
    func preorderMirros(_ root: TreeNode?) -> [Int]{  // ✅
        guard let root = root else {return[]}
        var array:[Int] = []
        var current:TreeNode? = root
        var mostRight:TreeNode? = nil
        while current != nil {
            if current?.left != nil {
                mostRight = current?.left
                while mostRight?.right != nil,mostRight!.right!.val != current!.val {
                    mostRight = mostRight?.right
                }
                if mostRight?.right == nil {
                    mostRight?.right = current
                    array.append(current!.val)
                    current = current?.left
                    continue
                } else  {
                    mostRight?.right = nil
                }
            } else {
                array.append(current!.val)
            }
            current = current?.right
        }
        return array
    }
    
    // MARK: - 中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {  // ✅
        guard let root = root else {return []}
        var array:[Int] = []
        var stack:[TreeNode] = []
        var node:TreeNode? = root
        while stack.count > 0 || node != nil {
            while node != nil {
                stack.append(node!)
                node = node?.left
            }
            if node == nil {
                if stack.count == 0 {
                    break
                }
                let top:TreeNode = stack.removeLast()
                array.append(top.val)
                if top.right != nil {
                    node = top.right
                }
            }
        }
        return array
    }
    
    
    func inorderRecursion(_ root: TreeNode?) -> [Int] {  // ✅
        func coreInorder(_ node:TreeNode?,array:inout [Int]){
            guard let node = node else {return}
            if node.left != nil {
                coreInorder(node.left, array: &array)
            }
            array.append(node.val)
            if node.right != nil {
                coreInorder(node.right, array: &array)
            }
        }
        guard let root = root else {return []}
        var array:[Int] = []
        coreInorder(root, array: &array)
        return array
    }
    
    // MORRIS遍历
    //     1  ←------|
    //   /   \       |
    //  ①③  ③      |
    // 2       3     |
    //        ④     |
    //   ①②________|
    func inorderMorris(_ root: TreeNode?) -> [Int] {  // ✅
        guard let root = root else {return []}
        var array:[Int] = []
        var current:TreeNode? = root
        var mostRight:TreeNode? = nil
        while current != nil {
            if current?.left != nil {
                mostRight = current?.left
                while mostRight?.right != nil,mostRight?.right?.val != current?.val {
                    mostRight = mostRight?.right
                }
                if mostRight?.right == nil {
                    mostRight?.right = current
                    current = current?.left
                } else {
                    mostRight?.right = nil
                    array.append(current!.val)
                    current = current?.right
                }
            } else {
                array.append(current!.val)
                current = current?.right
            }
        }
        return array
    }
    // MARK: - 后续遍历
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {  // ✅
        var array:[Int] = []
        var nodeList:[TreeNode] = []
        var node:TreeNode? = root
        var lastNode:TreeNode? = nil
        while nodeList.count > 0 || node != nil {
            if node != nil {
                nodeList.append(node!)
                lastNode = node
                node = node?.left
            } else {
                if nodeList.count == 0 {
                    return array
                }
                let top:TreeNode = nodeList.last!
                if top.right != nil,lastNode?.val != top.right?.val {
                    node = top.right
                } else {
                    array.append(top.val)
                    lastNode = top
                    nodeList.removeLast()
                }
            }
        }
        return array
    }
    
    func postorderRecursion(_ root: TreeNode?) -> [Int] {  // ✅
        func corePostorder(_ node: TreeNode?,array:inout [Int]){
            guard var node = node else {return}
            if node.left != nil {
                corePostorder(node.left, array: &array)
            }
            if node.right != nil {
                corePostorder(node.right, array: &array)
            }
            array.append(node.val)
        }
        var array:[Int] = []
        corePostorder(root, array: &array)
        return array
    }
    
    
    // MORRIS遍历
    //     1  ←------|
    //   /   \       |
    //  ①③  ③      |
    // 2       3     |
    //        ④     |
    //   ①②________|
    func postorderMorris(_ root: TreeNode?) -> [Int] {  // ✅
        func addNode(array:inout [Int],node:TreeNode?) {
            var node = node
            var count:Int = 0
            while node != nil {
                array.append(node!.val)
                node = node?.right
                count += 1
            }
            var left = array.count - count
            var right = array.count - 1
            while left < right {
                let leftVal = array[left]
                array[left] = array[right]
                array[right] = leftVal
                left += 1
                right -= 1
            }
        }
        if root == nil {
            return[]
        }
        var array:[Int] = []
        var current:TreeNode? = root
        var mostRight:TreeNode? = nil
        while current != nil {
            if current?.left != nil {
                mostRight = current?.left
                while mostRight?.right != nil,mostRight?.right?.val != current?.val {
                    mostRight = mostRight?.right
                }
                if mostRight?.right == nil {
                    mostRight?.right = current
                    current = current?.left
                    continue
                } else {
                    mostRight?.right = nil
                    addNode(array: &array, node: current?.left)
                }
            }
            current = current?.right
        }
        addNode(array: &array, node: root)
        return array
    }
    // MARK: - 二叉树的层级遍历II
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] { // ✅
        if root == nil {return []}
        var array:[[Int]] = []
        var nodes:[(TreeNode,Int)] = [(root!,0)]
        var lastDepath:Int = 0
        var levelArray:[Int] = []
        while nodes.count > 0 {
            let (head,depth) = nodes.removeFirst()
            if depth != lastDepath {
                lastDepath = depth
                array.insert(levelArray, at: 0)
                levelArray = []
            }
            levelArray.append(head.val)
            if head.left != nil {
                nodes.append((head.left!,depth + 1))
            }
            if head.right != nil {
                nodes.append((head.right!,depth + 1))
            }
        }
        array.insert(levelArray, at: 0)
        return array
    }
    
    // MARK: - 二叉树的最大宽度
    func widthOfBinaryTree(_ root: TreeNode?) -> Int { // ✅
        // 用array当做队列用
        var array:[(TreeNode,Int,Int)] = []
        if root == nil {return 0}
        array.append((root!,0, 0))
        var maxWidth:Int = 1
        var leftDepth:Int = 0
        var leftLocation:Int = 0
        while array.count > 0 {
            let (node,depth,location) = array.removeFirst()
            if leftDepth != depth {
                leftDepth = depth
                leftLocation = location
            }
            if node.left != nil { // 不判断nil,都添加时,当二叉树层级很高,会导致运行超时
                // 直接添加location * 2 ,当二叉树层级高时,会导致Swift runtime failure: arithmetic overflow
                array.append((node.left!, depth + 1, (location - leftLocation) * 2))
            }
            if node.right != nil {
                array.append((node.right!, depth + 1, (location - leftLocation) * 2 + 1))
            }
            maxWidth = max(maxWidth, location - leftLocation + 1)
        }
        return maxWidth
    }
    
    // MARK: - 二叉树展开为链表
    func flatten(_ root: TreeNode?) { // ✅
        // 前序遍历
        if root == nil {return}
        var stack:[TreeNode] = [root!]
        var lastNode:TreeNode? = nil
        while stack.count > 0 {
            let head = stack.removeLast()
            if head.right != nil {
                stack.append(head.right!)
            }
            if head.left != nil {
                stack.append(head.left!)
            }
            lastNode?.left = nil
            lastNode?.right = head
            lastNode = head
        }
    }
    // MARK: - 中序遍历和后续遍历构造二叉树
    // 后续遍历逆序(后续遍历的栈从顶部弹出) ↘
    //   root
    //  /    \
    //      ....
    //      /  \
    //    ...  array[x]
    //         /   \
    //       ...  array[x - 1]
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? { // 迭代求解
        
        if postorder.count == 0 || inorder.count == 0 {
            return nil
        }
        var stack:[TreeNode] = []
        let root = TreeNode.init(postorder.last!)
        stack.append(root)
        var inorderIndex = inorder.count - 1
        if postorder.count == 1 {
            return root
        }
        for i in (0 ... postorder.count - 2).reversed(){
            var topNode:TreeNode = stack.last!
            if topNode.val != inorder[inorderIndex] {
                let node = TreeNode.init(postorder[i])
                topNode.right = node
                stack.append(node)

            } else {
                while stack.count > 0 ,stack.last!.val == inorder[inorderIndex] {
                    inorderIndex -= 1
                    topNode = stack.removeLast()
                }
                let node = TreeNode.init(postorder[i])
                topNode.left = node
                stack.append(node)
            }
        }
        return root
    }
    
    
    func buildTreeRecusion(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? { // // 递归求解 ✅
        let inorderArray:[Int] = inorder
        let postorderArray:[Int] = postorder
        var postIndex:Int = postorderArray.count - 1
        
        func coreBuildTree(left:Int,right:Int) -> TreeNode? {
            if left > right {
                return nil
            }
            let val:Int = postorderArray[postIndex]
            postIndex -= 1
            let inorderIndex:Int = inorderArray.firstIndex(of: val)!
            let node = TreeNode.init(val)
            node.right = coreBuildTree(left: inorderIndex + 1 , right: right)
            node.left = coreBuildTree(left: left, right: inorderIndex - 1)
            return node
        }
        
        let root = coreBuildTree(left: 0, right: inorderArray.count - 1)
        return root
    }
    
    // MARK:前序遍历与中序遍历得到二叉树
    func buildTreeIteration(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? { // 迭代求解 ✅
        if preorder.count == 0 || inorder.count == 0 {
            return nil
        }
        var stack:[TreeNode] = []
        var inorderIndex:Int = 0
        let root = TreeNode.init(preorder[0])
        stack.append(root)
        if preorder.count == 1 {
            return root
        }
        for i in 1...(preorder.count - 1) {
            if inorderIndex >= inorder.count {
                break
            }
            var top:TreeNode = stack.last!
            let node = TreeNode.init(preorder[i])
            if top.val != inorder[inorderIndex] {
                top.left = node
            } else {
                while stack.count > 0 , stack.last!.val  != inorder[inorderIndex] {
                    inorderIndex += 1
                    top =  stack.removeLast()
                }
                top.right = node
            }
            stack.append(node)
        }
        return root
    }
    
    func buildTreeRecursion(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? { // 递归 ✅
        var preorderIndex:Int = 0
        func coreBuildTree(left:Int,right:Int) -> TreeNode? {
            if left > right || preorderIndex >= preorder.count {
                return nil
            }
            let index = inorder.firstIndex(of: preorder[preorderIndex]) ?? 0
            let tree = TreeNode.init(preorder[preorderIndex])
            preorderIndex += 1
            tree.left = coreBuildTree(left: left, right: index - 1)
            tree.right = coreBuildTree(left: index + 1, right: right)
            return tree
        }
        return coreBuildTree(left: 0, right: inorder.count - 1)
    }
    
    // MARK:前序遍历与后续遍历构造二叉树
    func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode? { // 迭代求解 ✅
        if pre.count == 0  || post.count == 0 {
            return nil
        }
        var postindex:Int = 0
        var stack:[TreeNode] = []
        let root = TreeNode.init(pre[0])
        stack.append(root)
        if pre.count == 1 {
            return root
        }
        for i in 1...(pre.count - 1) {
            let node = TreeNode.init(pre[i])
            var top:TreeNode = stack.last!
            if top.val != post[postindex] {
                top.left = node
            } else {
                while stack.count > 0 , stack.last!.val == post[postindex] {
                   top = stack.removeLast()
                   postindex += 1
                }
                stack.last?.right = node
            }
            stack.append(node)
        }
        return root
    }
    
    func constructFromPrePostRecursion(_ pre: [Int], _ post: [Int]) -> TreeNode? { // 递归求解 ✅
        
        // 应该传二叉树儿子的前序数组和后续数组,这里只穿index,可以间接得到数组
        func coreConstructFromPrePost(preLeft:Int,preRight:Int,postLeft:Int) -> TreeNode? {
            if preLeft == preRight {
                return TreeNode.init(pre[preLeft])
            } else if preLeft > preRight || postLeft > pre.count - 1 {
                return nil
            } else {
                let treeNode = TreeNode.init(pre[preLeft])
                let postIndex:Int = post.firstIndex(of: pre[preLeft + 1])!
                let leftCount = postIndex - postLeft + 1
                treeNode.left = coreConstructFromPrePost(preLeft: preLeft + 1, preRight: preLeft + leftCount,postLeft: postLeft)
                treeNode.right = coreConstructFromPrePost(preLeft: preLeft + leftCount + 1, preRight: preRight,postLeft: postIndex + 1)
                return treeNode
            }
        }
        let root = coreConstructFromPrePost(preLeft: 0, preRight: pre.count - 1,postLeft: 0)
    
        return root
    }
    
    // 检查一颗二叉树,是否是对称的
    func isSymmetric(_ root: TreeNode?) -> Bool { // 迭代求解 ✅
        var stack:[TreeNode?] = []
        stack.append(root?.left)
        stack.append(root?.right)
        while stack.count >= 2 {
            let aNode = stack.removeFirst()
            let bNode = stack.removeFirst()
            if aNode == nil,bNode == nil {
                continue
            }
            if aNode == nil || bNode == nil  {
                return false
            }
            if aNode!.val != bNode!.val {
                return false
            }
            stack.append(aNode?.left)
            stack.append(bNode?.right)
            stack.append(aNode?.right)
            stack.append(bNode?.left)
        }
        return true
    }
    
    func isSymmetricRecursion(_ root: TreeNode?) -> Bool { // 递归求解 ✅
        func coreCheck(a:TreeNode?,b:TreeNode?) -> Bool{
            if a == nil,b == nil {
                return true
            }
            if a == nil || b == nil {
                return false
            }
            return a!.val == b!.val && coreCheck(a: a?.left, b: b?.right) && coreCheck(a: a?.right, b: b?.left)
        }
        return coreCheck(a: root?.left, b: root?.right)
    }
    
    // 已知前序、中序遍历结果，求出后序遍历结果
//    /////////////////
//           1
//        2       3
//    4      5   6   7
//    pre [1,2,4,5,3,6,7]  找出头节点
//    in   [4,2,5,1,6,3,7] 逆序 [7.3.6.1.5.2.4] // 逆序一份为2
//
//    // 1
//    // 1, 3 ,7 ,6 ,
//    //            ,2 ,5 ,4
    func getPostorder(preorder:[Int],inorder:[Int]) -> [Int]{
        var stack:[[Int]] = []
        var postorder:[Int] = []
        let inorderReversed:[Int] = inorder.reversed()
        stack.append(inorderReversed)
        while stack.count > 0 {
            let head:[Int] = stack.removeFirst()
            if head.count == 1 {
                postorder.append(head.first!)
                continue
            }
            var headVal = 0
            for v in preorder {
                if head.contains(v) {
                    headVal = v
                    break
                }
            }
            postorder.append(headVal)
            var firstArray:[Int] = []
            var lastArray:[Int] = []
            var isFirst:Bool = true
            for val in head {
                if val != headVal {
                    if isFirst == true {
                        firstArray.append(val)
                    } else {
                        lastArray.append(val)
                    }
                } else {
                    isFirst = false
                    continue
                }
            }
            if lastArray.count > 0 {
                stack.insert(lastArray, at: 0)
            }
            
            if firstArray.count > 0 {
                stack.insert(firstArray, at: 0)
            }
            
        }
        postorder = postorder.reversed()
        return postorder
    }
    
}

