//
//  QuestionScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI
import CoreData

struct QuestionScreen: View {
    
    enum Field {
        case first, second, third
    }
    
    @Environment(\.managedObjectContext) var moc
    @StateObject private var questionVM = QuestionViewModel()
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) private var dismiss
    
    var timeOfDay: TimeOfDay
    
    var body: some View {
        VStack {
            ScrollView {
                Questions()
                
                SubmitButton()
            }
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
            
            TextField(
                "Digite sua resposta...",
                text: $questionVM.answers[getIndex(fromQuestionTag: question.tag)],
                axis: .vertical
            )
            .lineLimit(3...3)
            .textFieldStyle(.plain)
            .padding(.bottom, 10)
            .focused($focusedField, equals: getField(fromQuestionTag: question.tag))
            .submitLabel(getSubmitLabel(forQuestionTag: question.tag))
            .onChange(of: questionVM.answers[getIndex(fromQuestionTag: question.tag)]) { newValue in
                if newValue.contains("\n") {
                    questionVM.answers[getIndex(fromQuestionTag: question.tag)] = newValue.replacingOccurrences(of: "\n", with: "")
                    handleReturn(for: getField(fromQuestionTag: question.tag))
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    
    // MARK: - Button
    
    @ViewBuilder
    private func SubmitButton() -> some View {
        Button {
            persistAnswers()
            dismiss()
        } label: {
            Text("Salvar Respostas")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(questionVM.areInputsValid() ? .blue : .gray)
                .cornerRadius(12)
                .padding(.top)
        }
        .disabled(!questionVM.areInputsValid())
    }
    
    // MARK: - Private Methods
    
    // Essas funções são usadas e usam umas as outras de maneira muito complexa
    // Tentar, um dia, deixar a lógica dessa tela mais simples
    
    private func handleReturn(for field: Field) {
        switch field {
        case .first:
            focusedField = .second
        case .second:
            focusedField = .third
        case .third:
            focusedField = nil
        }
    }
    
    private func getField(fromQuestionTag tag: Int) -> Field {
        let index = getIndex(fromQuestionTag: tag)
        return switch index {
        case 0: .first
        case 1: .second
        case 2: .third
        default:
                .third
        }
    }
    
    private func getSubmitLabel(forQuestionTag tag: Int) -> SubmitLabel {
        let index = getIndex(fromQuestionTag: tag)
        return switch index {
        case 0: .continue
        case 1: .continue
        case 2: .done
        default:
                .done
        }
    }
    
    private func getIndex(fromQuestionTag tag: Int) -> Int {
        return switch timeOfDay {
        case .morning:
            tag - 1
        case .night:
            tag - 4
        }
    }
    
    private func getQuestionTag(fromIndex index: Int) -> Int {
        return timeOfDay == .morning ? index : index + 3
    }
    
    private func persistAnswers() {
        for i in  1...3 {
            let tag = getQuestionTag(fromIndex: i)
            
            let answerText = questionVM.answers[getIndex(fromQuestionTag: tag)]
            
            let newAnswer = Answer(context: moc)
            newAnswer.id = UUID()
            newAnswer.text = answerText
            newAnswer.questionTag = Int16(tag)
            newAnswer.date = Date()
            
            try? moc.save()
        }
    }
}

#Preview {
    QuestionScreen(timeOfDay: .morning)
}
