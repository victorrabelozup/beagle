/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
