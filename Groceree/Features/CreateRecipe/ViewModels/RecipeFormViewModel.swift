//
//  CreateRecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//
import SwiftUI

enum RecipeFormMode {
    case create
    case edit(String) // String is the recipe ID
}

class RecipeFormViewModel: ObservableObject {
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
    private var onActionSuccess: () -> Void
    
    let mode: RecipeFormMode
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(mode: RecipeFormMode,
         recipeRepository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository,
         onActionSuccess: @escaping () -> Void) {
        self.mode = mode
        self.recipeRepository = recipeRepository
        self.onActionSuccess = onActionSuccess
        
        // If we're in edit mode, load the recipe data
        if case .edit(let recipeId) = mode {
            Task {
                await loadRecipe(id: recipeId)
            }
        }
    }
    
    private var nextIngredientId: String {
        UUID().uuidString
    }
    
    private var nextInstructionId: String {
        UUID().uuidString
    }
    
    @MainActor
    private func loadRecipe(id: String) async {
        isLoading = true
        error = nil
        
        do {
            let recipe = try await recipeRepository.fetchRecipe(id: id)
            
            // Update all the published properties
            self.name = recipe.name
            let totalMinutes = recipe.duration
            self.hours = totalMinutes / 60
            self.minutes = totalMinutes % 60
            self.servings = recipe.servings
            self.ingredients = recipe.ingredients
            self.instructions = recipe.instructions
            
            // Note: we don't load the image here as it would require downloading and converting
            // the image URL to UIImage. If you want to implement this, you'll need to add
            // image downloading functionality.
            
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
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
    func saveRecipe() async {
        isLoading = true
        error = nil
        
        do {
            switch mode {
            case .create:
                try await createNewRecipe()
                onActionSuccess()
            case .edit(let recipeId):
                try await updateExistingRecipe(id: recipeId)
                onActionSuccess()
            }
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    private func createNewRecipe() async throws {
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
        
        let createdRecipe = try await recipeRepository.createRecipe(createRecipeDTO)
        
        // If we have an image, upload it
        if let image = selectedImage {
            try await recipeRepository.uploadImage(image, for: createdRecipe.id)
        }
    }
    
    @MainActor
    private func updateExistingRecipe(id: String) async throws {
        let updateRecipeDTO = UpdateRecipeDTO(
            id: id,
            name: name,
            duration: hours * 60 + minutes,
            servings: servings,
            ingredients: ingredients.map { ingredient in
                UpdateIngredientDTO(
                    id: ingredient.id,
                    name: ingredient.name,
                    amount: ingredient.amount,
                    unit: ingredient.unit
                )
            },
            instructions: instructions.map { instruction in
                UpdateInstructionDTO(
                    id: instruction.id,
                    step: instruction.step,
                    instruction: instruction.instruction
                )
            }
        )
        
        let _ = try await recipeRepository.updateRecipe(updateRecipeDTO)
        
        // If we have a new image, upload it
        if let image = selectedImage {
            try await recipeRepository.uploadImage(image, for: id)
        }
    }
}
