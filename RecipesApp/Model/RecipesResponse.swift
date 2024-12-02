//
//  Recipes.swift
//  Fetch_Recipes_App

import Foundation

struct RecipesResponse:Codable{
    var result:[Recipe]
    
    enum CodingKeys: String,CodingKey {
        case result = "recipes"
    }
}

struct Recipe:Codable,Identifiable{
    let cuisine: String?
    let name: String?
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let id:String
    
    enum CodingKeys: String,CodingKey {
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case source_url
        case id = "uuid"
    }
    
    init(cuisine: String?, name: String?, photo_url_large: String?, photo_url_small: String?, source_url: String?, id: String) {
        self.cuisine = cuisine
        self.name = name
        self.photo_url_large = photo_url_large
        self.photo_url_small = photo_url_small
        self.source_url = source_url
        self.id = id
    }
    
}
