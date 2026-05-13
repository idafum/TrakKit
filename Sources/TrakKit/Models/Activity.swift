//
//  Activity.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//
import Foundation

public struct Activity {
    let id: UUID
    public let name: String
    public let description: String?
    public let createdAt: Date
    
    init(id: UUID = UUID(), name: String, description: String? = nil, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.description = description
        self.createdAt = createdAt
    }
}
