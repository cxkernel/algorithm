//
//  Search.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation

/// Binary search
func binarySearch<T: Comparable>(_ origin: Array<T>, key: T, low: Int, high: Int) -> Int {
    guard low <= high else { return -1 }
    let middle = low + (high - low) / 2
    if key < origin[middle] {
        return binarySearch(origin, key: key, low: low, high: middle-1)
    } else if key > origin[middle] {
        return binarySearch(origin, key: key, low: middle+1, high: high)
    } else {
        return middle
    }
}

/// diff search
func interpolationSearch(_ origin: Array<Int>, key: Int, low: Int, high: Int) -> Int {
    guard low <= high else { return -1 }
    let middle = Int(Float(key - origin[low]) / Float(origin[high] - origin[low]) * Float(high - low)) + low
    if key < origin[middle] {
        return interpolationSearch(origin, key: key, low: low, high: middle - 1)
    } else if key < origin[middle] {
        return interpolationSearch(origin, key: key, low: middle+1, high: high)
    } else {
        return middle
    }
}

/// fibonacci serach

/// binary serach tree

/// search second number
func searchSecondMaxNum(_ origin: Array<Int>) -> Int {
    guard origin.count > 0 else { return -1 }
    var max = origin[0]
    var second = -1
    for value in origin {
        if value > max {
            second = max
            max = value
        }
    }

    return second
}
