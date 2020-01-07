//
//  LinkList.swift
//  Algorithm-Course
//
//  Created by coolkernel on 2019/6/1.
//  Copyright © 2019 coolKernel. All rights reserved.
//

import Foundation

///创建单链表
///打印单链表
///查找倒数第k个节点
///查找中间节点
///合并两个有序链表
///链表反转
///检查链表是否有环，其实位置，长度
///查找两个链表相同的节点

class LinkNode<T: Comparable> : NSObject {
    var value: T!
    var next: LinkNode?

    ///create singly link list
    static func initLink(withTail array: Array<T>) -> LinkNode {
        var head = LinkNode()
        var node = head
        for value in array {
            let tmp = LinkNode()
            tmp.value = value
            head.next = tmp

            head = tmp
        }

        if node.next != nil {
            node = node.next!
        }

        return node
    }

    func length() -> Int {
        var length = 0
        var node: LinkNode? = self
        while node != nil {
            length += 1
            node = node?.next
        }

        return length
    }

    ///print link list
    func printList() {
        var node: LinkNode? = self
        var printList = Array<T>()
        repeat {
            printList.append(node!.value)
            node = node?.next
        } while node != nil

        print(printList)
    }

    ///find last k node
    func findLastNode(_ k: Int) -> LinkNode? {
        var stub: LinkNode? = self
        var findNode = stub
        var index = k
        while stub != nil {
            if index == 0 {
                findNode = findNode?.next
            } else {
                index -= 1
            }
            stub = stub?.next
        }

        return findNode
    }

    ///find middle node
    func findMiddleNode() -> LinkNode {
        var low: LinkNode? = self
        var fast: LinkNode? = low?.next?.next
        if low?.next != nil && fast == nil {
            return low!.next!
        } else if fast == nil {
            return low!
        }

        while fast != nil {
            low = low?.next
            fast = fast?.next?.next
        }

        return low!
    }

    ///merge double sort link list
    static func mergeNodeList(_ left: LinkNode, _ right: LinkNode) -> LinkNode {
        var node = LinkNode()
        var head = node
        var leftNode: LinkNode? = left
        var rightNode: LinkNode? = right
        while true {
            guard let node1 = leftNode else {
                node.next = rightNode
                break
            }

            guard let node2 = rightNode else {
                node.next = leftNode
                break
            }

            if node1.value < node2.value {
                node.next = node1
                node = node1
                leftNode = leftNode?.next
            } else {
                node.next = node2
                node = node2
                rightNode = rightNode?.next
            }
        }

        if head.next != nil {
            head = head.next!
        }

        return head
    }

    ///reverse link list
    func reverse() -> LinkNode {
        var pre: LinkNode? = self
        var cur: LinkNode? = self.next
        while cur != nil {
            let tmp = cur?.next
            cur?.next = pre
            pre = cur
            cur = tmp
        }

        self.next = nil

        return pre!
    }

    ///check circle, calculate circle length, start location
    func checkSinglyLinkList() -> (Bool, Int) {
        var startNode: LinkNode? = self
        var fastNode = self.next?.next
        var i = 0
        var j = 2
        var isCircle = false
        while fastNode != nil {
            if startNode == fastNode {
                isCircle = true
                break
            }

            startNode = startNode?.next
            i += 1
            fastNode = fastNode?.next?.next
            j += 2
        }

        return (isCircle, j - i)
    }

    ///delete duplicate node
    func findOverNode(first linkedList1: LinkNode, second linkedList2: LinkNode) -> LinkNode? {
        let len1 = linkedList1.length()
        let len2 = linkedList2.length()
        var most: LinkNode?
        var short: LinkNode?
        if len1 > len2 {
            most = linkedList1
            short = linkedList2
        } else {
            most = linkedList2
            short = linkedList1
        }
        
        var target: LinkNode?
        
        var step = abs(len1 - len2)
        while most != nil || step > 0 {
            most = most?.next
            if step == 0 {
                short = short?.next
            }
            
            if short == most {
                target = short
                break
            }
            
            if step > 0 {
                step -= 1
            }
        }
        
        return target
    }
}





