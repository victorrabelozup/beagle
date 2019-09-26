//
//  DataPreprocessor.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 24/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

enum DataPreprocessorError: Error {
    case jsonSerialization(Error)
    case emptyJSON
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
        
        let uppercasedNamespace = namespace.uppercased()
        
        var json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            throw DataPreprocessorError.jsonSerialization(error)
        }
        
        let newDataJSON = try transformValueIfNeeded(json, for: uppercasedNamespace)
        
        return try JSONSerialization.data(withJSONObject: newDataJSON, options: .prettyPrinted)
        
    }
    
    private func transformValueIfNeeded(_ value: Any?, for namespace: String) throws -> Any {
        
        if let jsonArray = value as? [[String: Any]] {

            return try jsonArray.map { try transformValueIfNeeded($0, for: namespace) }
            
        } else if let dictionary = value as? [String: Any], let type = (dictionary["type"] as? String)?.uppercased(), type.contains(namespace) {
            
            var newValue = [String: Any]()
            var content = [String: Any]()
            try dictionary.forEach {
                if let typeName = ($0.value as? String)?.uppercased(), typeName == type {
                    newValue[$0.key] = $0.value
                } else {
                    content[$0.key] = try transformValueIfNeeded($0.value, for: namespace)
                }
            }
            newValue["content"] = content
            
            return newValue
            
        } else {
            return value ?? ""
        }
        
    }
    
}
