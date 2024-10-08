import Foundation
import SwiftUI
import Combine

class GitHubUsers_ViewModel : ObservableObject {
    @Published var users : [GitHubUsers_Model] = []
    private var lastUserID: Int?

    private var cancellables = Set<AnyCancellable>()
    
    private var cache: [String: [GitHubUsers_Model]] = [:]

    @Published var searchQuery: String = ""
    init() {
           $searchQuery
               .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
               .removeDuplicates()
               .sink { [weak self] query in
                   self?.searchUser(query)
               }
               .store(in: &cancellables)
       }

    
    func getUsers() {
        var urlComponents = URLComponents(string: "https://api.github.com/users")!
        var queryItems = [URLQueryItem(name: "per_page", value: "5")]

        if let lastUserID = lastUserID {
                    queryItems.append(URLQueryItem(name: "since", value: "\(lastUserID)"))
                }
        
      
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        
            .map{$0.data}
            .decode(type: [GitHubUsers_Model].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complition in
                switch complition {
                case .finished:
                    print("success")
                case .failure(let error):
                    print("\(error)")
                }
            }, receiveValue: { users in
                    
                self.users.append(contentsOf: users)
                self.lastUserID = users.last?.id
                
            })
            .store(in: &cancellables)
    }
    func searchUser(_ userName: String) {
        guard !userName.isEmpty else { return }

        
        // 캐시에 데이터가 있는지 확인
             if let cachedUsers = cache[userName] {
                 self.users = cachedUsers
                 return
             }
        
        let urlString = "https://api.github.com/search/users?q=\(userName)"
        guard let url = URL(string: urlString) else { return }

    
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("success")
                case .failure(let error):
                    print("또이러내 시벌탱!!!( 핑구 짤)")
                    print("Error: \(error)")
                }
            }, receiveValue: { result in
                self.users = result.items
                self.cache[userName] = self.users

            })
            .store(in: &cancellables)

    }
   
}
