//
//  Copyright © 10/02/20 Zup IT. All rights reserved.
//

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
