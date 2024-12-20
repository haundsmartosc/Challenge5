import SwiftUI

struct SettingView: View {
    @EnvironmentObject var appState: AppState
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Setting")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Setting Screen")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Button(action: {
                    showLogoutAlert = true
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Logout")) {
                            appState.logout(isLoginSuccess: false)
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(AppState())
}
