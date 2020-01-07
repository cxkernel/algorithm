//
//  Other.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/7/14.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation

//Two-Sum Problem
func twoSum(origin: Array<Int>, key: Int) -> (Int, Int) {
    var hash = Dictionary<Int, Int>()
    var index = 0

    var left = -1
    var right = -1
    while index < origin.count {
        let value = origin[index]
        let needValue = key - value
        if hash[needValue] != nil {
            left = hash[needValue]!
            right = index
        } else {
            hash[value] = index
        }

        index += 1
    }

    return (left, right)
}

//数组中重复的数字
func findMutipleNum(origin: inout Array<Int>) -> Int {
    var index = 0
    var find = -1
    while index < origin.count {
        let target = origin[index]
        if target == index {
            index += 1
        } else {
            if target == origin[target] {
                find = target
                break
            } else {
                cx_swap(&origin, index1: index, index2: origin[index])
            }
        }
    }

    return find
}

//找到第k大的数字
func findKMax(_ arr: inout Array<Int>, _ left: Int, _ right: Int, _ k: Int) {
    let temp = partition(&arr, left, right);
    if (temp == k - 1) {
        print(arr[temp]);
    } else if (temp > k - 1) {
        findKMax(&arr, left, temp - 1, k);
    } else {
        findKMax(&arr, temp + 1, right, k - temp);
    }
}

func partition(_ arr: inout Array<Int>, _ left: Int, _ right: Int) -> Int {
    let temp = arr[left];
    var left = left
    var right = right
    while (left < right) {
        while (temp >= arr[right] && left < right) { right -= 1 }
        arr[left] = arr[right];

        while (temp <= arr[left] && left < right) { left += 1 }
        arr[right] = arr[left];
    }

    arr[right] = temp;
    return right;
}

