/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

typealias DoublyLinkedListNode<T> = DoublyLinkedList<T>.Node<T>

final class DoublyLinkedList<T> {

    private(set) var count: Int = 0
    private var head: Node<T>?
    private var tail: Node<T>?
    
    final class Node<T> {
        var payload: T
        var previous: Node<T>?
        var next: Node<T>?

        init(payload: T) {
            self.payload = payload
        }
    }
    
    func addHead(_ payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }

        guard let head = head else {
            tail = node
            return node
        }

        head.previous = node

        node.previous = nil
        node.next = head

        return node
    }
    
    func moveToHead(_ node: Node<T>) {
        guard node !== head else { return }
        let previous = node.previous
        let next = node.next

        previous?.next = next
        next?.previous = previous

        node.next = head
        node.previous = nil

        if node === tail {
            tail = previous
        }

        self.head = node
    }
    
    func removeLast() -> Node<T>? {
        guard let tail = self.tail else { return nil }

        let previous = tail.previous
        previous?.next = nil
        self.tail = previous

        if count == 1 {
            head = nil
        }

        count -= 1

        return tail
    }
    
    func clear() {
        count = 0
        head = nil
        tail = nil
    }
}
