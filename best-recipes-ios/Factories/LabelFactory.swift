

import UIKit

final class LabelFactory {
    
    //MARK: - Onboarding Screen
    
    //Best Recipe
    static func makeOnboardingScreenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        paragraphStyle.alignment = .center
        
        let attributedText = NSAttributedString(string: text,
                                                attributes: [
                                                    .font: UIFont.TextFonts.Onboarding.StartPage.title,
                                                    .foregroundColor: UIColor.white,
                                                    .paragraphStyle: paragraphStyle
                                                ])
        label.attributedText = attributedText
        return label
    }
    
    //Recipes from all over the World
    //Recipes with each and every detail
    //Cook it now or save it for later
    static func makeOnboardingPageLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.TextFonts.Onboarding.title
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
        
    // Premium recipes
    // Find best recipes for cooking
    static func makeOnboardingSmallLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.TextFonts.Onboarding.StartPage.subtitleRegular
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // 100+
    static func makeOnboardingSmallBoldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.TextFonts.Onboarding.StartPage.subtitleSemibold
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    //Get amazing recipes for cooking
    //Saved recipes
    //How to make Tasty Fish (point & Kill)
    static func makeScreenTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.Home.title
        label.numberOfLines = 0
        label.font = UIFont.TextFonts.NavigationBar.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Trending Now Screen
    
    static func makeTrendScreenTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Colors.Neutral.neutral100
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.TextFonts.NavigationBar.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // How to make yam & vegatable sauce at home
    static func makeTrendScreenRecipeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.SeeAll.titleCell
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // 9 ingredients / 25 min
    static func maketTrendScreenValueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.SeeAll.timeLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Home Screen
    
    // Home screen
    // Trending now / Popular Category / Recent Recipe / Popular Creators
    static func makeCollectionHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.Colors.Neutral.neutral100
        label.font = UIFont.TextFonts.Home.titleSection
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Trending now Section & Saved recipes Screen
    
    //How to sharwama at home (Home Screen & Saved Screen)
    //Fish(Detail Screen)
    static func makeRecipeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.Colors.Neutral.neutral100
        label.font = UIFont.TextFonts.Home.Trending.titleTrendingCell
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // By Zeelicious foods (Home Screen & Saved Screen)
    static func makeCreatorNameLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Colors.Neutral.neutral50
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.Home.Trending.nameAuthor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Popular Category Section
    
    // Salad / Breakfast
    static func makeCategoryRecipeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.TextFonts.Home.PopularCategory.nameCategory
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // Chicken and Vegatable wrap
    static func makePopularRecipeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Colors.Neutral.neutral100
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.TextFonts.Home.PopularCategory.titleCell
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //Time
    static func makeTimeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Colors.Neutral.neutral30
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.Home.PopularCategory.timeSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // 5 Mins
    static func makeMinutesLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.Colors.Neutral.neutral100
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.Home.PopularCategory.timeTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Recent Recipe Section
    
    // Kelewele Ghanian Recipe
    static func makeRecentRecipeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor =  UIColor.Colors.Neutral.neutral100
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.Home.RecentRecipe.titleCell
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // By Zeelicious Foods
    static func makeRecentRecipeCreatorLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor =  UIColor.Colors.Neutral.neutral50
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.TextFonts.Home.RecentRecipe.subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //Ify's Kitchen
    static func makePopularCreatorNameLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor =  UIColor.Colors.Neutral.neutral100
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.TextFonts.Home.Kitchens.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //MARK: - Detail Screen
    
    // Reviews Label, Items label
    static func createReviewsLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor =  UIColor.Colors.Neutral.neutral50
        label.font = UIFont.TextFonts.RecipeDetail.countReviews
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    // Instructions, Ingredients Label
    static func createInstructionsLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor =  UIColor.Colors.Neutral.neutral100
        label.font = UIFont.TextFonts.RecipeDetail.instructionTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    //gr
    static func makeValueLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor =  UIColor.Colors.Neutral.neutral50
        label.font = UIFont.TextFonts.RecipeDetail.countIngredients
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
}

