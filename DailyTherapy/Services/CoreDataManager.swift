////
////  CoreDataManager.swift
////  DailyTherapy
////
////  Created by Victor Ordozgoite on 10/02/25.
////
//
//import Foundation
//import CoreData
//
//class CoreDataManager {
//    
//    static let shared = CoreDataManager()
//    
//    let persistentContainer: NSPersistentContainer
//    
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "DailyTherapyModel")
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Erro ao carregar Core Data: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
//    func saveAnswer(question: String, answer: String) {
//        let context = persistentContainer.newBackgroundContext()
//        
//        context.perform {
//            let newAnswer = Answer(context: context)
//            newAnswer.id = UUID()
//            newAnswer.questionText = question
//            newAnswer.answerText = answer
//            newAnswer.date = Date()
//            
//            do {
//                try context.save()
//            } catch {
//                assertionFailure("Erro ao salvar resposta: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func fetchAnswers() -> [Answer] {
//        let request = Answer.fetchRequest() as! NSFetchRequest<Answer>
//        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//        
//        do {
//            return try context.fetch(request)
//        } catch {
//            assertionFailure("Erro ao buscar respostas: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//    func deleteAnswer(_ answer: Answer) {
//        let context = persistentContainer.viewContext
//        context.delete(answer)
//        
//        do {
//            try context.save()
//        } catch {
//            assertionFailure("Erro ao deletar resposta: \(error.localizedDescription)")
//        }
//    }
//}
