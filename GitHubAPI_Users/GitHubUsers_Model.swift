import Foundation

struct GitHubUsers_Model : Codable, Identifiable {
    let id: Int
      let login: String
      let avatar_url: String
      let html_url: String
}
