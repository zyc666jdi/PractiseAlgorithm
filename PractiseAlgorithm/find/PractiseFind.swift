//
//  PractiseFind.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/20.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

class PractiseFind: NSObject {
    
    override init() {
        super.init()
//        var array:[[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]];
//        let result = self.hasELementInArray(arr: array, element: 7, rows: 4, columns: 4)
//        print("result:%ld",result);
//        let result = findFibonacciSequenceWithDynamicProgram(n: 7)
//        print("result",result);
        
//        testFindMachineCount()
        
//        testFindMaxDivideMultiple();
        
        testFindMaxMultipleUseGreedy()
    }
    
    // MARK: 减绳子 -- 动态规划
    // 一段长度为m的绳子,剪成n段,每一段都是整数,m,n也都是整数,求怎样减,能使减掉的各段的乘积最大值
    // 动态规划: 1> 这个问题可以分解成若干的小问题   2> 小问题有最优解 3> 小问题在大问题分解的过程中重复出现,为了避免,可以把小问题储存起来
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/14_CuttingRope/CuttingRope.cpp
    
    func testFindMaxDivideMultiple() {
        testCaseFindMaxDivideMultiple(length: 4, expect: 4)
        testCaseFindMaxDivideMultiple(length: 5, expect: 6)
        testCaseFindMaxDivideMultiple(length: 6, expect: 9)
        testCaseFindMaxDivideMultiple(length: 7, expect: 12)
        testCaseFindMaxDivideMultiple(length: 8, expect: 18)
    }
    
    func  testCaseFindMaxDivideMultiple(length:Int,expect:Int){
        let result = findMaxDivideMultiple(length: length)
        if result == expect {
            print("testCaseFindMaxDivideMultiple_success",String(length));
        } else {
            print("testCaseFindMaxDivideMultiple_failure",String(length),"current",String(result));

        }
    }
    
    func findMaxDivideMultiple(length:Int) ->Int {
        if length == 0 {
            return 0
        } else if length == 1 {
            return 0
        } else if length == 2 {
            return 1
        } else if length == 3 {
            return 2
        }
        var arr = Array(repeating: 0, count: length + 1)
        arr[0] = 0;
        arr[1] = 1;
        arr[2] = 2;
        arr[3] = 3;
        var max = 0
        for i in 4 ... length {
            max = 0;
            for j in 1 ... i/2 {
                let tmp = arr[j]*arr[i - j];
                if tmp > max {
                    max = tmp
                    arr[i] = max
                }
            }
        }
        return arr[length];
    }
    
    // MARK: 剪绳子 -- 贪婪算法
    // 当 n >= 5 时,3 * (n - 3) > n , 2 * (n - 2) > n ,并且 3 * (n -3) >= 2 * (n - 2) ,所以绳子足够长时,尽量减 3 的长度
    func testFindMaxMultipleUseGreedy(){
        testCaseFindMaxMultipleUseGreedy(n: 0, expect: 0)
        testCaseFindMaxMultipleUseGreedy(n: 4, expect: 4)
        testCaseFindMaxMultipleUseGreedy(n: 5, expect: 6)
        testCaseFindMaxMultipleUseGreedy(n: 6, expect: 9)
        testCaseFindMaxMultipleUseGreedy(n: 8, expect: 18)
    }
    func testCaseFindMaxMultipleUseGreedy(n:Int,expect:Int) {
        let result = findMaxMultipleUseGreedy(n: n)
        if result == expect {
            print("testCaseFindMaxMultipleUseGreedy_success",String(n));
        } else {
            print("testCaseFindMaxMultipleUseGreedy_failure",String(n),"current",String(result));

        }
    }
    
    func findMaxMultipleUseGreedy(n:Int) -> Int{
        if (n == 0) {
            return 0
        } else if (n == 1 ) {
            return 1
        } else if (n == 2) {
            return 2
        } else  if (n == 3) {
            return 3
        }
        var timesOfThree = n / 3
        if n % 3 == 1 {
            timesOfThree -= 1
        }
        let timesOfTwo = (n - 3 * timesOfThree) / 2
        return Int(truncating:pow(3, timesOfThree) as NSNumber ) * Int(truncating: pow(2, timesOfTwo) as NSNumber)
    }
    
    
    // MARK:机器人达到的格子数
    // 机器人能到达的格子数目, m 行 n列 , 不能进入横坐标和列坐标位的各个位置的数字之和大于k的格子,求机器人所有的格子数目
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/13_RobotMove/RobotMove.cpp
    func testFindMachineCount(){
         testFindMachineCount(m: 10, n: 10, k: 5, expect: 21)
         testFindMachineCount(m: 20, n: 20, k: 15, expect: 359)
         testFindMachineCount(m: 1, n: 100, k: 10, expect: 29)
         testFindMachineCount(m: 100, n: 1, k: 15, expect: 79)
         testFindMachineCount(m: 1, n: 1, k: 0, expect: 1)
         testFindMachineCount(m: 10, n: 10, k: -10, expect: 0)
    }
    
    func testFindMachineCount(m:Int,n:Int,k:Int,expect:Int) {
        do {
            let result = try findMachineCount(m: m, n: n, k: k)
            if result != expect {
                debugPrint("testFindMachineCount_failure",String(result))
            } else {
                debugPrint("testFindMachineCount_Pass",String(expect))
            }
        } catch let err as NSError {
            debugPrint("testFindMachineCount_Error",err);
        }
    }
    
    func findMachineCount(m:Int,n:Int,k:Int) throws -> Int {
        if m <= 0 || n <= 0 || k < 0 {
            throw NSError.init(domain: "非法输入", code: 0);
        }
        var numArr = Array(repeating: Array(repeating: 0, count: n), count: m)
        let  count = findMachineCountCore(m: m, n: n, k: k, x: 0, y: 0, numArr: &numArr)
        return count;
    }
    
    func findMachineCountCore(m:Int,n:Int,k:Int,x:Int,y:Int,numArr : inout [[Int]]) -> Int {

        if x >= 0,x < m, y >= 0,y < n , getNumCount(x: x) + getNumCount(x: y) <= k , numArr[x][y] == 0 {
            numArr[x][y] = 1
            return 1 + findMachineCountCore(m: m, n: n, k: k, x: x + 1, y: y, numArr: &numArr) + findMachineCountCore(m: m, n: n, k: k, x: x , y: y + 1, numArr: &numArr) + findMachineCountCore(m: m, n: n, k: k, x: x - 1, y: y, numArr: &numArr) + findMachineCountCore(m: m, n: n, k: k, x: x, y: y - 1, numArr: &numArr)
        }
        return 0;
    }
    
    func getNumCount(x:Int) -> Int{
        var tmp = x;
        var num = 0;
        while tmp > 0 {
            num += tmp % 10
            tmp = tmp / 10
        }
        return num;
    }
    
    
    // MARK:斐波那锲数列
    // 查找斐波那契额数列的d第n项
    // 递归缺点:1.每次入栈需要储存参数,临时变量,返回值,空间消耗大,每次入栈出栈需要消耗时间,性能比较差
    // 2.大量的重复计算
    
    // 类似:青蛙跳台阶,有时跳1,有时跳2
    // 类似:填积木,有时横着2*1,有时竖着2*1
    func findFiBonacciSequence(n:Int) ->Int {
        if (n <= 0) {
            return 0;
        } else if (n == 1) {
            return 1;
        } else if (n == 2) {
            return 1;
        } else {
            return ( findFiBonacciSequence(n: n - 1) + findFiBonacciSequence(n: n - 2));
        }
    }
    // 动态规划
    func findFibonacciSequenceWithDynamicProgram(n:Int) -> Int{
        if n == 1 || n == 2 {
            return 1;
        }
        var pre = 1;
        var after = 1;
        var result = 1;
        for _ in 3...n {
            result = pre + after;
            pre = after;
            after = result
        }
        return result
    }
    

    // 在一个横向由小到大,纵向由小到大排序的二维数组中,查找元素是否在此数组中
    func hasELementInArray(arr:[[Int]],element:Int,rows:Int,columns:Int) ->Bool{
        if rows < 0 || columns < 0 {
            return false;
        }
        var column = columns - 1
        var row = 0
        while column >= 0 && row <= rows - 1 {
            if arr[row][column] == element {
                return true;
            } else if arr[row][column] > element {
                column -= 1
            } else if arr[row][column] < element {
                row += 1
            }
        }
        return false;
    }
}
