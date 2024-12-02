import Foundation

class AppState: ObservableObject {
    @Published private var isLoginSuccess: Bool = false
    @Published private var user: User?
    func saveLogin(isLoginSuccess: Bool, user: User) {
        self.isLoginSuccess = isLoginSuccess
        self.user = user
    }
    
    func setIsLoginSuccess(isLoginSuccess: Bool) {
        self.isLoginSuccess = isLoginSuccess
    }
    
    func settUser(user: User) {
        self.user = user
    }
    
    func getIsLoginSuccess() -> Bool{
        return self.isLoginSuccess
    }
    
    func getUser() -> User? {
        if let user = user {
            return user
        }
        return nil
    }
    
}
