//
//  PractiseMatrix.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2020/8/21.
//  Copyright © 2020 List. All rights reserved.
//

import UIKit

class PractiseMatrix: NSObject {
    
    
    override init() {
        super.init()
        
//        testPrintMatrix()
        
    }
    
    //MARK: - 从外到内打印一个矩阵的所有元素
    // https://github.com/zhulintao/CodingInterviewChinese2/blob/master/29_PrintMatrix/PrintMatrix.cpp
    
    func testPrintMatrix() {
        testCasePrintMatrix1()
        testCasePrintMatrix2()
        testCasePrintMatrix4()
        testCasePrintMatrix5()
        testCasePrintMatrix15()
        testCasePrintMatrix25()
        testCasePrintMatrix35()
        testCasePrintMatrix45()
        testCasePrintMatrix51()
        testCasePrintMatrix52()
        testCasePrintMatrix53()
        testCasePrintMatrix54()
    }
    
    func testCasePrintMatrix1() {
        let matrix1 = constructMatrix(rowNums: 1, columnNums: 1)
        printMatrix(arr: matrix1)
         debugPrint("testCasePrintMatrix1_success_打印正确")
    }
    
    func testCasePrintMatrix2() {
        let matrix = constructMatrix(rowNums: 2, columnNums: 2)
        printMatrix(arr: matrix)
         debugPrint("testCasePrintMatrix1_success_打印正确")
    }
    
    
    func testCasePrintMatrix4() {
        let matrix4 = constructMatrix(rowNums: 4, columnNums: 4)
        printMatrix(arr: matrix4)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix5() {
        let matrix = constructMatrix(rowNums: 5, columnNums: 5)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix15() {
        let matrix = constructMatrix(rowNums: 1, columnNums: 5)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix25() {
        let matrix = constructMatrix(rowNums: 2, columnNums: 5)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix35() {
        let matrix = constructMatrix(rowNums: 3, columnNums: 5)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix45() {
        let matrix = constructMatrix(rowNums: 4, columnNums: 5)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix51() {
           let matrix = constructMatrix(rowNums: 5, columnNums: 1)
           printMatrix(arr: matrix)
           debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix52() {
        let matrix = constructMatrix(rowNums: 5, columnNums: 2)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix53() {
        let matrix = constructMatrix(rowNums: 5, columnNums: 3)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    
    func testCasePrintMatrix54() {
        let matrix = constructMatrix(rowNums: 5, columnNums: 4)
        printMatrix(arr: matrix)
        debugPrint("testCasePrintMatrix4_success_打印正确")
    }
    

    private func constructMatrix(rowNums:Int,columnNums:Int) -> [[Int]]{ // rowNums:有多少列,columnNums:有多少行
        var matrix:[[Int]] = []
        for i in 0 ..< columnNums {
            var rowArray:[Int] = []
            for j in 0 ..< rowNums {
                let value:Int = i * rowNums + j + 1
                rowArray.append(value)
            }
            matrix.append(rowArray)
        }
        printOriginMatrix(matrix: matrix)
        return matrix
    }
    
    private func printOriginMatrix(matrix:[[Int]]) {
        for rowArray in matrix {
            var string:String = String()
            for i in rowArray {
                string.append(String.init(format: "%.2d ", i))
            }
            debugPrint(string)
        }
    }
    
    
    func printMatrix(arr:[[Int]]){
        var start:Int = 0
        let rowNum = arr[0].count
        let columnNum = arr.count
        while rowNum > 2 * start,columnNum > 2 * start {
            printNumberInMatrixCircle(arr: arr, start: start)
            start += 1
        }
    }
    
    func printNumberInMatrixCircle(arr:[[Int]],start:Int) {
        var valueToPrint:[Int] = []
        let rowNum = arr[0].count
        let columnNum = arr.count
        let endX = rowNum - start - 1
        let endY = columnNum - start - 1
        for i in start ... endX {
            valueToPrint.append(arr[start][i])
        }
        if endY - start  > 0 {
            for i in (start + 1) ... endY {
                valueToPrint.append(arr[i][rowNum - start - 1])
            }
        }
        if endX  - start  > 0 , endY > start {
            for i in (start ... (endX - 1)).reversed() {
                valueToPrint.append(arr[columnNum - start -  1][i])
            }
        }
        if endY  - ( start  + 1) > 0 , endX > start {
            for i in ((start + 1) ... (endY - 1 )).reversed() {
                valueToPrint.append(arr[i][start])
            }
        }
        debugPrint(valueToPrint)
    }
    
    
}
