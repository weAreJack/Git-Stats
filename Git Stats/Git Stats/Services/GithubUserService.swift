//
//  GithubStatsService.swift
//  Git Stats
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 WeAreJack. All rights reserved.
//

import Foundation
import Alamofire

enum StatsRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}

class GithubUserService {
    
    private let rootEndpoint = "https://api.github.com/users/"
    
    private var username: String
    
    private var userEndpoint: String {
        return "\(self.rootEndpoint)\(username)"
    }
    
    private var repositoriesEndpoint: String {
        return "\(self.userEndpoint)/repos"
    }
    
    init(username: String){
        self.username = username
    }
    
    // TODO: Refactor into generic get
    func getUser(completion: @escaping (_ result: Result<User, StatsRequestError>) -> Void) {
        guard let url = URL(string: self.userEndpoint) else {fatalError()}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let json = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: json)
                completion(.success(user))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }.resume()
    }
    
    func getRepositories(completion: @escaping (_ result: Result<[Repository], StatsRequestError>) -> Void) {
        guard let url = URL(string: self.repositoriesEndpoint) else {fatalError()}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let json = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let respositories = try decoder.decode([Repository].self, from: json)
                completion(.success(respositories))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }.resume()
    }
}
