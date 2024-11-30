import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var acccount: String = ""
    @State private var password: String = ""
    @State private var loginError: Bool = false
    
    var users: [User] = load("DataTest.json")
    
    func checkLogin () {
        for user in users {
            if user.account == acccount && user.password == password {
                appState.user = user
                appState.isLoginSuccess = true
                loginError = false
                return
            }
        }
        loginError = true
    }

    var body: some View {
        VStack {
            Text("Login")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack {
                TextField("Account", text: $acccount)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(loginError ? Color.red : Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .onChange(of: acccount) {
                        loginError = false
                    }
                
                SecureField("Password", text: $password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(loginError ? Color.red : Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .onChange(of: password) {
                        loginError = false
                    }
                
                if loginError {
                    Text("Invalid account or password")
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                Button(action: {
                    checkLogin()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)

            Spacer()

            if appState.isLoginSuccess {
                NavigationLink(destination: TabViewCustom()) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .navigationBarHidden(true)
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \(error)")
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
