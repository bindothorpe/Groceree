//
//  GrocereeAPIProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import Foundation

protocol GrocereeAPIProtocol {
    // Recipe Endpoints
    func fetchRecipesList() async throws -> APIResponse<[APIRecipeListItem]>
    func fetchRecipe(id: Int) async throws -> APIResponse<APIRecipe>
    func createRecipe(_ recipe: CreateRecipeRequest) async throws -> APIResponse<Int>
    
}
