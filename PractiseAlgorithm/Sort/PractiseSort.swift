//
//  PractiseSort.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/18.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

class PractiseSort: NSObject {
    
    override init() {
        super.init()
//        var array = [2,1,6,3,4,5];
//        self.sleepSort(array: array)
//        self.monkeySort(array: array)
//        try? quickSort(arr: &array, start: 0, end: array.count - 1)
        
//        var array = [4,5,7,9,11,13,15,17,19,2,3,4];
//        array = [1,0,1,1,1]
//        array = [1,1,1,0,1]
//        let element = try? self.findMinELementInSpecialArray(arr: array)
//        print("findMinELementInSpecialArray:",String(element ?? 0));
//        print("findMinELementInSpecialArray1:",String(element ?? 0));
        
//          testSortArray()
        
    }
    
    // MARK: 对数组进行排序,使奇数在前,偶数在后
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/21_ReorderArray/ReorderArray.cpp
      func testSortArray(){
            var array = [1,3,4,7,8];
            testCaseSortArray(arr: &array)
        }
        
        func testCaseSortArray(arr:inout [Int] ) {
    //        sortArray(arr: &arr)
            sortArray(arr: &arr, rule: fit(a:))
            var currentFit = true;
            var flag = true;
            for item in arr {
                if !fit(a: item) {
                    currentFit = false;
                }
                if currentFit == false,fit(a: item) {
                    debugPrint("\(item)不符合")
                    flag = false;
                    break;
                }
            }
            if flag {
                    debugPrint(arr);
            }
        }
        
        // 函数作为参数传递,提高代码复用性
        func sortArray(arr:inout [Int],rule:(Int) ->Bool) {
            var left:Int = 0;
            var right:Int = arr.count - 1;
            while left < right {
                while rule(arr[left]),left < right {
                    left += 1
                }
                while !rule(arr[right]),left < right {
                    right -= 1
                }
                let tmp = arr[left]
                arr[left] = arr[right]
                arr[right] = tmp
            }
        }
        
        func sortArray(arr:inout [Int]) {
            var left:Int = 0;
            var right:Int = arr.count - 1;
            while left < right {
                while fit(a: arr[left]),left < right {
                    left += 1
                }
                while !fit(a: arr[right]),left < right {
                    right -= 1
                }
                let tmp = arr[left]
                arr[left] = arr[right]
                arr[right] = tmp
            }
        }
        // 判断是否是偶数
        func fit(a:Int) ->Bool {
            if a & 0x01 == 1 {
                return true
            } else {
                return false;
            }
        }
    
    // 旋转数组中查找最小值, [3,4,5,1,2] ,时间复杂度比n小
    // 二分法查找
    func findMinELementInSpecialArray(arr:[Int]) throws ->Int{
        if arr.count <= 1 {
            throw NSError.init(domain: "非法输入", code: 0)
        }
        var left = 0;
        var right = arr.count - 1;
        var middle = left;
        while arr[left] >= arr[right] {
            if right - left == 1 {
                return arr[right];
            }
            middle = (right + left) / 2;
            // 特殊情况 [1,0,1,1,1] || [1,1,1,0,1] middle无法确定是在第一个递增数组 还是第二个
            if arr[left] == arr[right] && arr[left] == arr[middle] {
                return specialHandle(arr: arr, left: left, right: right, middle: middle);
            }
            if arr[middle] >= arr[left] {
                left = middle
            } else if arr[middle] <= arr[right] {
                right = middle
            }
        }
        return arr[middle];
    }
    
    func specialHandle(arr:[Int],left:Int,right:Int,middle:Int) ->Int {
        var result = left;
        for element in left...right{
            if result >= element {
                result = element
            }
        }
        return result;
    }
    
    
    // 快速排序,是对冒泡排序的一种改进,时间复杂度为n*logn
    // 剑offer.查找和排序
    func sortArrayToIndex(arr:inout [Int],start:Int,end:Int) throws -> Int {
        if arr.count == 0 || start < 0 || end >= arr.count || start >= end {
            throw NSError(domain: "参数不对", code: 1);
        }
        let index = Int(arc4random()) % (end - start) + start;
        try? exchangeValue(&arr, index, end)
        var min = start - 1;
        for var i in start..<end {
            if arr[i] < arr[end] {
                min += 1
                if (min != i) {
                   try? exchangeValue(&arr, min, i);
                }
            }
            i += 1;
        }
        min += 1
        try? exchangeValue(&arr, min, end)
        return min;
    }
    
    func quickSort (arr:inout [Int],start:Int,end:Int) throws {
        if start == end {
            return;
        }
        if arr.count == 0 || start < 0 || end >= arr.count {
            throw NSError(domain: "参数不对", code: 1);
        }
        if  let index = try? sortArrayToIndex(arr: &arr, start: start, end: end) {
            if (index > start) {
                try? quickSort(arr: &arr, start: start, end: index - 1)
            }
            if (index < end) {
                try? quickSort(arr: &arr, start: index + 1, end: end)
            }
        }
    }
    
    func exchangeValue<T>(_ arr:inout [T],_ a:Int,_ b:Int) throws {
        if a < 0 || b < 0 || a >= arr.count || b >= arr.count {
            throw NSError(domain: "参数错误", code: 1)
        }
        (arr[a],arr[b]) = (arr[b],arr[a])
    }
    //MARK :桶排序
    // 给个公司的员工年龄排序,几万名员工,允许使用O(n)的辅助空间
    func sort(arr:inout [Int]) throws  {
        if arr.count == 0 {
            return;
        }
        var ageCount:[Int] = [];
        for i in 0...99 {
            ageCount[i] = 0;
        }
        for i in 0...(arr.count - 1) {
            if arr[i] < 0 || arr[i] > 99 {
                throw NSError(domain: "非法输入", code: 1)
            }
            ageCount[arr[i]] += 1;
        }
        var sortArr:[Int] = [];
        var index = 0;
        for i in 0..<ageCount.count {
            while ageCount[i] > 0{
                ageCount[i] -= 1;
                sortArr[index] = i;
                index += 1
            }
        }
        arr = sortArr;
    }
    
  
//MARK: 另类
    func sleepSort(array:[Int]){
        let globalQueue = DispatchQueue.global(qos: .default)
        for count in array {
            globalQueue.asyncAfter(deadline: .now() ) {
                Thread.sleep(forTimeInterval: TimeInterval(count))
                print("%ld-%@",count,Thread.current)
            }
        }
    }
    
    func monkeySort(array:[Int]){
        var dscArray = array
        var stack = array;
        var totalTimes:Int = 0
        while self._sort(array: dscArray) == false {
            dscArray = [Int]()
            stack = array;
            while stack.count > 0 {
                if stack.count == 1{
                    dscArray.append(stack.removeLast())
                } else {
                    dscArray.append(stack.remove(at: Int(arc4random()) % stack.count))
                }
            }
            totalTimes += 1
        }
        print(dscArray);
        print("totalTimes:",totalTimes);
    }
    
    func _sort(array:[Int]) -> Bool {
        var tmp = array.first ?? 0
        for num in array {
            if num < tmp {
                return false
            } else {
                tmp = num
            }
        }
        return true
    }
    
}
