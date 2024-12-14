//
//  MockGrocereeAPI.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

class MockGrocereeAPI: GrocereeAPIProtocol {
    private var database = MockDatabase.recipes
    private var nextId = MockDatabase.recipes.count + 1
    
    func fetchRecipesList() async throws -> APIResponse<[APIRecipeListItem]> {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        return APIResponse(
            status: .success,
            data: MockDatabase.recipeListItems,
            message: nil
        )
    }
    
    func fetchRecipe(id: Int) async throws -> APIResponse<APIRecipe> {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let recipe = database.first(where: { $0.id == id }) else {
            return APIResponse(
                status: .error,
                data: APIRecipe(
                    id: 0,
                    name: "",
                    imageUrl: nil,
                    duration: 0,
                    servings: 2,
                    isFavorite: false,
                    ingredients: [],
                    instructions: []
                ),
                message: "Recipe not found"
            )
        }
        
        return APIResponse(
            status: .success,
            data: recipe,
            message: nil
        )
    }
    
    func createRecipe(_ recipe: CreateRecipeRequest) async throws -> APIResponse<Int> {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        let id = nextId
        nextId += 1
        
        let newRecipe = APIRecipe(
            id: id,
            name: recipe.name,
            imageUrl: recipe.imageUrl,
            duration: recipe.duration,
            servings: recipe.servings,
            isFavorite: false,
            ingredients: recipe.ingredients.enumerated().map { index, ingredient in
                APIIngredient(
                    id: id * 100 + index,
                    name: ingredient.name,
                    amount: ingredient.amount
                )
            },
            instructions: recipe.instructions.map { instruction in
                APIInstruction(
                    id: id * 100 + instruction.step,
                    step: instruction.step,
                    instruction: instruction.instruction
                )
            }
        )
        
        database.append(newRecipe)
        
        return APIResponse(
            status: .success,
            data: id,
            message: nil
        )
    }
}
