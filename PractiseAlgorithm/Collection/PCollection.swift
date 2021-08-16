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

extension Solution {
    // 剑指 Offer 13. 机器人的运动范围
    // https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof/
    // 地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外,请问该机器人能够到达多少个格子？
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int { // 思路同12
        
        func canLocationIfNeed(i:Int,j:Int,m:Int,n:Int,k:Int,arr:inout [[Int]],totalCount:inout Int){
            if i < 0 || i >= m ||  j < 0 || j >= n { // 越界
                return
            }
            if arr[i][j] != 0 { // 走过
                return
            }
            var num:Int = 0
            var iV = i
            var jV = j
            while iV > 0{
                num += iV % 10
                iV = iV / 10
            }
            while jV > 0 {
                num += jV % 10
                jV = jV / 10
            }
            if num > k {
                arr[i][j] = -1
                return
            }
            totalCount += 1
            arr[i][j] = 1
            //
            canLocationIfNeed(i: i - 1, j: j, m: m, n: n, k: k, arr: &arr,totalCount: &totalCount)
            canLocationIfNeed(i: i + 1, j: j, m: m, n: n, k: k, arr: &arr,totalCount: &totalCount)
            canLocationIfNeed(i: i , j: j - 1, m: m, n: n, k: k, arr: &arr,totalCount: &totalCount)
            canLocationIfNeed(i: i, j: j + 1, m: m, n: n, k: k, arr: &arr,totalCount: &totalCount)
        }
        // 0:未走过 1:可用 -1:不可用
        var arr:[[Int]] = Array.init(repeating: Array.init(repeating: 0, count: n), count: m)
        var totalCount:Int = 0
        canLocationIfNeed(i: 0, j: 0, m: m, n: n, k: k, arr: &arr,totalCount: &totalCount)
        return totalCount
    }
}

extension Solution {
    // 剑指 Offer 14- I. 剪绳子
    // https://leetcode-cn.com/problems/jian-sheng-zi-lcof/
    // 给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m-1] 。请问 k[0]*k[1]*...*k[m-1] 可能的最大乘积是多少？
    func cuttingRope(_ n: Int) -> Int { // 动态规划(递归反过来)
        
        // 把一段长度为n的子绳子剪多段或不剪的最大值
        func getSubRopeMaxCount(n: Int) -> Int{
            var arr:[Int] = Array.init(repeating: 0, count: n + 1) // 长度为n的绳子的最大结果
            arr[0] = 0
            arr[1] = 1
            arr[2] = 2
            arr[3] = 3
            for i in 4 ... n {
                var maxCount:Int = 0
                for j in 0 ... i / 2 {
                    let tmp = arr[j] * arr[i - j]
                    maxCount = max(maxCount, tmp)
                }
                arr[i] = maxCount
            }
            return arr[n]
        }
        if n == 2 {
            return 1
        } else if n == 3 {
            return 2
        }
        // 对于 n >= 4 的绳子
        let result = getSubRopeMaxCount(n: n)
        return result
    }
}

extension Solution {
    // 剑指 Offer 14- II. 剪绳子 II
    // https://leetcode-cn.com/problems/jian-sheng-zi-ii-lcof/
    // 给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），每段绳子的长度记为 k[0],k[1]...k[m - 1] 。请问 k[0]*k[1]*...*k[m - 1] 可能的最大乘积是多少？答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。
    
    func cuttingRope2(_ n: Int) -> Int { // 贪婪算法 尽可能剪去n = 3 的片段 (由上题的动态规划的数组中可以得到规律)
        // 分割比不分割小
        if n == 0 || n == 1 {
            return 0
        } else if n == 2 {
            return 1
        } else if n == 3 {
            return 2
        }
        // 分割比不分割大
        var letterCountOf3:Int = n / 3
        var letterCountOf2:Int = 0
        if n % 3 == 1 {
            letterCountOf3 -= 1
            letterCountOf2 = 2
        } else if n % 3 == 2 {
            letterCountOf2 = 1
        }
        // n = 120 ,result = 4052555153018976267时,再乘 3 数字会溢出
        var result:Int = 1
        while letterCountOf3 > 0 {
            result = result * 3
            if result > 1000000007 {
                result = result % 1000000007
            }
            letterCountOf3 -= 1
        }
        if letterCountOf2 == 1 {
            result = result * 2
            if result > 1000000007 {
                result = result % 1000000007
            }
        } else if letterCountOf2 == 2 {
            result = result * 2 * 2
            if result > 1000000007 {
                result = result % 1000000007
            }
        }
        return result
    }
}

// 剑指 Offer 30. 包含min函数的栈
// https://leetcode-cn.com/problems/bao-han-minhan-shu-de-zhan-lcof/
// 定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。
class MinStack {  // 注意与最小堆问题的却别
    var storeArr:[Int]  = []
    var sortArr:[Int] = []
    
    init() {
    }
    
    func push(_ x: Int) { // 每次将当前的最小值亚乳栈
        self.storeArr.append(x)
        if sortArr.count > 0 ,let last = sortArr.last ,last < x {
            sortArr.append(last)
        } else {
            sortArr.append(x)
        }
    }
    
    func pop() {
        self.storeArr.removeLast()
        self.sortArr.removeLast()
    }
    
    func top() -> Int {
        return storeArr.last ?? 0
    }
    
    func min() -> Int {
        return sortArr.last ?? 0
    }
}



