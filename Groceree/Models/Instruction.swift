//
//  Instruction.swift
//  Groceree
//
//  Created by Bindo Thorpe on 14/12/2024.
//

import Foundation

struct Instruction: Identifiable, Hashable, Decodable {
    let id: String
    var step: Int
    var instruction: String
}
