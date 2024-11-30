import Foundation

class AppState: ObservableObject {
    @Published var isLoginSuccess: Bool = false
    @Published var user: User?
}
