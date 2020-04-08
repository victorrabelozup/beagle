/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

final class CacheLRU<Key: Hashable, Value> {

    private struct CachePayload {
        let key: Key
        let value: Value
    }

    private let capacity: Int
    private let list = DoublyLinkedList<CachePayload>()
    private var nodesDict = [Key: DoublyLinkedListNode<CachePayload>]()
    
    var count: Int {
        return list.count
    }

    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }

    func setValue(_ value: Value, for key: Key) {
        let payload = CachePayload(key: key, value: value)

        if let node = nodesDict[key] {
            node.payload = payload
            list.moveToHead(node)
        } else {
            let node = list.addHead(payload)
            nodesDict[key] = node
        }

        if list.count > capacity {
            let nodeRemoved = list.removeLast()
            if let key = nodeRemoved?.payload.key {
                nodesDict[key] = nil
            }
        }
    }

    func getValue(for key: Key) -> Value? {
        guard let node = nodesDict[key] else { return nil }

        list.moveToHead(node)

        return node.payload.value
    }
    
    func clear() {
        list.clear()
        nodesDict = [Key: DoublyLinkedListNode<CachePayload>]()
    }
}
