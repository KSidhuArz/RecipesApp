//
//  RecipesViewModel.swift
//  RecipesApp

import Foundation
class RecipesViewModel:ObservableObject{
    
    var networkProtocol:NetworkProtocol?
    
    init(networkProtocol: NetworkProtocol? = nil) {
        self.networkProtocol = networkProtocol
    }
    @Published var recipesList:[Recipe] = []
    
    func fetchRecipes() async{
        do{
            let response = try await networkProtocol?.fetchData(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json", type: RecipesResponse.self)
            if let recipe = response?.result, recipe.count > 0{
                fillResponse(response: recipe)
            }else{
                fillResponse(response: [])
            }
        }catch{
            fillResponse(response: [])
        }
    }
    
    func fillResponse(response:[Recipe]){
        DispatchQueue.main.async {
            self.recipesList = response
        }
    }
}
