//
//  ActivityProtocol.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//

//Define what you can do with an activity
public protocol ActivityStore {
    func save(_ activity: Activity) throws
    func fetchAll() throws -> [Activity]
    func update(_ activity: Activity) throws
    func delete(_ activity: Activity) throws
}
