import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var account: String
    var password: String
}
