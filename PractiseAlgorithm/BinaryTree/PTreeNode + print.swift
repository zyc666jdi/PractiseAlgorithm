//
//  PTreeNode + print.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/5/22.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

fileprivate let increaseBase:Int = 2 // 增大宽度的基础距离

class TreeObject: NSObject {
    var node:TreeNode?
    var fatherObject:TreeObject?
    var isLeft:Bool = true // 是父节点的坐节点
    var leftLength:Int = increaseBase
    var rightLength:Int = increaseBase
    var location:Int = 0 // 顶点的坐标
    var depth:Int = 0 // 深度
    
    init(node:TreeNode?,fatherObject:TreeObject?,depth:Int,isLeft:Bool,leftLength:Int = 0,rightLength:Int = 0) {
        self.node = node
        self.fatherObject = fatherObject
        self.depth = depth
        self.isLeft = isLeft
        self.leftLength = leftLength
        self.rightLength = rightLength
    }
}

public func SprintNode(_ node:TreeNode?) {
    var stack:[TreeObject] = []
    let rootObj = TreeObject.init(node: node, fatherObject: nil, depth: 0, isLeft: true)
    stack.append(rootObj)
    var mostLeftObj:TreeObject = rootObj // 最左边的节点
    while stack.count > 0 {
        let obj:TreeObject = stack.removeFirst()
        if obj.node?.left != nil {
            obj.leftLength += increaseBase
        }
        if obj.node?.right != nil{
            obj.rightLength += increaseBase
        }
        if obj.node?.left?.right != nil,obj.node?.right?.left != nil {
            obj.leftLength += increaseBase
            obj.rightLength += increaseBase
            var fatherObj:TreeObject? = obj.fatherObject
            while fatherObj != nil {
                if fatherObj!.isLeft == true {
                    fatherObj!.leftLength += increaseBase
                } else {
                    fatherObj!.rightLength += increaseBase
                }
                fatherObj = fatherObj?.fatherObject
                print("___",rootObj)
            }
        }
        if obj.node?.left != nil {
            let leftObj = TreeObject.init(node: obj.node?.left, fatherObject: obj, depth: obj.depth + 1, isLeft: true)
            stack.append(leftObj)
            if obj.isLeft == true { // 当前节点是父节点的左儿子
                mostLeftObj = leftObj
            }
            
        }
        if obj.node?.right != nil {
            let rightObj = TreeObject.init(node: obj.node?.right, fatherObject: obj, depth: obj.depth + 1, isLeft: false)
            stack.append(rightObj)
        }
    }
    var leftMargin:Int = 0
    var leftObj:TreeObject? = mostLeftObj
    while leftObj != nil {
        leftMargin += leftObj!.leftLength
        leftObj = leftObj?.fatherObject
    }
    
    func corePrint(root:TreeObject,leftMargin:Int){
        func Sprint(_ s:String){
            print(s, separator: "", terminator: "")
        }
        
        var stack:[TreeObject] = []
        var auxiliaryStack:[TreeObject] = []
        stack.append(root)
        var index:Int = 0
        var totalCount:Int = 0
        var lastNode:TreeObject? = nil
        while stack.count > 0 {
            totalCount += 1
            let topNode:TreeObject = stack.removeFirst()
            var left:Int = 0
            if let last = lastNode {
                left =  last.location + String(last.node!.val).length + last.rightLength - 1
            }
            if topNode.location + leftMargin - topNode.leftLength - 1  > 0{
                for _ in left...(topNode.location + leftMargin - topNode.leftLength - 1) {
                    Sprint(" ")
                }
            }
            if  topNode.leftLength > 0 {
                Sprint("┌─")
                for _ in 0...topNode.leftLength - 2 {
                    Sprint("─")
                }
            }
            Sprint(String(topNode.node!.val))
            if  topNode.rightLength > 0 {
                for _ in 0...topNode.rightLength - 2 {
                    Sprint("─")
                }
                Sprint("─┐")
            }
            if stack.count == 0 {
                Sprint("\n")
//                if topNode.location + leftMargin - topNode.leftLength - 1 > 0 {
//                    for _ in 0...(topNode.location + leftMargin - topNode.leftLength - 1) {
//                        Sprint(" ")
//                    }
//                }
//                Sprint("│")
//                for _ in 0...(topNode.leftLength + String(topNode.node!.val).count + topNode.rightLength - 1){
//                    Sprint(" ")
//                }
//                Sprint("│")
            }
//            if index == totalCount - 1 {
//                Sprint("\n")
//            }
            // 循环
            let n = topNode
            if n.node?.left != nil {
                let leftObj = TreeObject.init(node: n.node?.left, fatherObject: n, depth: n.depth + 1, isLeft: true)
                leftObj.location =  n.location - n.leftLength - 1
                if node?.left?.left != nil {
                    leftObj.leftLength = 2
                }
                if node?.left?.right != nil {
                    leftObj.rightLength = 2
                }
                auxiliaryStack.append(leftObj)
            }
            if n.node?.right != nil {
                let rightObj = TreeObject.init(node: n.node?.right, fatherObject: n, depth: n.depth + 1, isLeft: false)
                rightObj.location =  n.location + String(n.node!.val).length + n.rightLength - 1
                if node?.right?.left != nil {
                    rightObj.leftLength = 2
                }
                if node?.right?.right != nil {
                    rightObj.rightLength = 2
                }
                auxiliaryStack.append(rightObj)
            }
            lastNode = topNode
            index += 1
            // 当前stack中的node已打印完
            if stack.count == 0 {
                stack = auxiliaryStack
                auxiliaryStack = []
                lastNode = nil
                index = 0
                totalCount = 0
            }
        }
    }
    
    corePrint(root: rootObj, leftMargin: leftMargin)
            
            
            
            
            
            

        
    
    
}

func printx(node:TreeNode?){
//    guard let n = node else {return}
//    debugPrint("┌")
//    Sprint("┌")
//    Sprint("─")
//    Sprint("┐")
//    Sprint("\n")
//    Sprint("│")
    
//val location
//

//    Sprint("  ┌───7───┐")
//    Sprint("\n")
//    Sprint("  │       │")
//    Sprint("\n")
//    Sprint("┌─4─┐   ┌─9─┐")
//    Sprint("\n")
//    Sprint("│   │   │   │")
//    Sprint("\n")
//    Sprint("2   55 88   11")


    
}





//--2--
//|    |
//|    |
//1    3
