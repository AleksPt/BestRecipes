//
//  OnboardingData.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 05.07.2024.
//

import UIKit

struct OnboardingPageData {
    let backgroundImage: UIImage
    let showSkip: Bool
    let buttonText: String
    let pageText: NSMutableAttributedString
}

final class OnboardingData {
    static private func makeAttributedString(fullString: String, highlightedSubstring: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullString)
        
        let range = (fullString as NSString).range(of: highlightedSubstring)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.Colors.Secondary.secondary, range: range)
        
        return attributedString
    }
    
    static func getPages() -> [OnboardingPageData] {
        return [
            OnboardingPageData(
                backgroundImage: Images.Onboarding.page1,
                showSkip: true,
                buttonText: "Continue",
                pageText: makeAttributedString(
                    fullString: "Recipes from all over the\nWorld",
                    highlightedSubstring: "over the\nWorld"
                )
            ),
            OnboardingPageData(
                backgroundImage: Images.Onboarding.page2,
                showSkip: true,
                buttonText: "Continue",
                pageText: makeAttributedString(
                    fullString: "Recipes with each and every detail",
                    highlightedSubstring: "each and every detail"
                )
            ),
            OnboardingPageData(
                backgroundImage: Images.Onboarding.page3,
                showSkip: false,
                buttonText: "Start Cooking",
                pageText: makeAttributedString(
                    fullString: "Cook it now or save it for later",
                    highlightedSubstring: "save it for later"
                )
            )
        ]
    }
}
