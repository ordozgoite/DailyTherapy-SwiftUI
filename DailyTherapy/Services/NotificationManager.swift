//
//  NotificationManager.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 11/02/25.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManager: ObservableObject {

    static let shared = NotificationManager()
    private let soundName = "notification-sound"

    @Published var isMorningNotificationsEnabled: Bool = false
    @Published var morningNotificationTime = Date()
    
    @Published var isNightNotificationsEnabled: Bool = false
    @Published var nightNotificationTime = Date()

    init() {
        loadSettingsFromUserDefaults()
    }

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("❌ Error: \(error)")
            } else {
                print("✅ Success!")
                self.saveUserDefaultsSettings()
            }
        }
    }

    func scheduleNotification(_ timeOfDay: TimeOfDay, atTime scheduledTime: Date) {
        let content = UNMutableNotificationContent()
        content.title = timeOfDay == .morning ? Constants.MORNING_NOTIFICATION_TITLE : Constants.NIGHT_NOTIFICATION_TITLE
        content.body = timeOfDay == .morning ? Constants.MORNING_NOTIFICATION_BODY : Constants.NIGHT_NOTIFICATION_BODY
//        content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "notification-sound.wav"))

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: scheduledTime)
        guard let hour = components.hour, let minute = components.minute else {
            print("❌ Erro ao obter componentes da data.")
            return
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
        saveUserDefaultsSettings()
    }

    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        saveUserDefaultsSettings()
    }

    func saveUserDefaultsSettings() {
        LocalState.isMorningNotificationsEnabled = isMorningNotificationsEnabled
        LocalState.isNightNotificationsEnabled = isNightNotificationsEnabled
        LocalState.morningNotificationTime = morningNotificationTime
        LocalState.nightNotificationTime = nightNotificationTime
    }

    func loadSettingsFromUserDefaults() {
        print("⏰ \(LocalState.isNightNotificationsEnabled)")
        print("⏰ \(LocalState.isMorningNotificationsEnabled)")
        isNightNotificationsEnabled = LocalState.isNightNotificationsEnabled
        isMorningNotificationsEnabled = LocalState.isMorningNotificationsEnabled
        nightNotificationTime = LocalState.nightNotificationTime
        morningNotificationTime = LocalState.morningNotificationTime
    }
}

