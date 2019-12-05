//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

struct Article {
    let image: String
    let category: Category
    let title: String
    let author: String
    let relativeTime: String
    let isFavorite: Bool
    
    static func getArticles() -> [Article] {
       return [
        Article(image: "", category: Category(name: "Tecnologia", color: Colors.categoriesTechnology),
                title: "Larry Page deixa posto de presidente-executivo da Alphabet, dona do Google",
                author: "Henrique Silveira", relativeTime: "30 min atrás", isFavorite: true),
        Article(image: "", category: Category(name: "Esportes", color: Colors.categoriesSports),
                        title: "Manchester City goleia Burnley por 4 a 1 e assume vice-liderança temporária do Campeonato Inglês",
                        author: "Marcos Paulo", relativeTime: "2 horas atrás", isFavorite: false)
        ]
    }
}
