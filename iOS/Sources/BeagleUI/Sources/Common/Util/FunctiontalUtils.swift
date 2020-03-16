//
//  FunctiontalSupport.swift
//  BeagleUI
//
//  Created by Daniel Tes on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

infix operator |>
public func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}

precedencegroup SingleTypeComposition {
  associativity: left
}

infix operator <>: SingleTypeComposition
public func <> <A: AnyObject>(f: @escaping (A?) -> Void, g: @escaping (A?) -> Void) -> (A?) -> Void {
  return { a in
    f(a)
    g(a)
  }
}

public func descriptionWithoutOptional(_ obj: Any?) -> String {
    if let obj = obj {
        return "\(obj)"
    } else {
        return "NULL"
    }
}
