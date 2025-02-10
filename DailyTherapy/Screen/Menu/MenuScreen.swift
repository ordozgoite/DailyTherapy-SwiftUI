//
//  MenuScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI
import CoreData

struct MenuScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                QuestionaryView(.morning)
                
                DateView()
                
                QuestionaryView(.night)
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
        let context = CoreDataManager.shared.context
        let request = NSFetchRequest<Answer>(entityName: "Answer") // Correção aqui
        
        // Obtem a data atual sem a parte da hora
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Filtra apenas respostas do dia atual e do período (manhã/noite)
        request.predicate = NSPredicate(
            format: "date >= %@ AND date < %@ AND timeOfDay == %@",
            today as NSDate,
            calendar.date(byAdding: .day, value: 1, to: today)! as NSDate,
            timeOfDay.title
        )
        
        do {
            let answers = try context.fetch(request)
            return !answers.isEmpty
        } catch {
            print("Erro ao buscar respostas de hoje: \(error)")
            return false
        }
    }


}

#Preview {
    MenuScreen()
}
