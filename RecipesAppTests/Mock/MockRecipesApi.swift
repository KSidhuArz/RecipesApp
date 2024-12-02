
//
//  MockRecipesApi.swift
//  RecipesApp
//
//  Created by Ramandeep Singh on 11/26/24.
//

import Foundation
@testable import RecipesApp


class MockRecipesApi:NetworkProtocol{
    var isSuccess:Bool
    
    init(isSuccess:Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func fetchData<T:Codable>(urlString: String, type: T.Type) async throws -> T  {
        if isSuccess{
            let recipe = Recipe(cuisine: "Indian", name: "Butter Chicken", photo_url_large: "", photo_url_small: "", source_url: "", id: "123457788")
            let data = RecipesResponse(result: [recipe])
            return try await MockRecipesApi.decodeData(data: JSONEncoder().encode(data))
        }else{
            throw NetworkError.invalidResponse
        }
    }
    
    static func decodeData<T:Codable>(data: Data) async throws -> T {
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw NetworkError.invalidResponse
        }
    }
}

