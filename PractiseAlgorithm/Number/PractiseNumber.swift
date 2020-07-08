//
//  PractiseBit.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2020/7/3.
//  Copyright © 2020 List. All rights reserved.
//

import UIKit

class PractiseNumber: NSObject {
    
    override init() {
        super.init()
//        testCalculateNumberOf1()
//        getAllNumber(n: 3)
//          getAllNumber(n: 3)
        
//        testMyPow()
    }
    
    
    // MARK: - 求 打印从1到 n 位数 的所有值
    // 数值可能很大,超过最大的长整形数
    //  https://github.com/zhulintao/CodingInterviewChinese2/blob/master/17_Print1ToMaxOfNDigits/Print1ToMaxOfNDigits.cpp
    // 方法一:字符转换成整数,相加
    func getAllNumber(n:Int) {
        if n <= 0 {
            return
        }
        var array = Array(repeating: "0", count: n)
        var overFlow = false;
        var change = 0;
        var resultArray:[[String]] = []
        while overFlow == false {
            for i in  (0...array.count-1).reversed(){
                guard var result = Int(array[i]) else {return}
                if i == array.count  - 1 {
                    result += 1
                } else {
                    result += change
                }
                if  result >= 10 {
                    change = 1
                    result -= 10
                    array[i] = String(result)
                    if i == 0 {
                        overFlow = true
                        break;
                    }
                } else {
                    array[i] = String(result)
                    resultArray.append(array)
                    break;
                }
            }
        }
        for arr in resultArray {
            printNumber(arr: arr)
        }
        
        
    }
    
    func printNumber(arr:[String]) {
        var startPrint = false;
        var dscStr = ""
        for (index,str) in arr.enumerated() {
            if  str != "0" || index == 0 {
                startPrint = true
            }
            if startPrint == true {
                dscStr.append(str)
            }
        }
        print(dscStr)
    }
    // 方法2 : 全排列
    func getAllNumberWithSort(n:Int){
        var arr = Array(repeating: "0", count: n)
        getAllNumberWithSortCore(arr: &arr, index: 0, maxIndex: n)
        
    }
    
    func getAllNumberWithSortCore(arr:inout [String] , index:Int,maxIndex:Int) {
        if  index >= maxIndex {
            printNumber(arr: arr)
            return;
        }
        for i in 0...9 {
            arr[index] = String(i)
            getAllNumberWithSortCore(arr: &arr, index: index + 1 , maxIndex: maxIndex)
        }
    }
    
    
    
   // 求一个数的n次方,pow
    func testMyPow(){
        testCaseMyPow(base: 2, exponent: 3, expect: 8)
        testCaseMyPow(base: -2, exponent: 3, expect: -8)
        testCaseMyPow(base: 2, exponent: -3, expect: 0.125)
        testCaseMyPow(base: 2, exponent: 0, expect: 1)
        testCaseMyPow(base: 0, exponent: 0, expect: 1)
        testCaseMyPow(base: 0, exponent: -4, expect: 1)
    }
    
    func testCaseMyPow(base:Int,exponent:Int,expect:Double) {
        do {
            let result =  try myPow(base: base, exponent: exponent)
            if result == expect {
                print("testCaseMyPow","_success",String(base),String(exponent));
            } else {
                print("testCaseMyPow","_failure",String(base),String(exponent),"current",String(result));
                
            }
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }
    
    func myPow(base:Int,exponent:Int) throws -> Double {
        var checkBase = base
        var checkExponent = exponent
        if base == 0 {
            if exponent >= 0 {
                return 1 
            } else {
                throw NSError.init(domain: "非法输入", code: 1, userInfo: nil)
            }
        } else if (base < 0) {
            checkBase = -base;
        }
        if exponent < 0 {
            checkExponent = -exponent
        }
        let result = myPowCore(base: checkBase, exponent: checkExponent)
        if base < 0 {
            return Double(-result)
        }
        if exponent < 0 {
            return 1.0 / Double(result)
        }
        return Double(result)
    }
    
    // 使用for循环,计算次数比较多,可以使用二分法,每次使计算次数减少一半
    // >> 比 除法效率高
    // & 可以判断一个数是奇数还是偶数
    func myPowCore(base:Int,exponent:Int) -> Int {
        var result = 1
        if exponent == 0 {
            return 1
        } else if exponent == 1 {
            return base
        }
        let half = myPowCore(base: base, exponent: exponent >> 1)
        result *= half * half
        if exponent & 0x01 == 1 {
            result *= base
        }
        return result
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
