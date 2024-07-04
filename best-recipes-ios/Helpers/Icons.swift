//
//  Icons.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

enum Icons {
    static let arrowLeft: UIImage = .arrowLeft
    static let arrowRight: UIImage = .arrowRight
    static let bookmark: UIImage = .bookmarkFill
    static let clock: UIImage = .clock
    static let edit: UIImage = .editStroke
    static let location: UIImage = .locationFill
    static let minus: UIImage = .minusBorder
    static let plus: UIImage = .plusBorder
    static let moreHorizontal: UIImage = .moreHorizontal
    static let moreVertical: UIImage = .moreVertical
    static let play: UIImage = .playFill
    static let close: UIImage = .closeFill
    static let profile: UIImage = .profile
    static let recipe: UIImage = .recipe
    static let search: UIImage = .searchStroke
    static let star: UIImage = .star
    static let checkmark: UIImage = .tickCircle
    static let bookmarkActiveSmall: UIImage = .bookmarkActiveSmall
    static let bookmarkInactiveSmall: UIImage = .bookmarkInactiveSmall
    
    enum Ingredients {
        static let cucumber: UIImage = .cucumber
        static let fish: UIImage = .fish
        static let ginger: UIImage = .ginger
        static let oil: UIImage = .oil
        static let salt: UIImage = .salt
    }
    
    enum TabBar {
        static let bookmarkActive: UIImage = .bookmarkActive
        static let bookmarkInactive: UIImage = .bookmarkInactive
        
        static let homeActive: UIImage = .homeActive
        static let homeInactive: UIImage = .homeInactive
        
        static let notificationActive: UIImage = .notificationActive
        static let notificationInactive: UIImage = .notificationInactive
        
        static let profileActive: UIImage = .profileActive
        static let profileInactive: UIImage = .profileInactive
    }
}
