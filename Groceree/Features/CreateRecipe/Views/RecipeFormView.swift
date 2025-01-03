//
//  CreateRecipeView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct RecipeFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: RecipeFormViewModel
    
    init(mode: RecipeFormMode, onActionSuccess: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: RecipeFormViewModel(mode: mode, onActionSuccess: onActionSuccess))
    }
    
    var title: String {
        switch viewModel.mode {
        case .create:
            return "Nieuw recept"
        case .edit:
            return "Wijzig recept"
        }
    }
    
    var buttonTitle: String {
        switch viewModel.mode {
        case .create:
            return "Maak recept"
        case .edit:
            return "Wijzig recept"
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    GeneralSectionView(
                        name: $viewModel.name,
                        hours: $viewModel.hours,
                        minutes: $viewModel.minutes,
                        servings: $viewModel.servings,
                        selectedImage: $viewModel.selectedImage
                    )
                    
                    IngredientsSectionView(
                        ingredients: $viewModel.ingredients,
                        onDelete: { viewModel.removeIngredient(withId: $0) },
                        onAdd: viewModel.addEmptyIngredient
                    )
                    
                    InstructionsSectionView(
                        instructions: $viewModel.instructions,
                        onDelete: { viewModel.removeInstruction(withId: $0) },
                        onAdd: viewModel.addEmptyInstruction
                    )
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Annuleer") {
                            dismiss()
                        }
                        .foregroundColor(Theme.primary)
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        ActionButton(isValid: viewModel.isValid, isLoading: viewModel.isLoading) {
                            Task {
                                await viewModel.saveRecipe()
                            }
                        } label: {
                            Text(buttonTitle)
                        }
                    }
                }
            }
            .disabled(viewModel.isLoading)
            .interactiveDismissDisabled(viewModel.isLoading)
        
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
    }
}
