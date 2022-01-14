// Array + Extension.swift
// Copyright © Dmi3. All rights reserved.

import Foundation

/// Safe subscript
public extension Array {
//    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
//        guard index >= 0, index < endIndex else {
//            return defaultValue()
//        }
//
//        return self[index]
//    }

    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else { return nil }
        return self[index]
    }
}
