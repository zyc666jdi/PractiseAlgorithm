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
            if numbers[midInex] < numbers[leftIndex] {
                rightIndex = midInex
            } else if numbers[midInex] >= numbers[midInex]{
                leftIndex = midInex
            }
        }
        return numbers[midInex]
    }
}

