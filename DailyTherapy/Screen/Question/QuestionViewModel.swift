//
//  QuestionViewModel.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation

@MainActor
class QuestionViewModel: ObservableObject {
    
    @Published var currentQuestions: [Question] = []
    @Published var answers: [String] = ["", "", ""]
    
    func loadQuestions(for timeOfDay: TimeOfDay) {
        switch timeOfDay {
        case .morning:
            currentQuestions = DailyQuestions.morning
        case .night:
            currentQuestions = DailyQuestions.night
        }
    }
    
    func areInputsValid() -> Bool {
        return !answers.contains(where: { $0.isEmpty })
    }
}
