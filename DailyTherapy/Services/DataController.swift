//
//  DataController.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DailyTherapy")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("❌ CoreData failed to load with error: \(error.localizedDescription)")
            }
        }
    }
}
