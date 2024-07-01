//
//  Fonts.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

extension UIFont {
    enum Poppins {
        static let bold = "Poppins-Bold"
        static let regular = "Poppins-Regular"
        static let semibold = "Poppins-SemiBold"
        static let medium = "Poppins-Medium"
    }
    
    enum Inter {
        static let medium = "Inter-Medium"
    }
    
    enum PoppinsFont {
        static func bold(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: Poppins.bold, size: size) else {
                print("шрифт \(Poppins.bold) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
        
        static func regular(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: Poppins.regular, size: size) else {
                print("шрифт \(Poppins.regular) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
        
        static func semibold(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: Poppins.semibold, size: size) else {
                print("шрифт \(Poppins.semibold) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
        
        static func medium(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: Poppins.medium, size: size) else {
                print("шрифт \(Poppins.medium) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
    }
    
    enum InterFont {
        static func medium(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: Inter.medium, size: size) else {
                print("шрифт \(Inter.medium) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
    }
    
    enum TextFonts {
        enum NavigationBar {
            static let title = PoppinsFont.semibold(size: 24)
        }
        
        enum Onboarding {
            enum StartPage {
                static let title = PoppinsFont.semibold(size: 56)
                static let subtitleRegular = PoppinsFont.regular(size: 16)
                static let subtitleSemibold = PoppinsFont.semibold(size: 16)
                static let button = PoppinsFont.semibold(size: 16)
            }
            
            static let title = PoppinsFont.semibold(size: 40)
            static let button = PoppinsFont.medium(size: 20)
            static let skip = InterFont.medium(size: 10)
        }
        
        enum Home {
            static let titleSection = PoppinsFont.semibold(size: 20)
            static let buttonSeeAll = PoppinsFont.semibold(size: 14)
            
            enum Trending {
                static let rating = PoppinsFont.semibold(size: 14)
                static let titleTrendingCell = PoppinsFont.semibold(size: 16)
                static let nameAuthor = PoppinsFont.regular(size: 12)
            }
            
            enum PopularCategory {
                static let nameCategory = PoppinsFont.semibold(size: 12)
                static let titleCell = PoppinsFont.semibold(size: 14)
                static let timeSubtitle = PoppinsFont.regular(size: 12)
                static let timeTitle = PoppinsFont.semibold(size: 12)
            }
            
            enum RecentRecipe {
                static let titleCell = PoppinsFont.semibold(size: 14)
                static let subtitle = PoppinsFont.regular(size: 10)
            }
            
            enum Kitchens {
                static let title = PoppinsFont.semibold(size: 12)
            }
            
        }
        
        enum Search {
            static let rating = PoppinsFont.semibold(size: 14)
            static let textfield = PoppinsFont.regular(size: 14)
            static let titleCell = PoppinsFont.semibold(size: 16)
            static let subtitleCell = PoppinsFont.regular(size: 12)
        }
        
        enum Discover {
            static let rating = PoppinsFont.semibold(size: 14)
            static let titleCell = PoppinsFont.semibold(size: 16)
            static let nameAuthor = PoppinsFont.regular(size: 12)
            static let timeLabel = PoppinsFont.regular(size: 12)
        }
        
        enum RecipeDetail {
            static let rating = PoppinsFont.semibold(size: 14)
            static let countReviews = PoppinsFont.regular(size: 14)
            
            static let instructionTitle = PoppinsFont.semibold(size: 20)
            static let instructionText = PoppinsFont.regular(size: 16)
            
            static let ingredientsTitle = PoppinsFont.semibold(size: 20)
            static let countIngredients = PoppinsFont.regular(size: 14)
            static let cellIngredientsTitle = PoppinsFont.semibold(size: 16)
            static let cellIngredientsSubtitle = PoppinsFont.regular(size: 14)
        }
        
        enum SeeAll {
            static let rating = PoppinsFont.semibold(size: 14)
            static let titleCell = PoppinsFont.semibold(size: 16)
            static let nameAuthor = PoppinsFont.regular(size: 12)
            static let timeLabel = PoppinsFont.regular(size: 12)
        }
        
        enum CreateRecipe {
            static let nameRecipeField = PoppinsFont.regular(size: 14)
            static let parametersTitle = PoppinsFont.semibold(size: 16)
            static let parametersSubtitle = PoppinsFont.regular(size: 14)
            static let ingredientsTitle = PoppinsFont.semibold(size: 20)
            static let ingredientsField = PoppinsFont.regular(size: 14)
            static let button = PoppinsFont.semibold(size: 16)
        }
    }
}
