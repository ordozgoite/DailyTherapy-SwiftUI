//
//  SettingScreen.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 11/02/25.
//

import SwiftUI

struct SettingScreen: View {
    
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        Form {
            MorningNotification()
            
            NightNotification()
        }
        .onChange(of: notificationManager.isMorningNotificationsEnabled) { isNotificationsEnabled in
            if isNotificationsEnabled {
                notificationManager.requestAuthorization()
            } else {
                notificationManager.cancelNotifications()
            }
        }
        .onChange(of: notificationManager.isNightNotificationsEnabled) { isNotificationsEnabled in
            if isNotificationsEnabled {
                notificationManager.requestAuthorization()
            } else {
                notificationManager.cancelNotifications()
            }
        }
        .onChange(of: notificationManager.morningNotificationTime) { time in
            notificationManager.cancelNotifications()
            notificationManager.scheduleNotification(.morning, atTime: time)
        }
        .onChange(of: notificationManager.nightNotificationTime) { time in
            notificationManager.cancelNotifications()
            notificationManager.scheduleNotification(.night, atTime: time)
        }
        .navigationTitle("Notificações")
    }
    
    // MARK: - Morning
    
    @ViewBuilder
    private func MorningNotification() -> some View {
        Section(
            header: Text("Notificações da Manhã ☀️"),
            footer: Text(notificationManager.isMorningNotificationsEnabled ? "Lembraremos você de responder o questionário da manhã no horário selecionado." : "")
        ) {
            Toggle("Ativar Notificação", isOn: $notificationManager.isMorningNotificationsEnabled )
            if notificationManager.isMorningNotificationsEnabled  {
                DatePicker("Horário", selection: $notificationManager.morningNotificationTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
            }
        }
    }
    
    // MARK: - Night
    
    @ViewBuilder
    private func NightNotification() -> some View {
        Section(
            header: Text("Notificações da Noite 🌙"),
            footer: Text(notificationManager.isNightNotificationsEnabled ? "Lembraremos você de responder o questionário da noite no horário selecionado." : "")
        ) {
            Toggle("Ativar Notificação", isOn: $notificationManager.isNightNotificationsEnabled)
            if notificationManager.isNightNotificationsEnabled {
                DatePicker("Horário", selection: $notificationManager.nightNotificationTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
            }
        }
    }
}

#Preview {
    SettingScreen()
}
