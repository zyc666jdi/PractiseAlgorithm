//
//  PBinaryTree + parctise.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/4/9.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

func testPreorderTree(){
    let node2 = PTreeNode(val: 2, left: PTreeNode.init(1), right: PTreeNode.init(3))
    let node4 = PTreeNode(val: 4, left: node2, right: PTreeNode.init(5))
    let node11 = PTreeNode(val: 11, left: PTreeNode.init(10), right: PTreeNode.init(12))
    let node9 = PTreeNode(val: 9, left: PTreeNode.init(8), right: node11)
    let node7 =  PTreeNode(val: 7, left: node4, right: node9)
    // let array = preorderTree(node: node7)
    // let array = preorderTreeRecursion(node: node7)
    let array = inorderTree(root: node7)
     debugPrint("__testPreorderTree_array:",array)
}

func testInorderTree(){
    let node2 = PTreeNode(val: 2, left: PTreeNode.init(1), right: PTreeNode.init(3))
    let node4 = PTreeNode(val: 4, left: node2, right: PTreeNode.init(5))
    let node6 = PTreeNode(val: 6, left: node4, right: PTreeNode.init(7))
    // let array = preorderTree(node: node7)
    // let array = preorderTreeRecursion(node: node7)
    // let array = inorderTree(root: node6)
    let array = inorderTreeRecursion(root: node6)

     debugPrint("__testInorderTree_array:",array)
}

func testPostorderTree(){
    let node2 = PTreeNode(val: 2, left: PTreeNode.init(1), right: PTreeNode.init(3))
    let node4 = PTreeNode(val: 4, left: node2, right: PTreeNode.init(5))
    let node11 = PTreeNode(val: 11, left: PTreeNode.init(10), right: PTreeNode.init(12))
    let node9 = PTreeNode(val: 9, left: PTreeNode.init(8), right: node11)
    let node7 = PTreeNode(val: 7, left: node4, right: node9)
//     let array = postorderTreeRecursion(root: node7)
    let array = postorderTree(root: node7)
    debugPrint("__testPostorderTree_array:",array)
}

func testLevelOrder(){
    let node2 = PTreeNode(val: 2, left: PTreeNode.init(1), right: PTreeNode.init(3))
    let node4 = PTreeNode(val: 4, left: node2, right: PTreeNode.init(5))
    let node11 = PTreeNode(val: 11, left: PTreeNode.init(10), right: PTreeNode.init(12))
    let node9 = PTreeNode(val: 9, left: PTreeNode.init(8), right: node11)
    let node7 = PTreeNode(val: 7, left: node4, right: node9)
    let array = levelOrder(root: node7)
    debugPrint("__testLevelOrder:",array)
    
}

func testPostorderTraversalLeetcode(){
    let node2 = TreeNode.init(2, TreeNode.init(3), nil)
    let node1 = TreeNode.init(1, nil, node2)
    let array = Solution().postorderTraversal(node1)
    debugPrint("___array__",array)
}

func testPostorderTraversalLeetcode2(){
    let node3 = TreeNode.init(3, TreeNode.init(1), TreeNode.init(2))
    let array = Solution().postorderTraversal(node3)
    debugPrint("___array__",array)
}

func testPostorderMirrosLeetcode1(){
    let node2 = TreeNode.init(2, TreeNode.init(3), nil)
    let node1 = TreeNode.init(1, nil, node2)
    let array = Solution().postorderMorris(node1)
    debugPrint("___array__",array)
}
func testPostorderMirrosLeetcode2(){
    let node3 = TreeNode.init(3, TreeNode.init(1), TreeNode.init(2))
    let array = Solution().postorderMorris(node3)
    debugPrint("___array__",array)
}



func testWidthOfBinaryTree(){
//    1,
//    1,1,
//    1,null,null,1,
//    1,null,null,1
    let node3L = TreeNode.init(1, TreeNode.init(1), nil)
    let node3R = TreeNode.init(1, nil, TreeNode.init(1))
    let node2L = TreeNode.init(1, node3L, nil)
    let node2R = TreeNode.init(1, nil, node3R)
    let node1 = TreeNode.init(1, node2L, node2R)
    let result = Solution().widthOfBinaryTree(node1)
    debugPrint("_testWidthOfBinaryTree_result_",result)
}

func testWidthOfBinaryTreeError(){
    
    func constructLeftNode() -> TreeNode {
        let nodeL = TreeNode.init(0, nil, TreeNode.init(0))
        return nodeL
    }
    func constructRightNode() -> TreeNode {
        let nodeR = TreeNode.init(0, TreeNode.init(0), nil)
        return nodeR
    }
    var head = TreeNode.init(0, constructLeftNode(), constructRightNode())
    var array:[TreeNode] = [head.left!,head.right!]
    for i in 0...1000 {
        var nodeL = constructLeftNode()
        array.first!.right =  nodeL
        var nodeR = constructRightNode()
        array.last!.left = nodeR
        array = [nodeL,nodeR]
    }
    let result = Solution().widthOfBinaryTree(head)
    debugPrint("_testWidthOfBinaryTree_result_",result)
}

func testPostorderManyTrees(){
    let tree11 = Node.init(val: 11, subTrees: [Node.init(14)])
    let tree7 = Node.init(val: 7, subTrees: [tree11])
    let tree3 = Node.init(val: 3, subTrees: [Node.init(6),tree7])
    
    let tree8 = Node.init(val: 8, subTrees: [Node.init(12)])
    let tree4 = Node.init(val: 4, subTrees: [tree8])
    
    let tree9 = Node.init(val: 9, subTrees: [Node.init(13)])
    let tree5 = Node.init(val: 5, subTrees: [tree9,Node.init(10)])
    
    let tree1 = Node.init(val: 1, subTrees: [Node.init(2),tree3,tree4,tree5])

    let result = Solution.init().postorder(tree1)
    debugPrint("_testPostorderManyTrees_result_",result)

    
}

func testConstructFromPrePostRecursion(){
    let result = Solution.init().constructFromPrePostRecursion([1,2,4,5,3,6,7], [4,5,2,6,7,3,1])
    debugPrint("_testConstructFromPrePostRecursion",result)

}

func testPrint(){
    let node2 = TreeNode.init(2, TreeNode.init(1), TreeNode.init(3))
    let node5 = TreeNode.init(5, nil, TreeNode.init(5))
    let node4 = TreeNode.init(4, node2, node5)
    let node8 = TreeNode.init(8, nil, nil)
    let node11 = TreeNode.init(11, TreeNode.init(10), TreeNode.init(12))
    let node9 = TreeNode.init(9, node8, node11)
    let node7 = TreeNode.init(7, node4, node9)
    SprintNode(node7)
}

func testGetPostorder(){
    let result = Solution.init().getPostorder(preorder: [1,2,4,5,3,6,7] , inorder: [4,2,5,1,6,3,7])
    debugPrint("_testGetPostorder",result)
}

func testGetMinimumDifference(){
    let node2 = TreeNode.init(2, TreeNode.init(1), TreeNode.init(3))
    let node4 = TreeNode.init(4, node2, TreeNode.init(6))
    let result = Solution.init().getMinimumDifference(node4)
    debugPrint("_testGetPostorder",result)
}

func testSortedArrayToBST(){
    let result = Solution.init().sortedArrayToBST([-10,-3,0,5,9])
    debugPrint("_sortedArrayToBST",result)
}



