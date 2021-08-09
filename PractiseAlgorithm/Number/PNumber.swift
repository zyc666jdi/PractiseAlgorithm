//
//  PNumber.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/7/28.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution {
    // 剑指 Offer 17. 打印从1到最大的n位数
    // https://leetcode-cn.com/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof/submissions/
    func printNumbers(_ n: Int) -> [Int] {
        var array:[Int] = []
        var maxNum:Int = 0
        for _ in 0 ..< n {
            maxNum = 10 * maxNum + 9
        }
        for i in 1 ... maxNum {
            array.append(i)
        }
        return array
    }
    // 如果n很大,可能溢出,所以将数字转换为字符串储存
    func printNumbers1(_ n: Int) -> [Int] {
        
        func getNumber(str:[String]) -> Int {
            var isBegin:Bool = false
            var num:Int = 0
            for e in str {
                if e != "0",isBegin == false {
                    isBegin = true
                    num = Int(e) ?? 0
                } else if isBegin == true {
                    num = 10 * num + (Int(e) ?? 0)
                }
            }
            return num
        }
        
        var finalArr:[Int] = []
        var numString:[String] = Array.init(repeating: "0", count: n)
        var isOverFlow:Bool = false
        while !isOverFlow {
            var plus:Int = 0
            for i in (0 ..< n).reversed() {
                var num = Int(numString[i]) ?? 0 + plus
                num += 1
                if num >= 10 {
                    plus = 1
                    numString[i] = String(0)
                    if i == 0 {
                        isOverFlow = true
                    }
                } else {
                    plus = 0
                    numString[i] = String(num)
                    break
                }
            }
            let result = getNumber(str: numString)
            if result > 0 {
                finalArr.append(result)
            }
        }
        return finalArr
    }
    
    // 全排列
    func printNumbers2(_ n: Int) -> [Int] {
        var datas:[Int]  = []
        
        func getNumber(numString:[String]) -> Int {
            var num:Int = 0
            var isBegin:Bool = false
            for ele:String in numString {
                if isBegin == false, ele != "0" {
                    isBegin = true
                }
                if isBegin {
                    num = 10 * num + (Int(ele) ?? 0)
                }
            }
            return num
        }
        
        func createNum(index:Int,maxIndex:Int,str:[String],arr:inout [Int]) {
            if index > maxIndex { // 递归的退出条件
                let num = getNumber(numString: str)
                if num > 0 {
                    arr.append(num)
                }
                return
            }
            var dscStr:[String] = str
            for i in 0 ... 9 {
                dscStr[index] = String(i)
                 createNum(index: index + 1, maxIndex: maxIndex, str: dscStr, arr: &arr)
            }
        }
        
        let rawStr = Array.init(repeating: "0", count: n)
        createNum(index: 0, maxIndex: n - 1, str: rawStr, arr: &datas)
        return datas
    }
}

extension Solution {
    // 剑指 Offer 16. 数值的整数次方
    // https://leetcode-cn.com/problems/shu-zhi-de-zheng-shu-ci-fang-lcof/
    // 注意:n可能特别大,x可能小数点位数比较多,导致计算时间很长,
    func myPow(_ x: Double, _ n: Int) -> Double {
        func halfDouble(_ x: Double, _ n: Int) -> Double { // 将n的数目减少一半,运算过程减少一半
            if n == 1 {
                return x
            }
            var tmp = halfDouble(x, n >> 1)
            tmp *= tmp
            if n & 0x1 == 1 {
                tmp *= x
            }
            return tmp
        }
        if n == 0 {
            return 1
        }
        let dscN:Int = n > 0 ? n : -n
        var result:Double = halfDouble(x, dscN)
        if n < 0 {
            result = 1 / result
        }
        return result
    }
}

extension Solution {
    // 剑指 Offer 15. 二进制中1的个数
    // https://leetcode-cn.com/problems/er-jin-zhi-zhong-1de-ge-shu-lcof/
    func hammingWeight(_ n: Int) -> Int { // 思路同 16 题
        var count:Int = 0
        var num:Int = n
        while num > 0 {
            if num & 0x1 == 1 {
                count += 1
            }
            num = num >> 1
        }
        return count
    }
}

extension Solution {
    // 剑指 Offer 10- I. 斐波那契数列
    // https://leetcode-cn.com/problems/fei-bo-na-qi-shu-lie-lcof/
    // 写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项（即 F(N)）
    func fib(_ n: Int) -> Int { // 此题为动态规划思路,如果用递归,性能很差
        if n == 0 {
            return 0
        }
        var Fi:Int = 1
        var Faux:Int = 0
        var i:Int = 1
        while i  < n {
            let nexValue = Fi + Faux
            Faux = Fi
            // 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。
            Fi = nexValue > 1000000007 ? nexValue - 1000000007 : nexValue //
            i += 1
        }
        return Fi
    }
}

extension Solution {
    // 剑指 Offer 10- II. 青蛙跳台阶问题
    // https://leetcode-cn.com/problems/qing-wa-tiao-tai-jie-wen-ti-lcof/
    // 一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。
    func numWays(_ n: Int) -> Int {
        // F(n) = F(n - 1)              +           F(n - 2)
        //        跳一次,还沙僧下n - 1个台阶      跳2个台阶,还剩下n - 2 个台阶
        if n == 0 {
            return 1
        }
        var Fi = 1
        var Faux = 1
        var i = 1
        while  i < n {
            let nextValue = Fi + Faux
            Faux = Fi
            Fi = nextValue > 1000000007 ? nextValue - 1000000007 : nextValue
            i += 1
        }
        return Fi
    }
}
