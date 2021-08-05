//
//  PCollection.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/6/22.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution { // 两个数组的交集
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
