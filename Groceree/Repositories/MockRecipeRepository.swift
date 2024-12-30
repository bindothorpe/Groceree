//
//  MockRecipeRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

class MockRecipeRepository: RecipeRepositoryProtocol {
    
    private var recipes: [Recipe] = [
        // User 1 - John (Professional Chef)
        Recipe(
            id: 1,
            author: Author(id: "1234", firstName: "John"),
            name: "Pasta Carbonara",
            imageUrl: "https://example.com/carbonara.jpg",
            duration: 30,
            servings: 2,
            ingredients: [
                Ingredient(id: 1, name: "Spaghetti", amount: 200, unit: .grams),
                Ingredient(id: 2, name: "Eggs", amount: 2, unit: .pieces),
                Ingredient(id: 3, name: "Parmesan", amount: 50, unit: .grams)
            ],
            instructions: [
                Instruction(id: 1, step: 1, instruction: "Cook pasta al dente"),
                Instruction(id: 2, step: 2, instruction: "Mix eggs and cheese"),
                Instruction(id: 3, step: 3, instruction: "Combine and serve hot")
            ],
            isFavorite: true
        ),
        Recipe(
            id: 2,
            author: Author(id: "1234", firstName: "John"),
            name: "Classic Burger",
            imageUrl: "https://example.com/burger.jpg",
            duration: 45,
            servings: 4,
            ingredients: [
                Ingredient(id: 4, name: "Ground Beef", amount: 500, unit: .grams),
                Ingredient(id: 5, name: "Buns", amount: 4, unit: .pieces),
                Ingredient(id: 6, name: "Lettuce", amount: 1, unit: .pieces)
            ],
            instructions: [
                Instruction(id: 4, step: 1, instruction: "Form beef into patties"),
                Instruction(id: 5, step: 2, instruction: "Grill until desired doneness"),
                Instruction(id: 6, step: 3, instruction: "Assemble with toppings")
            ],
            isFavorite: false
        ),
        Recipe(
            id: 3,
            author: Author(id: "1234", firstName: "John"),
            name: "Beef Wellington",
            imageUrl: "https://example.com/wellington.jpg",
            duration: 120,
            servings: 6,
            ingredients: [
                Ingredient(id: 7, name: "Beef Tenderloin", amount: 1000, unit: .grams),
                Ingredient(id: 8, name: "Puff Pastry", amount: 1, unit: .pieces),
                Ingredient(id: 9, name: "Mushrooms", amount: 400, unit: .grams)
            ],
            instructions: [
                Instruction(id: 7, step: 1, instruction: "Sear the beef"),
                Instruction(id: 8, step: 2, instruction: "Prepare mushroom duxelles"),
                Instruction(id: 9, step: 3, instruction: "Wrap and bake")
            ],
            isFavorite: true
        ),
        Recipe(
            id: 4,
            author: Author(id: "1234", firstName: "John"),
            name: "Crème Brûlée",
            imageUrl: "https://example.com/cremebrulee.jpg",
            duration: 60,
            servings: 4,
            ingredients: [
                Ingredient(id: 10, name: "Heavy Cream", amount: 500, unit: .milliliters),
                Ingredient(id: 11, name: "Vanilla Bean", amount: 1, unit: .pieces),
                Ingredient(id: 12, name: "Sugar", amount: 100, unit: .grams)
            ],
            instructions: [
                Instruction(id: 10, step: 1, instruction: "Heat cream with vanilla"),
                Instruction(id: 11, step: 2, instruction: "Mix with egg yolks"),
                Instruction(id: 12, step: 3, instruction: "Bake in water bath")
            ],
            isFavorite: false
        ),
        
        // User 2 - Sarah (Home Cook)
        Recipe(
            id: 5,
            author: Author(id: "5678", firstName: "Sarah"),
            name: "Banana Bread",
            imageUrl: "https://example.com/bananabread.jpg",
            duration: 70,
            servings: 8,
            ingredients: [
                Ingredient(id: 13, name: "Ripe Bananas", amount: 3, unit: .pieces),
                Ingredient(id: 14, name: "Flour", amount: 250, unit: .grams),
                Ingredient(id: 15, name: "Brown Sugar", amount: 100, unit: .grams)
            ],
            instructions: [
                Instruction(id: 13, step: 1, instruction: "Mash bananas"),
                Instruction(id: 14, step: 2, instruction: "Mix dry ingredients"),
                Instruction(id: 15, step: 3, instruction: "Combine and bake")
            ],
            isFavorite: true
        ),
        Recipe(
            id: 6,
            author: Author(id: "5678", firstName: "Sarah"),
            name: "Chicken Soup",
            imageUrl: "https://example.com/chickensoup.jpg",
            duration: 90,
            servings: 6,
            ingredients: [
                Ingredient(id: 16, name: "Chicken", amount: 1000, unit: .grams),
                Ingredient(id: 17, name: "Carrots", amount: 3, unit: .pieces),
                Ingredient(id: 18, name: "Celery", amount: 3, unit: .pieces)
            ],
            instructions: [
                Instruction(id: 16, step: 1, instruction: "Boil chicken"),
                Instruction(id: 17, step: 2, instruction: "Add vegetables"),
                Instruction(id: 18, step: 3, instruction: "Simmer until done")
            ],
            isFavorite: false
        ),
        
        // User 3 - Marco (Italian Chef)
        Recipe(
            id: 7,
            author: Author(id: "9012", firstName: "Marco"),
            name: "Risotto ai Funghi",
            imageUrl: "https://example.com/risotto.jpg",
            duration: 45,
            servings: 4,
            ingredients: [
                Ingredient(id: 19, name: "Arborio Rice", amount: 320, unit: .grams),
                Ingredient(id: 20, name: "Porcini Mushrooms", amount: 200, unit: .grams),
                Ingredient(id: 21, name: "White Wine", amount: 200, unit: .milliliters)
            ],
            instructions: [
                Instruction(id: 19, step: 1, instruction: "Toast rice"),
                Instruction(id: 20, step: 2, instruction: "Add wine and broth gradually"),
                Instruction(id: 21, step: 3, instruction: "Finish with parmesan")
            ],
            isFavorite: true
        ),
        Recipe(
            id: 8,
            author: Author(id: "9012", firstName: "Marco"),
            name: "Tiramisu",
            imageUrl: "https://example.com/tiramisu.jpg",
            duration: 40,
            servings: 8,
            ingredients: [
                Ingredient(id: 22, name: "Mascarpone", amount: 500, unit: .grams),
                Ingredient(id: 23, name: "Ladyfingers", amount: 24, unit: .pieces),
                Ingredient(id: 24, name: "Espresso", amount: 300, unit: .milliliters)
            ],
            instructions: [
                Instruction(id: 22, step: 1, instruction: "Prepare coffee mixture"),
                Instruction(id: 23, step: 2, instruction: "Layer soaked ladyfingers"),
                Instruction(id: 24, step: 3, instruction: "Chill overnight")
            ],
            isFavorite: false
        ),
        
        // User 4 - Maya (Vegan Chef)
        Recipe(
            id: 9,
            author: Author(id: "3456", firstName: "Maya"),
            name: "Chickpea Curry",
            imageUrl: "https://example.com/curry.jpg",
            duration: 35,
            servings: 4,
            ingredients: [
                Ingredient(id: 25, name: "Chickpeas", amount: 400, unit: .grams),
                Ingredient(id: 26, name: "Coconut Milk", amount: 400, unit: .milliliters),
                Ingredient(id: 27, name: "Curry Powder", amount: 2, unit: .tablespoons)
            ],
            instructions: [
                Instruction(id: 25, step: 1, instruction: "Sauté onions and spices"),
                Instruction(id: 26, step: 2, instruction: "Add chickpeas and coconut milk"),
                Instruction(id: 27, step: 3, instruction: "Simmer until thickened")
            ],
            isFavorite: true
        ),
        Recipe(
            id: 10,
            author: Author(id: "3456", firstName: "Maya"),
            name: "Quinoa Buddha Bowl",
            imageUrl: "https://example.com/buddhabowl.jpg",
            duration: 25,
            servings: 2,
            ingredients: [
                Ingredient(id: 28, name: "Quinoa", amount: 200, unit: .grams),
                Ingredient(id: 29, name: "Sweet Potato", amount: 1, unit: .pieces),
                Ingredient(id: 30, name: "Kale", amount: 100, unit: .grams)
            ],
            instructions: [
                Instruction(id: 28, step: 1, instruction: "Cook quinoa"),
                Instruction(id: 29, step: 2, instruction: "Roast vegetables"),
                Instruction(id: 30, step: 3, instruction: "Assemble bowl")
            ],
            isFavorite: false
        ),
        
        // Additional recipes for each user...
        // John
        Recipe(
            id: 11,
            author: Author(id: "1234", firstName: "John"),
            name: "Seafood Paella",
            imageUrl: "https://example.com/paella.jpg",
            duration: 80,
            servings: 6,
            ingredients: [], // Add appropriate ingredients
            instructions: [], // Add appropriate instructions
            isFavorite: true
        ),
        Recipe(
            id: 12,
            author: Author(id: "1234", firstName: "John"),
            name: "French Onion Soup",
            imageUrl: "https://example.com/onionsoup.jpg",
            duration: 90,
            servings: 4,
            ingredients: [],
            instructions: [],
            isFavorite: false
        ),
        
        // Sarah
        Recipe(
            id: 13,
            author: Author(id: "5678", firstName: "Sarah"),
            name: "Apple Pie",
            imageUrl: "https://example.com/applepie.jpg",
            duration: 120,
            servings: 8,
            ingredients: [],
            instructions: [],
            isFavorite: true
        ),
        Recipe(
            id: 14,
            author: Author(id: "5678", firstName: "Sarah"),
            name: "Meatballs",
            imageUrl: "https://example.com/meatballs.jpg",
            duration: 45,
            servings: 6,
            ingredients: [],
            instructions: [],
            isFavorite: false
        ),
        Recipe(
            id: 15,
            author: Author(id: "5678", firstName: "Sarah"),
            name: "Chocolate Chip Cookies",
            imageUrl: "https://example.com/cookies.jpg",
            duration: 30,
            servings: 24,
            ingredients: [],
            instructions: [],
            isFavorite: true
        ),
        
        // Marco
        Recipe(
            id: 16,
            author: Author(id: "9012", firstName: "Marco"),
            name: "Osso Buco",
            imageUrl: "https://example.com/ossobuco.jpg",
            duration: 180,
            servings: 4,
            ingredients: [],
            instructions: [],
            isFavorite: true
        ),
        Recipe(
            id: 17,
            author: Author(id: "9012", firstName: "Marco"),
            name: "Pesto alla Genovese",
            imageUrl: "https://example.com/pesto.jpg",
            duration: 15,
            servings: 4,
            ingredients: [],
            instructions: [],
            isFavorite: false
        ),
        Recipe(
            id: 18,
            author: Author(id: "9012", firstName: "Marco"),
            name: "Vitello Tonnato",
            imageUrl: "https://example.com/vitellotonnato.jpg",
            duration: 120,
            servings: 6,
            ingredients: [],
            instructions: [],
            isFavorite: true
        ),
        
        // Maya
        Recipe(
            id: 19,
            author: Author(id: "3456", firstName: "Maya"),
            name: "Vegan Lasagna",
            imageUrl: "https://example.com/veganlasagna.jpg",
            duration: 90,
            servings: 8,
            ingredients: [],
            instructions: [],
            isFavorite: true
        ),
        Recipe(
            id: 20,
            author: Author(id: "3456", firstName: "Maya"),
            name: "Mushroom Risotto",
            imageUrl: "https://example.com/veganrisotto.jpg",
            duration: 45,
            servings: 4,
            ingredients: [],
            instructions: [],
            isFavorite: false
        )
    ]
    
    func fetchRecipesFromCurrentUser() async throws -> [RecipeListItem] {
        
        let filteredRecipes = recipes.filter { recipe in
            recipe.author.id == "1234"
        }
        
        return filteredRecipes.map { recipe in
            RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                isFavorite: recipe.isFavorite
            )
        }
    }
    
    func fetchRecipesLikedByCurrentUser() async throws -> [RecipeListItem] {
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
            
            let filteredRecipes = recipes.filter { recipe in
                recipe.isFavorite == true
            }
            
            return filteredRecipes.map { recipe in
                RecipeListItem(
                    id: recipe.id,
                    name: recipe.name,
                    imageUrl: recipe.imageUrl,
                    duration: recipe.duration,
                    isFavorite: recipe.isFavorite
                )
            }
    }
    
    func fetchRecipeListItems() async throws -> [RecipeListItem] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        return recipes.map { recipe in
            RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                isFavorite: recipe.isFavorite
            )
        }
    }
    
    func fetchRecipesFromUser(id: String) async throws -> [RecipeListItem] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        let filteredRecipes = recipes.filter { recipe in
            recipe.author.id == id
        }
        
        return filteredRecipes.map { recipe in
            RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                isFavorite: recipe.isFavorite
            )
        }
    }
    
    func fetchRecipesLikedByUser(id: String) async throws -> [RecipeListItem] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        let filteredRecipes = recipes.filter { recipe in
            recipe.isFavorite == true
        }
        
        return filteredRecipes.map { recipe in
            RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                isFavorite: recipe.isFavorite
            )
        }
    }
    
    func fetchRecipe(id: Int) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let recipe = recipes.first(where: { $0.id == id }) else {
            throw RecipeError.notFound
        }
        return recipe
    }
    
    func createRecipe(_ recipe: Recipe) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        var newRecipe = recipe
        newRecipe.id = (recipes.map(\.id).max() ?? 0) + 1
        recipes.append(newRecipe)
        return newRecipe
    }
    
    func updateRecipe(_ recipe: Recipe) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else {
            throw RecipeError.notFound
        }
        recipes[index] = recipe
        return recipe
    }
    
    func deleteRecipe(id: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        recipes.removeAll { $0.id == id }
    }
    
    func toggleFavorite(id: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let index = recipes.firstIndex(where: { $0.id == id }) else {
            throw RecipeError.notFound
        }
        recipes[index].isFavorite.toggle()
    }
    
    func addToShoppingList(recipeId: Int, servings: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard recipes.contains(where: { $0.id == recipeId }) else {
            throw RecipeError.notFound
        }
        print("Added recipe \(recipeId) to shopping list with \(servings) servings")
    }
}
