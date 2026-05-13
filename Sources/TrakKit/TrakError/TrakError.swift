//
//  TrakError.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//

public enum TrakError : Error {
    case emptyActivityName
    case activityAlreadyExist(String)
    case activityNotFound
}
