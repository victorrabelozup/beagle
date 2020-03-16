//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol ValidatorProvider {
    func getValidator(name: String) -> Validator?
}

public protocol DependencyValidatorProvider {
    var validatorProvider: ValidatorProvider? { get }
}

public final class ValidatorProviding: ValidatorProvider {
    
    private var handlers: [String: ClosureValidator] = [:]
    
    public init() {
    }
    
    public func getValidator(name: String) -> Validator? {
        return handlers[name]
    }
    
    public subscript(name: String) -> ((Any) -> Bool)? {
        get {
            return handlers[name]?.closure
        }
        set {
            if let closure = newValue {
                handlers[name] = ClosureValidator(closure: closure)
            } else {
                handlers.removeValue(forKey: name)
            }
        }
    }
}

private class ClosureValidator: Validator {
    let closure: (Any) -> Bool
    
    init(closure: @escaping (Any) -> Bool) {
        self.closure = closure
    }
    
    func isValid(input: Any) -> Bool {
        return closure(input)
    }
}
