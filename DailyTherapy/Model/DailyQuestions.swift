//
//  DailyQuestions.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation

enum DailyQuestions {
    static let morning: [Question] = [
        Question(text: "Por qual motivo você se sente grato hoje?", tag: 1),
        Question(text: "O que faria deste dia um dia incrível?", tag: 2),
        Question(text: "Qual pensamento positivo você quer levar para o dia?", tag: 3)
    ]
    
    static let night: [Question] = [
        Question(text: "Que atitude sua fez diferença para alguém hoje?", tag: 4),
        Question(text: "O que você poderia ter feito melhor hoje?", tag: 5),
        Question(text: "Qual foi o melhor momento do seu dia?", tag: 6)
    ]
}
