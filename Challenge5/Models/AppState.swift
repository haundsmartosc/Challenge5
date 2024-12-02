import Foundation

class AppState: ObservableObject {
    @Published var isLoginSuccess: Bool = false
    @Published var user: User?
    func saveLogin(isLoginSuccess: Bool, user: User) {
        self.isLoginSuccess = isLoginSuccess
        self.user = user
    }
    
    
    func logout(isLoginSuccess: Bool) {
        self.user = nil
        self.isLoginSuccess = false
    }
}
//
