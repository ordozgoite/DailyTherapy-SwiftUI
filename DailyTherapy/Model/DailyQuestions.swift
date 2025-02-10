//
//  DailyQuestions.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import Foundation

enum DailyQuestions {
    static let morning: [Question] = [
        Question(text: "Por qual motivo você se sente grato hoje?"),
        Question(text: "O que faria deste dia um dia incrível?"),
        Question(text: "Qual pensamento positivo você quer levar para o dia?")
    ]
    
    static let night: [Question] = [
        Question(text: "Que atitude sua fez diferença para alguém hoje?"),
        Question(text: "O que você poderia ter feito melhor hoje?"),
        Question(text: "Qual foi o melhor momento do seu dia?")
    ]
}
