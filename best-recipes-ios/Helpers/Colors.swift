//
//  Colors.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

extension UIColor {
    enum Colors {
        enum Error {
            static let error10: UIColor = .error10
            static let error100: UIColor = .error100
        }
        
        enum Success {
            static let success10: UIColor = .success10
            static let success100: UIColor = .success100
        }
        
        enum Rating {
            static let rating100: UIColor = .rating100
        }
        
        enum Neutral {
            static let neutral0: UIColor = .neutral0
            static let neutral10: UIColor = .neutral10
            static let neutral20: UIColor = .neutral20
            static let neutral30: UIColor = .neutral30
            static let neutral40: UIColor = .neutral40
            static let neutral50: UIColor = .neutral50
            static let neutral60: UIColor = .neutral60
            static let neutral70: UIColor = .neutral70
            static let neutral80: UIColor = .neutral80
            static let neutral90: UIColor = .neutral90
            static let neutral100: UIColor = .neutral100
        }
        
        enum Primary {
            static let primary: UIColor = .primary300
            static let primary0: UIColor = .primary0
            static let primary10: UIColor = .primary10
            static let primary20: UIColor = .primary20
            static let primary30: UIColor = .primary30
            static let primary40: UIColor = .primary40
            static let primary50: UIColor = .primary50
            static let primary60: UIColor = .primary60
            static let primary70: UIColor = .primary70
            static let primary80: UIColor = .primary80
            static let primary90: UIColor = .primary90
            static let primary100: UIColor = .primary100
            static let primary200: UIColor = .primary200
        }
        
        enum Secondary {
            static let secondary: UIColor = .secondary200
            static let secondary0: UIColor = .secondary0
            static let secondary10: UIColor = .secondary10
            static let secondary20: UIColor = .secondary20
            static let secondary30: UIColor = .secondary30
            static let secondary40: UIColor = .secondary40
            static let secondary50: UIColor = .secondary50
            static let secondary60: UIColor = .secondary60
            static let secondary70: UIColor = .secondary70
            static let secondary80: UIColor = .secondary80
            static let secondary90: UIColor = .secondary90
            static let secondary100: UIColor = .secondary100
        }
    }
    
    enum NavigationBar {
        static let title = Colors.Neutral.neutral100
    }
    
    enum GlobalBackground {
        static let light = Colors.Neutral.neutral0
    }
    
    enum Onboarding {
        static let title = Colors.Neutral.neutral0
        static let titleSecondary = Colors.Secondary.secondary
        static let subtitle = Colors.Neutral.neutral0
        static let buttonTitle = Colors.Neutral.neutral0
        static let buttonBackground = Colors.Primary.primary50
    }
    
    enum Home {
        static let title = Colors.Neutral.neutral100
        static let buttonSeeAll = Colors.Primary.primary50
        static let authorName = Colors.Neutral.neutral50
        
        enum PopularCategory {
            static let viewBackground = Colors.Neutral.neutral10
            static let timeLabel = Colors.Neutral.neutral30
            static let cellSelectedTitle = Colors.Neutral.neutral0
            static let cellSelectedBackground = Colors.Primary.primary50
            static let cellUnselectedTitle = Colors.Primary.primary
            static let cellUnselectedBackground = Colors.Neutral.neutral0
        }
    }
    
    enum Search {
        static let placeholderField = Colors.Neutral.neutral30
        static let borderField = Colors.Neutral.neutral20
        static let borderSelectedField = Colors.Primary.primary50
        static let textField = Colors.Neutral.neutral100
        
        static let rating = Colors.Neutral.neutral0
        static let titleCell = Colors.Neutral.neutral0
        static let subtitleCell = Colors.Neutral.neutral0
    }
    
    enum Discover {
        static let rating = Colors.Neutral.neutral0
        static let time = Colors.Neutral.neutral0
        static let titleCell = Colors.Neutral.neutral100
        static let authorName = Colors.Neutral.neutral50
    }
    
    enum RecipeDetail {
        static let title = Colors.Neutral.neutral100
        static let subtitle = Colors.Neutral.neutral50
        static let rating = Colors.Neutral.neutral100
        static let text = Colors.Neutral.neutral50
        static let warningText = Colors.Primary.primary200
        static let cellIngredientsBackground = Colors.Neutral.neutral0
    }
    
    enum CreateRecipe {
        static let unselectedBorderField = Colors.Neutral.neutral20
        static let selectedBorderField = Colors.Primary.primary50
        static let placeholderField = Colors.Neutral.neutral30
        
        static let title = Colors.Neutral.neutral100
        static let subtitle = Colors.Neutral.neutral50
        static let text = Colors.Neutral.neutral100
        
        static let buttonBackground = Colors.Primary.primary50
        static let buttonTitle = Colors.Neutral.neutral0
    }
}
