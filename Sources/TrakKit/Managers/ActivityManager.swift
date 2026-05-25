//
//  SubjectManager.swift
//  TrakKit
//
//  Created by somto on 2026-05-11.
//
import SwiftData
import Foundation

public struct SubjectManager{
    private let modelContext: ModelContext //Manager usese modelContext to query swiftData

    
    public init (modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    //SUBJECT NAME NORMALIZER
    
    //Create a new subject
    /*
     Rules:
     1. Subject name cannot be empty
     2. Subject name must be normalized
     3. Subject names must be unique
     4. Subject name must be >= 3 characters and <= 25 characters
     */
    
    public func createSubject(name: String, description: String?, existingSubjects: [Subject]) throws -> Subject{
        //trim data
        var name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if var description = description {
            description = description.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        //continue if name is not empty
        guard !name.isEmpty else {
            throw SubjectError.emptyName
        }
        
        //CONTINUE IF NAME IS > 3 AND < 25 CHARACTERS
        guard name.count > 3 else {
            throw SubjectError.nameTooShort
        }
        
        guard name.count < 25 else {
            throw SubjectError.nameTooLong
        }
        
        //Create a subject
        let newSubject = Subject(name: name, desc: description)
        
        
        if existingSubjects.contains(where: { existingSubject in
            newSubject.normalizedName == existingSubject.normalizedName
        }){
            throw SubjectError.subjectAlreadyExists
        } else {
            
            //Add the newly created subject
            modelContext.insert(newSubject)
            return newSubject
        }
    }
    
    
//    /// Return a list of all activities
//    public func getAllActivities() throws-> [Activity] {
//        let descriptor = FetchDescriptor<Activity>(
//            sortBy: [SortDescriptor(\.name)]
//        )
//    }
    
    ///Update an existing activity.
//    public func updateActivity(activity: Activity) throws {
//        let normalizedName = normalizeActivityName(activity.name)
//        
//        guard !normalizedName.isEmpty else {
//            throw TrakError.emptyActivityName
//        }
//        
//        let existingActivities = try store.fetchAll()
//        
//        //Chesk if this activity actually exist.
//        guard existingActivities.contains(where: {
//            $0.id == activity.id
//        })else {
//            throw TrakError.activityNotFound
//        }
//        
//        //Check that no other activity already has this name
//        let duplicateExists = existingActivities.contains( where: {
//            $0.id != activity.id && $0.name == normalizedName
//        })
//        
//        guard !duplicateExists else {
//            throw TrakError.activityAlreadyExist("\(normalizedName) already exists.")
//        }
//        
//        let updatedActivity = Activity (
//            id: activity.id,
//            name: normalizedName,
//            activityDescription: activity.activityDescription
//        )
//        
//        try store.update(updatedActivity)
//    }
    
    
//    /// Deletes an existing activity.
//    public func deleteActivity(activity: Activity) throws {
//        try store.delete(activity)
//    }
    
    
    
    /// Create a new Activity
//    public func createActivity(
//        name: String,
//        description: String?
//    ) throws -> Activity {
//        //Validation
//        let normalizedName = normalizeActivityName(name)
//        
//        guard !normalizedName.isEmpty else {
//            throw TrakError.emptyActivityName
//        }
//        
//        //duplicate check
//        let exists = try checkDuplicateActivityByName(normalizedName)
//        
//        guard !exists else {
//            throw TrakError.activityAlreadyExist("\(name) already exists.")
//        }
//        
//        //create activity
//        let newActivity = Activity(name: normalizedName, activityDescription: description)
//        
//        //save activity
//        try store.save(newActivity)
//        
//        return newActivity
//    }
    
    ///normalize an activity name
    private func normalizeActivityName(_ name: String) -> String {
        name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
//    ///Check for duplicate activity by name
//    private func checkDuplicateActivityByName(_ name: String) throws -> Bool {
//        let activityList = try store.fetchAll()
//        
//        return activityList.contains(where: {
//            $0.name == name
//        })
//    }
}
