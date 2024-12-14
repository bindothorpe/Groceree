//
//  MockDatabase.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

struct MockDatabase {
    static let recipeListItems: [APIRecipeListItem] = [
        APIRecipeListItem(
            id: 1,
            name: "Pasta Carbonara",
            imageUrl: "https://paolos.nl/wp-content/uploads/2018/06/spaghetti-carbonara.png",
            duration: 30
        ),
        APIRecipeListItem(
            id: 2,
            name: "Chicken Curry",
            imageUrl: "https://hips.hearstapps.com/hmg-prod/images/190509-coconut-chicken-curry-157-1558039780.jpg?crop=1xw:0.8435280189423836xh;center,top&resize=1200:*",
            duration: 45
        ),
        APIRecipeListItem(
            id: 3,
            name: "Apple Pie",
            imageUrl: "https://www.kingarthurbaking.com/sites/default/files/styles/featured_image/public/2022-11/Apple-Pie-Classic-Hero_0114-1.jpg?itok=0pKYx5C7",
            duration: 90
        )
    ]
    
    static let recipes: [APIRecipe] = [
        APIRecipe(
            id: 1,
            name: "Pasta Carbonara",
            imageUrl: "https://paolos.nl/wp-content/uploads/2018/06/spaghetti-carbonara.png",
            duration: 30,
            servings: 2,
            isFavorite: false,
            ingredients: [
                APIIngredient(id: 1, name: "Spaghetti", amount: "400g"),
                APIIngredient(id: 2, name: "Eggs", amount: "3"),
                APIIngredient(id: 3, name: "Pecorino Romano", amount: "50g"),
                APIIngredient(id: 4, name: "Pancetta", amount: "150g")
            ],
            instructions: [
                APIInstruction(id: 1, step: 1, instruction: "Cook pasta in salted water"),
                APIInstruction(id: 2, step: 2, instruction: "Fry pancetta until crispy"),
                APIInstruction(id: 3, step: 3, instruction: "Mix eggs with cheese"),
                APIInstruction(id: 4, step: 4, instruction: "Combine everything while pasta is hot")
            ]
        ),
        APIRecipe(
            id: 2,
            name: "Chicken Curry",
            imageUrl: "https://hips.hearstapps.com/hmg-prod/images/190509-coconut-chicken-curry-157-1558039780.jpg?crop=1xw:0.8435280189423836xh;center,top&resize=1200:*",
            duration: 45,
            servings: 2,
            isFavorite: false,
            ingredients: [
                APIIngredient(id: 5, name: "Chicken thighs", amount: "600g"),
                APIIngredient(id: 6, name: "Curry powder", amount: "2 tbsp"),
                APIIngredient(id: 7, name: "Coconut milk", amount: "400ml"),
                APIIngredient(id: 8, name: "Onion", amount: "1 large")
            ],
            instructions: [
                APIInstruction(id: 5, step: 1, instruction: "Dice chicken and onion"),
                APIInstruction(id: 6, step: 2, instruction: "Fry onion until translucent"),
                APIInstruction(id: 7, step: 3, instruction: "Add chicken and curry powder"),
                APIInstruction(id: 8, step: 4, instruction: "Simmer in coconut milk")
            ]
        ),
        APIRecipe(
            id: 3,
            name: "Apple Pie",
            imageUrl: "https://www.kingarthurbaking.com/sites/default/files/styles/featured_image/public/2022-11/Apple-Pie-Classic-Hero_0114-1.jpg?itok=0pKYx5C7",
            duration: 90,
            servings: 2,
            isFavorite: false,
            ingredients: [
                APIIngredient(id: 9, name: "Apples", amount: "1kg"),
                APIIngredient(id: 10, name: "Flour", amount: "300g"),
                APIIngredient(id: 11, name: "Butter", amount: "200g"),
                APIIngredient(id: 12, name: "Sugar", amount: "150g")
            ],
            instructions: [
                APIInstruction(id: 9, step: 1, instruction: "Make pie dough"),
                APIInstruction(id: 10, step: 2, instruction: "Prepare apple filling"),
                APIInstruction(id: 11, step: 3, instruction: "Assemble pie"),
                APIInstruction(id: 12, step: 4, instruction: "Bake at 180°C")
            ]
        )
    ]
}
