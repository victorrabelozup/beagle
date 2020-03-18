//
//  Copyright © 10/10/19 Zup IT. All rights reserved.
//

import Foundation

public final class MemoryCacheService {

    private let memory = NSCache<NSString, NSData>()

    public enum Error: Swift.Error {
        case couldNotLoadData
    }

    // MARK: - Saving

    public func save(data: Data, key: String) {
        memory.setObject(data as NSData, forKey: key as NSString)
    }

    // MARK: - Data Loading

    public func loadData(
        from key: String
    ) -> Result<Data, Error> {
        guard let data = memory.object(forKey: key as NSString) else {
            return .failure(.couldNotLoadData)
        }

        return .success(data as Data)
    }

    // MARK: - Cleaning Caches

    public func clear() {
        memory.removeAllObjects()
    }
}
