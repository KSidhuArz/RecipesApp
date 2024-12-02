//
//  NetworkManager.swift
//  Fetch_Recipes_App


import Foundation

class NetworkManager:NetworkProtocol{
    func fetchData<T:Codable>(urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else{
            throw NetworkError.invalidUrl
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw NetworkError.invalidResponse
        }
        switch httpResponse.statusCode{
        case 200..<300:
            return try await NetworkManager.decodeData(data: data)
        case 400..<499:
            throw NetworkError.clientError
        case 500..<599:
            throw NetworkError.serverError
        default:
            throw NetworkError.invalidResponse
        }
    }
    
    static func decodeData<T:Codable>(data:Data) async throws-> T{
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw NetworkError.invalidResponse
        }
    }
}
