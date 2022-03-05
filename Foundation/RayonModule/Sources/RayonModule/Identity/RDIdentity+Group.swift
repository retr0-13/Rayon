//
//  RDIdentity.swift
//  Rayon
//
//  Created by Lakr Aream on 2022/2/9.
//

import Foundation
import NSRemoteShell

public struct RDIdentityGroup: Codable, Identifiable {
    public typealias AssociatedType = RDIdentity

    public var id = UUID()

    public private(set) var identities: [AssociatedType] = []

    public var count: Int {
        identities.count
    }

    public mutating func insert(_ value: AssociatedType) {
        guard !value.username.isEmpty else { return }
        if let index = identities.firstIndex(where: { $0.id == value.id }) {
            identities[index] = value
        } else {
            identities.append(value)
        }
    }

    public subscript(_ id: AssociatedType.ID) -> AssociatedType {
        get {
            identities.first(where: { $0.id == id }) ?? .init()
        }

        set(newValue) {
            if let index = identities.firstIndex(where: { $0.id == newValue.id }) {
                identities[index] = newValue
            } else {
                debugPrint("setting subscript found nil when sending value, did you forget to call insert?")
            }
        }
    }

    public mutating func delete(_ value: AssociatedType.ID) {
        let index = identities
            .firstIndex { $0.id == value }
        if let index = index {
            identities.remove(at: index)
        }
    }
}
