//
//  UpdateInstructionDTO.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct UpdateInstructionDTO: Encodable {
    let id: String
    let step: Int
    let instruction: String
}
