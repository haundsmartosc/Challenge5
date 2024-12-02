import SwiftUI

@main
struct Challenge5App: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            if appState.isLoginSuccess {
                TabViewCustom()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
