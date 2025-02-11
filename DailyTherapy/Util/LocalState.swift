//
//  LocalState.swift
//  DailyTherapy
//
//  Created by Victor Ordozgoite on 11/02/25.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case isMorningNotificationsEnabled
        case morningNotificationTime
        
        case isNightNotificationsEnabled
        case nightNotificationTime
    }
    
    public static var isMorningNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isMorningNotificationsEnabled.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isMorningNotificationsEnabled.rawValue)
        }
    }
    
    public static var morningNotificationTime: Date {
        get {
            return UserDefaults.standard.object(forKey: Keys.morningNotificationTime.rawValue) as? Date ?? Date()
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.morningNotificationTime.rawValue)
        }
    }
    
    public static var isNightNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isNightNotificationsEnabled.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isNightNotificationsEnabled.rawValue)
        }
    }
    
    public static var nightNotificationTime: Date {
        get {
            return UserDefaults.standard.object(forKey: Keys.nightNotificationTime.rawValue) as? Date ?? Date()
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.nightNotificationTime.rawValue)
        }
    }
}
