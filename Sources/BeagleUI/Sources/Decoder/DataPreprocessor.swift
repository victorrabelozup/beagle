//
//  DataPreprocessor.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 24/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

enum DataPreprocessorError: Error {
    case invalidJSONForDataInNamespace(Data, String)
    case jsonSerialization(Error)
}

protocol DataPreprocessor {
    
    /// Normalizes the data received to add it to a logic, to be decoded
    ///
    /// - Parameters:
    ///   - data: the data you need to preprocess
    ///   - namespace: the namespace identifier for you entities
    /// - Returns: a normalized data
    /// - Throws: a DataPreprocessorError
    func normalizeData(_ data: Data, for namespace: String) throws -> Data
}

final class DataPreprocessing: DataPreprocessor {
    
    func normalizeData(_ data: Data, for namespace: String) throws -> Data {
        
        var rawJSON: Any?
        do {
            rawJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            throw DataPreprocessorError.jsonSerialization(error)
        }
        
        guard let json = rawJSON as? [String: Any] else {
            throw DataPreprocessorError.invalidJSONForDataInNamespace(data, namespace)
        }
        let newDataJSON = transformValueIfNeeded(json, for: namespace)
        
        do {
            let newData = try JSONSerialization.data(withJSONObject: newDataJSON, options: .prettyPrinted)
            return newData
        } catch {
            throw DataPreprocessorError.jsonSerialization(error)
        }
        
    }
    
    private func transformValueIfNeeded(_ value: [String: Any], for namespace: String) -> [String: Any] {
        
        guard let type = value["type"] as? String, type.contains(namespace) else {
            return value
        }
        
        var newValue = [String: Any]()
        var content = [String: Any]()
        value.forEach {
            if let innerValue = $0.value as? [String: Any], $0.key != type {
                content[$0.key] = transformValueIfNeeded(innerValue, for: namespace)
            } else if let typeName = $0.value as? String, typeName == type {
                newValue[$0.key] = $0.value
            } else {
                content[$0.key] = $0.value
            }
        }
        newValue["content"] = content
        
        return newValue
        
    }
    
}
