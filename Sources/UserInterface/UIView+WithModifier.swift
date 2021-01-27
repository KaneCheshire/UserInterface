//
//  File.swift
//  
//
//  Created by Kane Cheshire on 27/01/2021.
//

import UIKit

public extension UIView {

    func with<Value>(_ keyPath: ReferenceWritableKeyPath<UIView, Value>, as value: Value) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}

public extension UILabel {

    func with<Value>(_ keyPath: ReferenceWritableKeyPath<UILabel, Value>, as value: Value) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}

public extension UITableView {

    func with<Value>(_ keyPath: ReferenceWritableKeyPath<UITableView, Value>, as value: Value) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}
