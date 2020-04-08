/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
