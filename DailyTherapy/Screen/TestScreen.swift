//
//  TestScreen'.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 12/02/25.
//

import SwiftUI

struct TestScreen: View {
    
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case first, second, third
    }
    
    var body: some View {
        VStack {
            TextField("First Name", text: $text1, axis: .vertical)
                .lineLimit(3...3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focusedField, equals: .first)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .second
                }
            
            TextField("Last Name", text: $text2, axis: .vertical)
                .lineLimit(3...3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focusedField, equals: .second)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .third
                }
            
            TextField("Email", text: $text3, axis: .vertical)
                .lineLimit(3...3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focusedField, equals: .third)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil // Fecha o teclado
                }
            
            Button("Submit") {
                // Aqui você pode lidar com a submissão dos dados
                print("Enviando: \(text1), \(text2), \(text3)")
                focusedField = nil
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    TestScreen()
}
