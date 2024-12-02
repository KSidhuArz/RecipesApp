//
//  RecipesViewModelTest.swift
//  RecipesAppTests
//
//  Created by Ramandeep Singh on 11/26/24.
//

import XCTest
@testable import RecipesApp


final class RecipesViewModelTest: XCTestCase {
    var viewModel:RecipesViewModel!
    var mockRecipesApi = MockRecipesApi(isSuccess: true)
    
    override func setUp() {
        super.setUp()
        viewModel = RecipesViewModel(networkProtocol: mockRecipesApi)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRecipes() async{
        let expectation = XCTestExpectation(description: "Fetch Recipes list successfully")
        do{
            let response = try await viewModel.networkProtocol?.fetchData(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json", type: RecipesResponse.self)
            if let recipe = response?.result, recipe.count > 0{
                XCTAssertEqual(recipe[0].name, "Butter Chicken")
                XCTAssertEqual(recipe[0].cuisine, "Indian")
                XCTAssertEqual(recipe[0].id, "123457788")
            }
            
        }catch _{
            XCTFail("Fetch data should not fail")
        }
        expectation.fulfill()
    }
}
