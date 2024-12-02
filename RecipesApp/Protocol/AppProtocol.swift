//
//  AppProtocol.swift
//  Fetch_Recipes_App
//

import Foundation

protocol RecipesViewModelProtocol{
    func successfullResponse()
    func failureResponse()
}

protocol NetworkProtocol{
    func fetchData<T:Codable>(urlString:String, type: T.Type) async throws -> T
    static func decodeData<T:Codable>(data:Data) async throws-> T
}

enum NetworkError:Error{
    case invalidUrl
    case invalidResponse
    case invalidRequest
    case unknown
    case clientError
    case serverError
}
