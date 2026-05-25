//
//  Subject.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//
import Foundation
import SwiftData

@Model
public final class Subject {
    public var id: UUID //subject will have a unique id
    public var name: String // a name
    
    //NORMALIZED NAME
    public var normalizedName: String {
        name.lowercased()
    }
    
    public var desc: String? // an optional subject description
    
    //Date created
    public var createdAt: Date
    
    
    
    //An initializer for a subject
    public init(id: UUID = UUID(), name: String, desc: String? = nil, createdAt: Date = Date() ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.createdAt = createdAt
    }
}

public enum SubjectError: Error {
    case emptyName
    case nameTooShort
    case nameTooLong
    
    case subjectAlreadyExists
    
    
    public var errorDescription: String {
        switch self {
        case .emptyName:
            return "Subject name cannot be empty"
        case .nameTooShort:
            return "Subject name must be at least 3 characters long"
        case .nameTooLong:
            return "Subject name must be less that 25 characters"
        case .subjectAlreadyExists:
            return "Subject already exists"
        }
    }
}
