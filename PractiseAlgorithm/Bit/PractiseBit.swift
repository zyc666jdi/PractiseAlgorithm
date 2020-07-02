//
//  PractiseBit.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2020/7/3.
//  Copyright © 2020 List. All rights reserved.
//

import UIKit

class PractiseBit: NSObject {
    
    override init() {
        super.init()
        testCalculateNumberOf1()
    }
    
    // 输入一个整数,输出一个二进制表示1的个数,不能用字符串.
    // 二进制问题的规律: 一个数 - 1 与 该数的 & 的结果是,该数最右边的一个1变成0
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/15_NumberOf1InBinary/NumberOf1InBinary.cpp
    func testCalculateNumberOf1() {
        testCaseCalculateNumberOf1(num: 0, expect: 0)
        testCaseCalculateNumberOf1(num: 1, expect: 1)
        testCaseCalculateNumberOf1(num: 9, expect: 2)
        testCaseCalculateNumberOf1(num: 0x7FFFFFFF, expect: 31)
        testCaseCalculateNumberOf1(num: 0xFFFFFFFF, expect: 32)
    }
    
    func testCaseCalculateNumberOf1(num:Int,expect:Int) {
        let result = calculateNumberOf1(num: num)
        if result == expect {
            print("testCaseCalculateNumberOf1_success",String(num));
        } else {
            print("testCaseCalculateNumberOf1_failure",String(num),"current",String(result));

        }
    }
    
    // 常规解法: 000000001 不断将1左移 ,将其与num 求 & 得到 1或 0
    // 其他解法:假如num >> 1,结果约等于/2,但比/2性能高,但是如果num是负数,会最终陷入0XFFFF的死循环,得不到正确答案 
    func commonCalculateNumberOf1(num:Int) -> Int{
        var test = 1;
        var numOf1 = 0
        var numOfCount = 0 // 执行运算的次数,64
        while test > 0 {
            if num & test > 0 {
                numOf1 += 1;
            }
            test = test << 1
            numOfCount += 1
        }
        return numOf1;
    }
    
    func calculateNumberOf1(num:Int) -> Int{
        var a = num
        var numberOf1 = 0
        while a > 0 {
            a = (a - 1) & a
            numberOf1 += 1
        }
        return numberOf1;
    }
}
