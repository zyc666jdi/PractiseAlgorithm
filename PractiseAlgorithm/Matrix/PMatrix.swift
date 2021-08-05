//
//  PMatrix.swift
//  PractiseAlgorithm
//
//  Created by zhaoyc on 2021/7/24.
//  Copyright © 2021 List. All rights reserved.
//

import Foundation

extension Solution {
    
//    ---------
//    1   2   3  4
//    5   6   7  8    => []
//    9   10  11 12
//    ---------
    // 从外到内打印一个矩阵的所有元素
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        let rowCount:Int = matrix.count
        let columnCount:Int = matrix.first?.count ?? 0
        let minTime:Int = min(rowCount / 2, columnCount / 2)
        var dscArray:[Int] = []
        for i in 0 ..< minTime {
            for j in i ... (columnCount - 1 - i) {
                dscArray.append(matrix[i][j])
            }
            if i + 1 <= (rowCount - 1 - i - 1) {
                for j in (i + 1) ... (rowCount - 1 - i - 1) {
                    dscArray.append(matrix[j][columnCount - 1 - i])
                }
            }
            for j in (i ... (columnCount - 1 - i)).reversed() {
                dscArray.append(matrix[rowCount - 1 - i][j])
            }
            if i + 1 <= (rowCount - 1 - i - 1) {
                for j in (i + 1 ... (rowCount - 1 - i - 1)).reversed() {
                    dscArray.append(matrix[j][i])
                }
            }
        }
        if rowCount > 2 * minTime , columnCount > 2 * minTime {
            if rowCount > columnCount {
                for j in minTime ... (rowCount - 1 -  minTime) {
                    dscArray.append(matrix[j][minTime])
                }
            } else {
                for j in minTime ... (columnCount - 1 - minTime) {
                    dscArray.append(matrix[minTime][j])
                }
            }
        }

        return dscArray
    }
}
