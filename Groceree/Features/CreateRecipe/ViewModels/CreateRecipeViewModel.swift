//
//  CreateRecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//
import SwiftUI

class CreateRecipeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var hours: Int = 0
    @Published var minutes: Int = 30
    @Published var servings: Int = 2
    @Published var ingredients: [Ingredient] = []
    @Published var instructions: [Instruction] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var selectedImage: UIImage?
    @Published var isImageUploading = false
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository) {
            self.recipeRepository = recipeRepository
        }
    
    private var nextIngredientId: String {
        UUID().uuidString
    }
    
    private var nextInstructionId: String {
        UUID().uuidString
    }
    
    func addEmptyIngredient() {
        let ingredient = Ingredient(
            id: nextIngredientId,
            name: "",
            amount: 0,
            unit: .grams
        )
        ingredients.append(ingredient)
    }
    
    func updateIngredient(id: String, name: String? = nil, amount: Int? = nil, unit: MeasurementUnit? = nil) {
        if let index = ingredients.firstIndex(where: { $0.id == id }) {
            var updatedIngredient = ingredients[index]
            
            if let name = name {
                updatedIngredient.name = name
            }
            if let amount = amount {
                updatedIngredient.amount = amount
            }
            if let unit = unit {
                updatedIngredient.unit = unit
            }
            
            ingredients[index] = updatedIngredient
        }
    }
    
    func removeIngredient(withId id: String) {
        ingredients.removeAll { $0.id == id }
    }
    
    func addEmptyInstruction() {
        let instruction = Instruction(
            id: nextInstructionId,
            step: instructions.count + 1,
            instruction: ""
        )
        instructions.append(instruction)
    }
    
    func removeInstruction(withId id: String) {
        instructions.removeAll { $0.id == id }
        updateInstructionSteps()
    }
    
    private func updateInstructionSteps() {
        for (index, _) in instructions.enumerated() {
            instructions[index].step = index + 1
        }
    }
    
    var isValid: Bool {
        let isNameValid = !name.isEmpty && name.count <= 75
        let isDurationValid = hours > 0 || minutes > 0
        let isServingsValid = servings > 0
        let hasIngredients = !ingredients.isEmpty && ingredients.allSatisfy {
            !$0.name.isEmpty && $0.amount > 0
        }
        let hasInstructions = !instructions.isEmpty && instructions.allSatisfy {
            !$0.instruction.isEmpty
        }
        
        return isNameValid &&
               isDurationValid &&
               isServingsValid &&
               hasIngredients &&
               hasInstructions
    }
    
    @MainActor
    func createRecipe() async {
        isLoading = true
        error = nil
        
        do {
            print("Creating the recipe")
            // First create the recipe
            let createRecipeDTO = CreateRecipeDTO(
                name: name,
                duration: hours * 60 + minutes,
                servings: servings,
                ingredients: ingredients.map { ingredient in
                    CreateIngredientDTO(
                        name: ingredient.name,
                        amount: ingredient.amount,
                        unit: ingredient.unit
                    )
                },
                instructions: instructions.map { instruction in
                    CreateInstructionDTO(
                        step: instruction.step,
                        instruction: instruction.instruction
                    )
                }
            )
            
            print("Trying to create the recipe...")
            let createdRecipe = try await recipeRepository.createRecipe(createRecipeDTO)
            print("Recipe was created!")
            
            print("Trying to upload the image")
            // If we have an image, upload it
            if let image = selectedImage {
                try await recipeRepository.uploadImage(image, for: createdRecipe.id)
            }
            print("Uploaded image!")
            
        } catch {
            print("There was an error creating the recipe:")
            print(error)
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
}
