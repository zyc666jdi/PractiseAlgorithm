//
//  Practise.swift
//  PractiseAlgorithm
//
//  Created by List on 2020/6/9.
//  Copyright © 2020 List. All rights reserved.
//

import Foundation

class PractiseValue: NSObject {
    
    override init () {
        super.init()
        
        let arr:[Int] = [2,1,3,7,5]
        let result =  findHasTwoElementAddWithIndex(arr,6)
        print(result)
    
    }
    
    // 求数组中是否包含两个数的和等于目标值
    func findHasTwoElementAdd(_ arr:[Int],_ target:Int) -> Bool {
        var set = Set<Int>()
        for (element) in arr {
            if set.contains(target -  element) {
                return true;
            } else {
                set.insert(element)
            }
        }
        return false;
    }
    
    // 求数组中是否包含两个数的和等于目标值,并返回这两个数的序号
    func findHasTwoElementAddWithIndex(_ arr:[Int],_ target:Int) -> (Int,Int,Bool){
        var dic = [Int:Int]()
        for (index,element) in arr.enumerated() {
            if dic[target - element] != nil {
                return (index,dic[target - element]!,true)
            } else {
                dic[element] = index
            }
        }
        return (0,0,false);
    }
    
}
