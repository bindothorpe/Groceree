//
//  NavigationViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .recipes
}
