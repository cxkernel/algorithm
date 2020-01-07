//
//  Sort.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation

func cx_swap<T>(_ origin: inout Array<T>, index1: Int, index2: Int) {
    if index1 == index2 { return }
    let tmp = origin[index1]
    origin[index1] = origin[index2]
    origin[index2] = tmp
}

///Bubble Sort
func bubbleSort<T: Comparable>(_ origin: inout Array<T>) {
    let count = origin.count
    for i in 0..<count {
        for j in 0..<count-i-1 {
            if origin[j] > origin[j+1] {
                cx_swap(&origin, index1: j, index2: j+1)
            }
        }
    }
}

///Selected Sort
func selectionSort<T: Comparable>(_ origin: inout Array<T>) {
    let count = origin.count
    for i in 0..<count {
        var findIndex = i
        var stub = origin[i]
        for j in i..<count {
            if origin[j] < stub {
                stub = origin[j]
                findIndex = j
            }
        }

        cx_swap(&origin, index1: i, index2: findIndex)
    }
}

///Insert Sort
func insertionSort<T: Comparable>(_ origin: inout Array<T>) {
    let count = origin.count
    for i in 1..<count {
        var index = i
        let stub = origin[i]
        while index > 0 && origin[index - 1] > stub  {
            origin[index] = origin[index - 1]
            index -= 1
        }

        origin[index] = stub
    }
}

///Shell Sort
func shellSort<T: Comparable>(_ origin: inout Array<T>) {
    var gap = origin.count / 2
    while gap > 0 {
        for i in 0..<origin.count {
            inlineShellSort(&origin, start: i, gap: gap)
        }

        gap = gap / 2
    }
}

func inlineShellSort<T: Comparable>(_ origin: inout Array<T>, start: Int, gap: Int) {
    let count = origin.count
    var i = start
    while i < count {
        var index = i
        let stub = origin[i]
        while index > start && origin[index - gap] > stub {
            origin[index] = origin[index - gap]

            index -= gap
        }

        origin[index] = stub

        i += gap
    }
}

///Heap Sort
func heapSort<T: Comparable>(_ origin: inout Array<T>) {
    var node = origin.count / 2
    var index = origin.count - 1
    //构建大顶堆
    while node > 0 {
        adjustHeap(&origin, start: node - 1, end: index)
        node -= 1
    }

    //取出最大数root节点，再进行调整
    while index >= 0 {
        cx_swap(&origin, index1: 0, index2: index)
        adjustHeap(&origin, start: 0, end: index - 1)
        index -= 1
    }
}

func adjustHeap<T: Comparable>(_ origin: inout Array<T>, start: Int, end: Int) {
    let node = origin[start]
    var nodeIndex = start
    var index = start * 2 + 1
    while index <= end {
        if index < end && origin[index] < origin[index+1] {
            index += 1
        }

        if node > origin[index] { break }

        origin[nodeIndex] = origin[index]
        nodeIndex = index
        index = index * 2 + 1
    }

    origin[nodeIndex] = node
}

///Merge Sort
func mergeSort<T: Comparable>(_ origin: Array<T>) -> Array<T> {
    guard origin.count > 1 else { return origin }
    let middle = origin.count / 2

    let left = mergeSort(Array(origin[0..<middle]))
    let right = mergeSort(Array(origin[middle..<origin.count]))

    return merge(left, right)
}

func merge<T: Comparable>(_ left: Array<T>, _ right: Array<T>) -> Array<T> {
    var all = Array<T>()
    var leftIndex = 0
    let leftCount = left.count
    var rightIndex = 0
    let rightCount = right.count
    while true {
        guard leftIndex < leftCount else {
            all.append(contentsOf: Array(right[rightIndex..<rightCount]))
            break
        }

        guard rightIndex < rightCount else {
            all.append(contentsOf: Array(left[leftIndex..<leftCount]))
            break
        }

        if left[leftIndex] < right[rightIndex] {
            all.append(left[leftIndex])
            leftIndex += 1
        } else {
            all.append(right[rightIndex])
            rightIndex += 1
        }
    }

    return all
}

///Quick Sort
func quickSort<T: Comparable>(_ origin: inout Array<T>, low: Int, high: Int) {
    if low >= high { return }
    let pivot = Int(arc4random_uniform(UInt32(high - low + 1))) + low
    let (left, right) = partitionDutch(&origin, low: low, high: high, pivot: pivot)
    quickSort(&origin, low: low, high: left - 1)
    quickSort(&origin, low: right, high: high)
}

func partitionDutch<T: Comparable>(_ origin: inout Array<T>, low: Int, high: Int, pivot: Int) -> (Int, Int) {
    var left = low
    var right = high
    var index = low
    let value = origin[pivot]
    while index <= right {
        if origin[index] > value {
            cx_swap(&origin, index1: right, index2: index)
            right -= 1
        } else if origin[index] < value {
            cx_swap(&origin, index1: left, index2: index)
            left += 1
            index += 1
        } else {
            index += 1
        }
    }

    return (left, right)
}
