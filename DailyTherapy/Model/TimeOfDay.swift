//
//  TimeOfDay.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation

enum TimeOfDay: CaseIterable {
    case morning
    case night
    
    var title: String {
        return switch self {
        case .morning:
            "Manhã"
        case .night:
            "Noite"
        }
    }
    
    var emoji: String {
        return switch self {
        case .morning:
            "☀️"
        case .night:
            "🌙"
        }
    }
}
