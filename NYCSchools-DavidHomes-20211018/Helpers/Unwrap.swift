//
//  Unwrap.swift
//  PenguinPay
//
//  Created by dhomes on 10/19/21.
//
import SwiftUI

/// Unwrap an optional value, useful for SwiftUI Views
struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
