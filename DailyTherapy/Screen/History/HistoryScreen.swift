//
//  AnswerHistoryScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI
import CoreData

struct HistoryScreen: View {
    
    @FetchRequest(sortDescriptors: []) var answers: FetchedResults<Answer>
    
    var body: some View {
        NavigationStack {
            VStack {
                List(answers) { answer in
                    Text(answer.text ?? "nil") // change nil coalescing text?
                }
            }
            .navigationTitle("Histórico")
        }
    }
}

#Preview {
    HistoryScreen()
}
