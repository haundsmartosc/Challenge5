//
//  HomeView.swift
//  Challenge5
//
//  Created by Nguyễn Đức Hậu on 02/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var isAllowed: Bool = false
    @State private var savedBackgroundColor = Color.white
    var body: some View {
                ZStack {
                    savedBackgroundColor
                        .ignoresSafeArea()
                    VStack {
                        if let user = appState.user {
                            Text("Welcome, \(user.account)")
                                .font(.headline)
                        } else {
                            Text("Please log in.")
                                .font(.subheadline)
                        }
                        
                        Text("Notification Permission Granted")
                            .foregroundColor(isAllowed ? .green : .red)
                        
                        Button(action: {
                            requestNotificationPermission()
                        }) {
                            Text("Request Notification")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: DetailHomeView(savedBackgroundColor: $savedBackgroundColor)) {
                            Text("Go to Detail View")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        .navigationTitle("Home")
                        
                        Button(action: {
                            savedBackgroundColor = .white
                        }) {
                            Text("Reset Color")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                // Nếu quyền chưa được quyết định, yêu cầu quyền
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        isAllowed = true
                        
                    } else {
                        isAllowed = false
                        print("Notification permission denied")
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("User has previously denied notifications")
            } else {
                print("Notifications are already authorized")
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
