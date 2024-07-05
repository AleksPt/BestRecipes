//
//  Images.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

enum Images {
    enum Onboarding {
        static let page0: UIImage = .page0
        static let page1: UIImage = .page1
        static let page2: UIImage = .page2
        static let page3: UIImage = .page3
    }
    
    enum Popular {
        static let popular1: UIImage = .popular1
        static let popular2: UIImage = .popular2
        static let popular3: UIImage = .popular3
        static let popular4: UIImage = .popular4
        static let popular5: UIImage = .popular5
        static let popular6: UIImage = .popular6
    }
    
    enum Recent {
        static let recent1: UIImage = .recent1
        static let recent2: UIImage = .recent2
        static let recent3: UIImage = .recent3
        static let recent4: UIImage = .recent4
        static let recent5: UIImage = .recent5
        static let recent6: UIImage = .recent6
    }
    
    enum Trending {
        static let tranding1: UIImage = .trending1
        static let tranding2: UIImage = .trending2
        static let tranding3: UIImage = .trending3
        static let tranding4: UIImage = .trending4
    }
    
    enum Cuisine {
        static let african: UIImage = .african
        static let asian: UIImage = .asian
        static let american: UIImage = .american
        static let british: UIImage = .british
        static let cajun: UIImage = .cajun
        static let caribbean: UIImage = .caribbean
        static let chinese: UIImage = .chinese
        static let easternEuropean: UIImage = .easternEuropean
        static let european: UIImage = .european
        static let french: UIImage = .french
        static let german: UIImage = .german
        static let greek: UIImage = .greek
        static let indian: UIImage = .indian
        static let irish: UIImage = .irish
        static let italian: UIImage = .italian
        static let japanese: UIImage = .japanese
        static let jewish: UIImage = .jewish
        static let korean: UIImage = .korean
        static let latinAmerican: UIImage = .latinAmerican
        static let mediterranean: UIImage = .mediterranean
        static let mexican: UIImage = .mexican
        static let middleEastern: UIImage = .middleEastern
        static let nordic: UIImage = .nordic
        static let southern: UIImage = .southern
        static let spanish: UIImage = .spanish
        static let thai: UIImage = .thai
        static let vietnamese: UIImage = .vietnamese
    }
    
    enum Avatars {
        static let avatar1: UIImage = .author1
        static let avatar2: UIImage = .author2
        static let avatar3: UIImage = .author3
        static let avatar4: UIImage = .author4
        static let avatar5: UIImage = .author5
        static let avatar6: UIImage = .author6
        
        static func getAvatar() -> [String: UIImage?] {
            [
            "Megan Fox":avatar1,
            "Scarlett Johansson":avatar2,
            "Cameron Diaz":avatar3,
            "Natalie Portman":avatar4,
            "Charlize Theron":avatar5,
            "Julia Roberts":avatar6
            ]
        }
    }
}
