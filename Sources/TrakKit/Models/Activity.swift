//
//  Activity.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//
import Foundation
import SwiftData

@Model
public final class Activity {
    public var id: UUID
    public var name: String
    public var activityDescription: String?
    public var createdAt: Date
    
    public init(
        id: UUID = UUID(),
        name: String,
        activityDescription: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.activityDescription = activityDescription
        self.createdAt = createdAt
    }
}
