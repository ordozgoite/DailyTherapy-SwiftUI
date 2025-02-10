//
//  Answer.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation
import CoreData

@objc(Answer)
class Answer: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var questionText: String
    @NSManaged var answerText: String
    @NSManaged var date: Date
}
