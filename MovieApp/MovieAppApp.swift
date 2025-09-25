//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 23/09/2025.
//

import SwiftUI

@main
struct MovieApp: App {
    // register app delegate for handling notifications or app lifecycle events
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(delegate) // pass delegate as environment object if needed
        }
    }
}

// AppDelegate to handle notifications or app lifecycle events
class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    // Notification related state
    @Published var openedFromNotification: Bool = false
    @Published var openedOrderDetails: Bool = false
    @Published var openedChatRoom: Bool = false
    @Published var orderId: Int?
    
    // Add other state variables here as needed
}
