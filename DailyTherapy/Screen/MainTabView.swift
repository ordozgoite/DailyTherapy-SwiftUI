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
                    Label("Diário", systemImage: "square.and.pencil")
                }
            
            HistoryScreen()
                .tabItem {
                    Label("Histórico", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    MainTabView()
}
