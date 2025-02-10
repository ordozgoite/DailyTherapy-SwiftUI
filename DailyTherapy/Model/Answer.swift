//
//  Answer.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation

struct ManagedAnswer { // Mudar nome?
    let id = UUID()
    let answerText: String
    let questionTag: Int
    let date: Date
}
