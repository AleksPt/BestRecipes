//
//  Toolbar.swift
//  best-recipes-ios
//
//  Created by Алексей on 13.07.2024.
//

import UIKit

class Toolbar: UIToolbar {
    static func setupToolbar(target: Any?, selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: target,
            action: selector
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        return toolbar
    }
}


