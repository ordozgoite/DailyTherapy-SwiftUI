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
    
    func loadQuestions(for timeOfDay: TimeOfDay) {
        switch timeOfDay {
        case .morning:
            currentQuestions = DailyQuestions.morning
        case .night:
            currentQuestions = DailyQuestions.night
        }
    }
}
