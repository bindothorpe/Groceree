//
//  Instruction.swift
//  Groceree
//
//  Created by Bindo Thorpe on 14/12/2024.
//

import Foundation

struct Instruction: Identifiable, Hashable {
    let id: Int
    var step: Int
    var instruction: String
}
