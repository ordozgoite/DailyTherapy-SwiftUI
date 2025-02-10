//
//  MainTabView.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 10/02/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MenuScreen()
                .tabItem {
                    Label("Responder", systemImage: "square.and.pencil")
                }
            
            HistoryScreen()
                .tabItem {
                    Label("Histórico", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                }
        }
    }
}

#Preview {
    MainTabView()
}
