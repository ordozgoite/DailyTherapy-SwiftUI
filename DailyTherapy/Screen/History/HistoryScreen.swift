//
//  AnswerHistoryScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI
import CoreData

struct HistoryScreen: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var answers: FetchedResults<Answer>
    
    @State private var selectedDate = Date.now
    @State private var answersForSelectedDate: [Answer] = [] // Armazena as respostas filtradas

    var body: some View {
        NavigationStack {
            ScrollView {
                Calendar()
                
                Answers()
            }
            .navigationTitle("Histórico")
        }
        .onAppear {
            fetchAnswers()
        }
        .onChange(of: selectedDate) { _ in
            fetchAnswers()
        }
    }
    
    // MARK: - Calendar
    
    @ViewBuilder
    private func Calendar() -> some View {
        DatePicker(selection: $selectedDate, in: ...Date.now, displayedComponents: .date) {
            Text("Select a date")
        }
        .datePickerStyle(.graphical)
    }
    
    // MARK: - Answers
    
    @ViewBuilder
    private func Answers() -> some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Manhã ☀️")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                ForEach(answersForSelectedDate.filter { $0.questionTag <= 3 }) { answer in
                    AnswerDisplayView(
                        questionText: DailyQuestions.morning[getIndex(fromQuestionTag: Int(answer.questionTag), andTimeOfDay: .morning)].text,
                        answerText: answer.text ?? "Não Repondido"
                    )
                }
                
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Noite 🌙")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                ForEach(answersForSelectedDate.filter { $0.questionTag > 3 }) { answer in
                    AnswerDisplayView(
                        questionText: DailyQuestions.night[getIndex(fromQuestionTag: Int(answer.questionTag), andTimeOfDay: .night)].text,
                        answerText: answer.text ?? "Não Repondido"
                    )
                }
                
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding([.leading, .trailing], 8)
    }
    
    // MARK: - Answer
    
    @ViewBuilder
    private func AnswerDisplayView(questionText: String, answerText: String) -> some View {
        VStack(alignment: .leading) {
            Text(questionText)
                .font(.callout)
            
            Text(answerText)
                .font(.headline)
                .foregroundStyle(.gray)
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchAnswers() {
        let fetchedAnswers = getAnswers(for: selectedDate)
        answersForSelectedDate = fetchedAnswers
        print(fetchedAnswers) // Imprime o array no console
    }
    
//    private func getTimeOfDay(forQuestionTag tag: Int) -> TimeOfDay {
//        return tag <= 3 ? .morning : .night
//    }
    
    private func getAnswers(for date: Date) -> [Answer] {
        let calendar = Foundation.Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return []
        }
        
        let request: NSFetchRequest<Answer> = Answer.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            return try moc.fetch(request)
        } catch {
            print("Erro ao buscar respostas: \(error.localizedDescription)")
            return []
        }
    }
    
    private func getIndex(fromQuestionTag tag: Int, andTimeOfDay timeOfDay: TimeOfDay) -> Int {
        return switch timeOfDay {
        case .morning:
            tag - 1
        case .night:
            tag - 4
        }
    }
}

#Preview {
    HistoryScreen()
}
