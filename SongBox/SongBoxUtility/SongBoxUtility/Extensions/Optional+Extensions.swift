//
//  Optional+Extensions.swift
//  SongBoxUtility
//
//  Created by Yunus Emre Berdibek on 15.03.2024.
//

import Foundation

public extension Optional {
    struct FoundNilWhileUnwrappingError: Error {}

    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped):
            return wrapped
        case .none:
            throw FoundNilWhileUnwrappingError()
        }
    }
}

public extension Array {
    struct IndexOutOfBoundsError: Error {}

    func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
}
