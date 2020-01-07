//
//  Array.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation
///大于某个数字放右边，小于放左边
func partitionDutch<T: Comparable>(origin: inout Array<T>, pivot: T) {
    var left = 0
    var right = origin.count - 1
    var index = left
    while index <= right {
        if origin[index] > pivot {
            cx_swap(&origin, index1: index, index2: right)
            right -= 1
        } else if origin[index] < pivot {
            cx_swap(&origin, index1: index, index2: left)
            left += 1
            index += 1
        } else {
            index += 1
        }
    }
}

///找最大，或者第二大数
func findSecondNum<T: Comparable>(origin: Array<T>) -> T {
    var max = origin.first!
    var second = max
    for value in origin {
        if max < value {
            second = max
            max = value
        }
    }
    
    return second
}

///合并两个有序数组
func mergeMutipleArray<T: Comparable>(origin1: Array<T>, origin2: Array<T>) -> Array<T> {
    var result = Array<T>()
    var index1 = 0
    var index2 = 0
    while true {
        guard index1 < origin1.count else {
            result.append(contentsOf: Array(origin2[index2..<origin2.count]))
            break
        }
        guard index2 < origin2.count else {
            result.append(contentsOf: Array(origin1[index1..<origin1.count]))
            break
        }
        
        if origin1[index1] < origin2[index2] {
            result.append(origin1[index1])
            index1 += 1
        } else {
            result.append(origin2[index2])
            index2 += 1
        }
    }
    
    return result
}
///旋转数组

///数组所有子数组(DFS)
func allSubSet<T: Comparable>(origin: inout Array<T>) -> Array<Array<T>> {
    var stack = Array<T>()
    var result = Array<Array<T>>()
    allSubSet_dfs(origin: &origin, result: &result, stack: &stack, start: 0)
    
    return result
}

private func allSubSet_dfs<T: Comparable>(origin: inout Array<T>, result: inout Array<Array<T>>, stack: inout Array<T>, start: Int) {
    if !stack.isEmpty {
        result.append(stack)
    }
    for i in start..<origin.count {
        stack.append(origin[i])
        allSubSet_dfs(origin: &origin, result: &result, stack: &stack, start: i + 1)
        stack.removeLast()
    }
}

///数组全排列
func permation<T: Comparable>(origin: inout Array<T>) -> Array<Array<T>> {
    var result = Array<Array<T>>()
    permation_dfs(origin: &origin, result: &result, start: 0)
    
    return result
}

private func permation_dfs<T: Comparable>(origin: inout Array<T>, result: inout Array<Array<T>>, start: Int) {
    if start == origin.count {
        result.append(origin)
    }
    for i in start..<origin.count {
        cx_swap(&origin, index1: i, index2: start)
        permation_dfs(origin: &origin, result: &result, start: i + 1)
        cx_swap(&origin, index1: i, index2: start)
    }
}
