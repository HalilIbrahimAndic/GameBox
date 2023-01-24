//
//  LocalNotificationManager.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 23.01.2023.
//

import Foundation
import UserNotifications

protocol NotificationProtocol {
    func sendNotification(title: String, message: String)
}

final class LocalNotificationManager: NotificationProtocol {
    static let shared = LocalNotificationManager()
    private let notificationCenter: UNUserNotificationCenter
    
    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }
    
    func sendNotification(title: String, message: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = title
        notificationContent.subtitle = message
        notificationContent.sound = UNNotificationSound.default
        
        // I preferred to send notification when note is taken.
        // So notification must be sent immediately. 0.5 seconds later action is OK.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        self.notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

