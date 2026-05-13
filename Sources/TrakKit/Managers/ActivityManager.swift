//
//  ActivityManager.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//

public struct ActivityManager{
    private let store: ActivityStore
    
    public init (store: ActivityStore) {
        self.store = store
    }
    
    ///Update an existing activity.
    public func updateActivity(activity: Activity) throws {
        let normalizedName = normalizeActivityName(activity.name)
        
        guard !normalizedName.isEmpty else {
            throw TrakError.emptyActivityName
        }
        
        let existingActivities = try store.fetchAll()
        
        //Chesk if this activity actually exist.
        guard existingActivities.contains(where: {
            $0.id == activity.id
        })else {
            throw TrakError.activityNotFound
        }
        
        //Check that no other activity already has this name
        let duplicateExists = existingActivities.contains( where: {
            $0.id != activity.id && $0.name == normalizedName
        })
        
        guard !duplicateExists else {
            throw TrakError.activityAlreadyExist("\(normalizedName) already exists.")
        }
        
        let updatedActivity = Activity (
            id: activity.id,
            name: normalizedName,
            description: activity.description
        )
        
        try store.update(updatedActivity)
    }
    
    
    /// Deletes an existing activity.
    public func deleteActivity(activity: Activity) throws {
        try store.delete(activity)
    }
    
    /// Return a list of all activities
    public func getAllActivities() throws-> [Activity] {
        return try store.fetchAll()
    }
    
    /// Create a new Activity
    public func createActivity(name: String, description: String?) throws -> Activity {
        //Validation
        let normalizedName = normalizeActivityName(name)
        
        guard !normalizedName.isEmpty else {
            throw TrakError.emptyActivityName
        }
        
        //duplicate check
        let exists = try checkDuplicateActivityByName(normalizedName)
        
        guard !exists else {
            throw TrakError.activityAlreadyExist("\(name) already exists.")
        }
        
        //create activity
        let newActivity = Activity(name: normalizedName, description: description)
        
        //save activity
        try store.save(newActivity)
        
        return newActivity
    }
    
    ///normalize an activity name
    private func normalizeActivityName(_ name: String) -> String {
        name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    ///Check for duplicate activity by name
    private func checkDuplicateActivityByName(_ name: String) throws -> Bool {
        let activityList = try store.fetchAll()
        
        return activityList.contains(where: {
            $0.name == name
        })
    }
}
