//
//  Queue.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit


class QueueNode<T> {
    var data : T
    var next : QueueNode?
    init(data : T) {
        self.data = data
        self.next = nil
    }
}

class Queue<T> {
    var head : QueueNode<T>?
    var tail : QueueNode<T>?
    var len : Int = 0
    init() {
        self.head = nil
        self.tail = nil
    }
    func push(_ item : T) {
        if self.head != nil {
            if let tail = self.tail {
                tail.next = QueueNode(data: item)
                self.tail = tail.next
            }
        } else {
            head = QueueNode(data: item)
            self.tail = head
        }
        self.len += 1
    }
    func pop() -> QueueNode<T>? {
        if let head = self.head {
            let prev_head = head
            self.head = head.next
            self.len -= 1
            return prev_head
        } else {
            return nil
        }
    }
    func clear() {
        while let _ = pop() {}
    }
    func printQueue() {
        var iterator = self.head
        var str = ""
        while iterator != nil {
            str += "\(iterator!.data), "
            iterator = iterator!.next
        }
        print(str)
    }
}
