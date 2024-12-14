//
//  Instruction+Mapping.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

extension Instruction {
    static func from(apiModel: APIInstruction) -> Instruction {
        Instruction(
            id: apiModel.id,
            step: apiModel.step,
            instruction: apiModel.instruction
        )
    }
}
