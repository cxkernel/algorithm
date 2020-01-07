//
//  main.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation

var needSortArray = [10, 11, 4, 5, 2, 3, 1, 9, 12, 8, 6]

/// sort
//bubbleSort(&needSortArray)
//selectionSort(&needSortArray)
//insertionSort(&needSortArray)
//shellSort(&needSortArray)
//heapSort(&needSortArray)
//print(mergeSort(needSortArray))
//quickSort(&needSortArray, low: 0, high: needSortArray.count-1)
//print(needSortArray)

//link list
//let singlyLinkList = LinkNode.initLink(withTail: needSortArray)
//singlyLinkList.printList()
//let findNode = singlyLinkList.findLastNode(10)
//let findNode = singlyLinkList.findMiddleNode()
//print(findNode.value ?? -1)
//let reverse = singlyLinkList.reverse()
//reverse.printList()

//let sortNodeLink1 = LinkNode.initLink(withTail: [1, 2, 6, 7, 17])
//let sortNodeLink2 = LinkNode.initLink(withTail: [2, 4, 5, 9, 10, 16])
//let mergeResult = LinkNode.mergeNodeList(sortNodeLink1, sortNodeLink2)
//mergeResult.printList()

//let circleLinkNode = LinkNode.initLink(withTail: [1, 2, 3, 4, 5])
//let last = circleLinkNode.findLastNode(1)
//let second = circleLinkNode.findLastNode(4)
//last?.next = second
//let checkResult = circleLinkNode.checkSinglyLinkList()
//print(checkResult.0, checkResult.1)

//let array = [1, 3, 7, 10, 13, 15, 17, 20]
//let findIndex = binarySearch(array, key: 20, low: 0, high: array.count - 1)
//let findIndex = interpolationSearch(array, key: 13, low: 0, high: array.count - 1)
//print(findIndex)

//let array = [1, 12, 11, 10, 3, 4, 23, 7, 6, 2]
//let secondMaxNum = searchSecondMaxNum(array)
//print(secondMaxNum)

//var list = [1, 2, 3]
//let v = list.removeLast()
//print(v, list)

var level4_2 = NodeTree()
level4_2.val = 6
level4_2.left = nil
level4_2.right = nil

var level3_1 = NodeTree()
level3_1.val = 4
level3_1.left = nil
level3_1.right = level4_2

var level3_2 = NodeTree()
level3_2.val = 5
level3_2.left = nil
level3_2.right = nil

var level2_1 = NodeTree()
level2_1.val = 2
level2_1.left = level3_1
level2_1.right = level3_2

var level2_2 = NodeTree()
level2_2.val = 3

var rootNode = NodeTree()
rootNode.val = 1
rootNode.left = level2_1
rootNode.right = level2_2
/*
             1
            / \
           2   3
          / \
         4   5
          \
           6
 
 */

let allLevelPer: Array<Array<Int?>> = [
    [1],
    [2, 3],
    [4, 5, nil, 6],
    [nil, 7, nil, 8, ]
]

let levelTraverResult = levelTraver(root: rootNode)
print(levelTraverResult)
let preTraverResult = preTraver(root: rootNode)
print(preTraverResult)
let inTraverResult = inTraver(root: rootNode)
print(inTraverResult)
let maxDeep = binaryTreeDeep(node: rootNode)
print(maxDeep)

//var array = [1, 2, 3]
//let allSubSetRes = allSubSet(origin: &array)
//print(allSubSetRes)
//let permationRes = permation(origin: &array)
//print(permationRes)
//
//let secondNum = findSecondNum(origin: [1, 2, 3, 4])
//print(secondNum)
//
//let mergeResult = merge([1, 4, 7], [2, 3, 6, 10, 12])
//print(mergeResult)
//
//var partitionDutchArray = [1, 7, 9, 13, 4, 2, 12, 6, 5, 11, 8]
//partitionDutch(origin: &partitionDutchArray, pivot: 8)
//print(partitionDutchArray)

//Two-Sum Problem
//LRU Cache
//RBTree
//AVL
//二叉树的最大深度
//数组中重复的数字
//各种排序算法、未排序常规数据查找第K大的数，时间复杂度
//如何倒序输出单向链表？

