import SwiftUI
import UserNotifications

struct TabViewCustom: View {
    @EnvironmentObject var appState: AppState
    @State private var selection = 0
    @State private var isAllowed: Bool = false
    @State private var savedBackgroundColor = Color.white
    var body: some View {
        TabView(selection: $selection) {
            //MARK: HOME
            NavigationView {
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
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            
            //MARK: LIST
            NavigationView {
                ListView()
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("List")
            }
            .tag(1)
            
            
            //MARK: SETTING
            NavigationView {
                SettingView()
                    .environmentObject(appState)
            }
            .tabItem {
                Image(systemName: "wrench.adjustable")
                Text("Setting")
            }
            .tag(2)
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
    TabViewCustom()
        .environmentObject(AppState())
}
