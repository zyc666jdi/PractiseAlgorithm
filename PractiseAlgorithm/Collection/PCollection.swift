//
//  PCollection.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/6/22.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution {
    // 349. 两个数组的交集
    // https://leetcode-cn.com/problems/intersection-of-two-arrays/
    class Solution {
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] { // set去重
            var numSet:Set = Set<Int>.init()
            var numSet2:Set = Set<Int>.init()
            for ele in nums1 {
                numSet.insert(ele)
            }
            for ele in nums2 {
                numSet2.insert(ele)
            }
            return numSet.filter{numSet2.contains($0)}
        }
    }
}

extension Solution {
    // 剑指 Offer 03. 数组中重复的数字
    // https://leetcode-cn.com/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof/
    func findRepeatNumber(_ nums: [Int]) -> Int { // 思路同上
        var set:Set = Set<Int>.init() // set是结构体
        for e in nums {
            if !set.contains(e){
                set.insert(e)
            } else {
                return e
            }
        }
        return 0
    }
}

extension Solution {
    // 剑指 Offer 57. 和为s的两个数字
    // https://leetcode-cn.com/problems/he-wei-sde-liang-ge-shu-zi-lcof/
    // 输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var rightIndex:Int = nums.count - 1
        for (i,ele) in nums.enumerated() {
            let small:Int = ele
            let big:Int = target - small
            while nums[rightIndex] > big,rightIndex > i {
                rightIndex -= 1
            }
            if big == nums[rightIndex] {
                return [ele,nums[rightIndex]]
            }
            if rightIndex <= i {
                break
            }
        }
        return []
    }
}


extension Solution {
    // 剑指 Offer 11. 旋转数组的最小数字
    // https://leetcode-cn.com/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof/
    // 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一个旋转，该数组的最小值为1
    func minArray(_ numbers: [Int]) -> Int {
        
        func getLowInOrder(left:Int,right:Int,arr:[Int]) -> Int {
            var result:Int = arr[left]
            for i in left ... right {
                if numbers[i] < result {
                    result =  numbers[i]
                }
            }
            return result
        }
        
        var leftIndex:Int = 0
        var rightIndex:Int = numbers.count - 1
        var midInex:Int = 0 // 最终所求的index
        while numbers[leftIndex] >=  numbers[rightIndex] { // 有可能数组就是从小到大
            if rightIndex - leftIndex == 1 {
                midInex = rightIndex
                break
            } else if rightIndex - leftIndex == 0 {
                midInex = rightIndex
                break
            }
            midInex = (rightIndex + leftIndex) / 2
            // [1,0,1,1,1] 和 [1,1,1,0,1] 开头结尾和中间的值相等,无法区分
            if numbers[leftIndex] == numbers[midInex],numbers[leftIndex] == numbers[rightIndex] {
                return getLowInOrder(left: leftIndex, right: rightIndex, arr: numbers)
            }
            if numbers[midInex] < numbers[leftIndex] { // 相等的情况要注意
                rightIndex = midInex
            } else if numbers[midInex] >= numbers[midInex]{
                leftIndex = midInex
            }
        }
        return numbers[midInex]
    }
}

extension Solution {
    // 剑指 Offer 12. 矩阵中的路径
    // https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/
    // 给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false
    func exist(_ board: [[Character]], _ word: String) -> Bool { // 深度优先搜索法(递归法,回溯法)
        
        func getCharacter(lIndex:Int,letter:String) -> Character {
            let index = letter.index(letter.startIndex, offsetBy: lIndex)
            return letter[index]
        }
        
        func findLetter(iV:Int,jV:Int,lIndex:Int,letter:String,array:[[Character]],usedArr: inout [[Int]]) -> Bool {
            let char:Character = getCharacter(lIndex: lIndex, letter: letter)
            if char != array[iV][jV] {
                return false
            }
            if lIndex == letter.count - 1 {
                return true
            }
            usedArr[iV][jV] = 1
            // 这里取所有可能的结果的并集
            if iV - 1 >= 0 ,usedArr[iV - 1][jV] == 0 {
                if findLetter(iV: iV - 1, jV: jV, lIndex: lIndex + 1, letter: letter, array: array, usedArr: &usedArr) {
                    return true
                }
            }
            if iV + 1 < array.count, usedArr[iV + 1][jV] == 0 {
                if  findLetter(iV: iV + 1, jV: jV, lIndex: lIndex + 1, letter: letter, array: array, usedArr: &usedArr) {
                    return true
                }
            }
            if jV - 1 >= 0 , usedArr[iV][jV - 1] == 0 {
                if  findLetter(iV: iV , jV: jV - 1, lIndex: lIndex + 1, letter: letter, array: array, usedArr: &usedArr) {
                    return true
                }
            }
            if jV + 1 < array[0].count,usedArr[iV][jV + 1] == 0 {
                if  findLetter(iV: iV , jV: jV + 1, lIndex: lIndex + 1, letter: letter, array: array, usedArr: &usedArr) {
                    return true
                }
            }
            // 递归时,要注意及时清理当前递归分支污染的公共数组
            usedArr[iV][jV] = 0
            return false
        }
        // 寻找字符串的路径
        var usedArr = Array.init(repeating: Array.init(repeating: 0, count: board[0].count), count: board.count)
        for i in 0 ..< board.count {
            for j in 0 ..< board[0].count {
                if findLetter(iV: i, jV: j, lIndex: 0, letter: word, array: board, usedArr: &usedArr) {
                    return true
                }
            }
        }
        return false
    }
}

