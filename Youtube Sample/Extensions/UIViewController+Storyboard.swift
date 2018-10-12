//
//  UIViewController+Storyboard.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func storyboardInstance() -> Self? {
        return instantiateFromStoryboard()
    }
    
    private static func instantiateFromStoryboard<T>() -> T? {
        let storyboard = UIStoryboard(name: String(describing: T.self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }
    
}
