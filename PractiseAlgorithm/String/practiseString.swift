//
//  practiseString.swift
//  PractiseAlgorithm
//
//  Created by List on 2019/12/21.
//  Copyright © 2019 List. All rights reserved.
//

import UIKit

class practiseString: NSObject {
    
    override init() {
        super.init()
        //        let string = self.replaceString(str: "We are happy")
        //        print(string)
//        self.sortString(str: "aabb")
        testMatch();
    }
    
    // MARK: 正则表达式
    // 判断字符串与模式是否匹配,.代表任意的字符串,*代表前面的字符可以出现任意次数
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/19_RegularExpressionsMatching/RegularExpressions.cpp
    func testMatch(){
        testCaseMatch(str: "aaa", pattern: "a.a", expect: true)
        testCaseMatch(str: "aaa", pattern: "ab*ac*a", expect: true)
        testCaseMatch(str: "aaa", pattern: "ab*a", expect: false)
    }
    
    func testCaseMatch(str:String,pattern:String,expect:Bool) {
        let result =  match(str: str, pattern: pattern)
        if result != expect {
            debugPrint("testCaseMatch_failure",String(result))
        } else {
            debugPrint("testCaseMatch_Pass",String(expect))
        }
    }
    
    func match(str:String,pattern:String) ->Bool {
        return   matchCore(str: str, pattern: pattern, left: 0, right: 0)
    }
    
    func matchCore(str:String,pattern:String,left:Int,right:Int) ->Bool {
        if left == str.length , right == pattern.length {
            return true
        } else if left >= str.count || right >= pattern.count {
            return false;
        }
        if pattern[right + 1] == "*" {
            if pattern[right] == "." || str[left] == pattern[right] {
                return  matchCore(str: str, pattern: pattern, left: left, right: right + 2) ||  matchCore(str: str, pattern: pattern, left: left + 1, right: right + 2) ||  matchCore(str: str, pattern: pattern, left: left + 1, right: right)
            } else {
                return  matchCore(str: str, pattern: pattern, left: left, right: right + 2)
            }
        } else {
            if pattern[right] == "." || str[left] == pattern[right] {
                return  matchCore(str: str, pattern: pattern, left: left + 1, right: right + 1)
            } else {
                return false;
            }
        }
    }
    
    
    
    // 将"We are happy"中的空格替换为"%20"
    func replaceString(str:String) -> String {
        let strArray = str.map {
            return String($0)
        }
        let strCount = str.count
        var spaceCount:Int = 0
        for charString in strArray {
            if charString.elementsEqual(" ") {
                spaceCount += 1
            }
        }
        let  dscCount = strCount + (3 - 1) * spaceCount
        var strIndex:Int = strArray.count - 1
        var dscStrIndex:Int = dscCount - 1
        var dscArray:[String] = [String](repeating: "", count: dscCount)
        while strIndex >= 0 {
            if strArray[strIndex] != " " {
                dscArray[dscStrIndex] = strArray[strIndex]
                strIndex -= 1
                dscStrIndex -= 1
            } else {
                dscArray[dscStrIndex] = "0"
                dscStrIndex -= 1
                dscArray[dscStrIndex] = "2"
                dscStrIndex -= 1
                dscArray[dscStrIndex] = "%"
                dscStrIndex -= 1
                strIndex -= 1
            }
        }
        return dscArray.joined(separator: "")
    }
    
    // 将'aabb'等字符串,排列出所有的组合,并去重
    func sortString(str:String) ->[String] { // 宽度优先搜索法
        var finalArray = [["":str.map { String($0)}]]
        print("before",finalArray)
        while finalArray.count > 0 && finalArray.first?.keys.first?.count != str.count {
            var tmpArray = finalArray;
            let firstElement = finalArray.first!
            let key = firstElement.keys.first!
            let value = firstElement[key]!
            var keyDic:[String:String] = [:]
            for (index,_ ) in value.enumerated() {
                var tmpValue = value;
                let tmpStr = tmpValue.remove(at: index)
                if keyDic[tmpStr] == nil {
                    tmpArray.append([key + tmpStr:tmpValue])
                    keyDic[tmpStr] = "";
                }
            }
            tmpArray.remove(at: 0)
            finalArray = tmpArray;
        }
        print("after",finalArray)
        let handleArray = finalArray.map { (element) in
            return (element.keys.first ?? "")
        }
        print("handle",handleArray)
        return handleArray;
    }
}


// MARK: - Tool 字符串截取
// swift 5.2
//let str = "abcdef"
//str[1 ..< 3] // returns "bc"
//str[5] // returns "f"
//str[80] // returns ""
//str.substring(fromIndex: 3) // returns "def"
//str.substring(toIndex: str.length - 2) // returns "abcd"

extension String {
    
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
