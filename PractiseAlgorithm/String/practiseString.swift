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
        self.sortString(str: "aabb")
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
