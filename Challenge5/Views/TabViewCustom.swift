import SwiftUI
import UserNotifications

struct TabViewCustom: View {
    @EnvironmentObject var appState: AppState
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            //MARK: HOME
            NavigationView {
                HomeView()
                .environmentObject(appState)
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
}

#Preview {
    TabViewCustom()
        .environmentObject(AppState())
}
