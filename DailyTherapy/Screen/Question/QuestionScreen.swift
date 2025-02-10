//
//  QuestionScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI

struct QuestionScreen: View {
    
    @StateObject private var questionVM = QuestionViewModel()
    @State private var answers: [UUID: String] = [:]
    @FocusState private var isDescriptionTextFieldFocused: Bool
    
    var timeOfDay: TimeOfDay
    
    var body: some View {
        VStack {
            ScrollView {
                Questions()
            }
            
            SubmitButton()
        }
        .padding()
        .onAppear {
            questionVM.loadQuestions(for: timeOfDay)
        }
        .navigationTitle("\(timeOfDay.title) \(timeOfDay.emoji)")
    }
    
    // MARK: - Questions
    
    @ViewBuilder
    private func Questions() -> some View {
        VStack(spacing: 20) {
            ForEach(questionVM.currentQuestions) { question in
                QuestionView(question)
            }
        }
    }
    
    // MARK: - Question
    
    @ViewBuilder
    private func QuestionView(_ question: Question) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(question.text)
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.gray)
            
            TextField("Digite sua resposta...", text: Binding(
                get: { answers[question.id] ?? "" },
                set: { newValue in
                    if newValue.last == "\n" {
                        isDescriptionTextFieldFocused = false
                    } else {
                        answers[question.id] = newValue
                    }
                }
            ), axis: .vertical)
            .lineLimit(3...3)
            .textFieldStyle(.plain)
            .padding(.bottom, 10)
            .focused($isDescriptionTextFieldFocused)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    
    // MARK: - Button
    
    @ViewBuilder
    private func SubmitButton() -> some View {
        Button {
            saveAnswers()
            // TODO: Dismiss Screen
        } label: {
            Text("Salvar Respostas")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Private Methods
    
    private func saveAnswers() {
        for (questionID, answerText) in answers {
            if let question = questionVM.currentQuestions.first(where: { $0.id == questionID }) {
                CoreDataManager.shared.saveAnswer(question: question.text, answer: answerText)
            }
        }
    }
}

#Preview {
    QuestionScreen(timeOfDay: .morning)
}
