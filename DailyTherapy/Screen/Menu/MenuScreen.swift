//
//  MenuScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI
import CoreData

struct MenuScreen: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                QuestionaryView(.morning)
                
                DateView()
                
                QuestionaryView(.night)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingScreen()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }

                }
            }
            .navigationTitle("Reflexão Diária 📖")
        }
    }
    
    // MARK: - Questionary
    
    @ViewBuilder
    private func QuestionaryView(_ timeOfDay: TimeOfDay) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 32) {
                Text("Questionário da \(timeOfDay.title) \(timeOfDay.emoji)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                
                if hasAnsweredTodaysQuestionary(inThe: timeOfDay) {
                    Text("Respondido!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.gray)
                        .cornerRadius(12)
                        .padding(.horizontal)
                } else {
                    NavigationLink {
                        QuestionScreen(timeOfDay: timeOfDay)
                    } label: {
                        Text("Responder Questionário")
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
            }
            .padding()
            .frame(height: 150)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding()
    }
    
    // MARK: - Date
    
    @ViewBuilder
    private func DateView() -> some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
            
            Text("Hoje é \(getTodayDateFormatted())")
                .foregroundStyle(.gray)
                .font(.subheadline)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
        }
    }
    
    // MARK: - Private Methods
    
    private func getTodayDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: Date())
    }
    
    private func hasAnsweredTodaysQuestionary(inThe timeOfDay: TimeOfDay) -> Bool {
        let todaysAnswers = getAnswers(for: Date())
        return hasAnswered(todaysAnswers, inThe: timeOfDay)
    }

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
    
    private func hasAnswered(_ answers: [Answer], inThe timeOfDay: TimeOfDay) -> Bool {
        let filteredAnswers: [Answer]
        if timeOfDay == .morning {
            filteredAnswers = answers.filter { $0.questionTag <= 3 }
        } else {
            filteredAnswers = answers.filter { $0.questionTag > 3 }
        }
        return filteredAnswers.count == 3 && !filteredAnswers.contains(where: { ($0.text ?? "").isEmpty })
    }
}

#Preview {
    MenuScreen()
}
