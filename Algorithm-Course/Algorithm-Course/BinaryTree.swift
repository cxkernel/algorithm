//
//  BinaryTree.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation
class NodeTree {
    var left: NodeTree?
    var right: NodeTree?
    var val: Int = 0
}

/// pre traver
func preTraver(root: NodeTree) -> Array<Int> {
    var result = Array<Int>()
    var stack = Array<NodeTree>()
    var node: NodeTree? = root
    while node != nil || stack.count != 0 {
        if node != nil {
            result.append(node!.val)
            stack.append(node!)
            node = node?.left
        } else {
            node = stack.removeLast().right
        }
    }
    
    return result
}

/// in traver
func inTraver(root: NodeTree) -> Array<Int> {
    var result = Array<Int>()
    var stack = Array<NodeTree>()
    var node: NodeTree? = root
    while node != nil || stack.count != 0 {
        if node != nil {
            stack.append(node!)
            node = node?.left
        } else {
            let parent = stack.removeLast()
            node = parent.right
            result.append(parent.val)
        }
    }
    
    return result
}

/// after traver

///level traver
func levelTraver(root: NodeTree) -> Array<Int> {
    var result = Array<Int>()
    var queue = Array<NodeTree>()
    
    queue.append(root)
    result.append(root.val)
    
    while queue.count > 0 {
        let levelCount = queue.count
        for _ in 0..<levelCount {
            let node = queue.removeFirst()
            if let left = node.left {
                result.append(left.val)
                queue.append(left)
            }
            if let right = node.right {
                result.append(right.val)
                queue.append(right)
            }
        }
    }
    
    return result
}

///二叉树反转 递归
func reverseBinaryTree_recursive(root: NodeTree?) {
    if let root = root {
        let left = root.left
        root.left = root.right
        root.right = left
        
        if root.left != nil {
            reverseBinaryTree_recursive(root: root.left)
        }
        
        if root.right != nil {
            reverseBinaryTree_recursive(root: root.right)
        }
    }
}

///二叉树反转 非递归
func reverseBinaryTree(root: NodeTree) {
    var queue = Array<NodeTree>()
    queue.append(root)
    while queue.count > 0 {
        let count = queue.count
        for _ in 0..<count {
            let node = queue.first
            let left = node?.left
            node?.left = node?.right
            node?.right = left
            
            if node?.left != nil {
                queue.append(node!.left!)
            }
            if node?.right != nil {
                queue.append(node!.right!)
            }
        }
        
        queue.removeFirst()
    }
}

///二叉树最大深度
func binaryTreeDeep(node: NodeTree?) -> Int {
    if node == nil {
        return 0
    }

    let leftDeep = binaryTreeDeep(node: node?.left)
    let rightDeep = binaryTreeDeep(node: node?.right)

    return max(leftDeep, rightDeep) + 1
}

///二叉树最小深度
func binaryTreeMinDeep(node: NodeTree?) -> Int {
    if node == nil {
        return 0
    }

    let leftDeep = binaryTreeMinDeep(node: node?.left)
    let rightDeep = binaryTreeMinDeep(node: node?.right)

    return min(leftDeep, rightDeep) + 1
}
