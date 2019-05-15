//
//  UIViewController+Extension.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import UIKit

// MARK: - UIViewController extension functions

extension UIViewController {
    func add(_ childViewController: UIViewController) {
        addChild(childViewController)
        childViewController.didMove(toParent: self)
    }

    func remove(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.removeFromParent()
    }
    
    /// A function to conveniently show an "Oops!" alert on a `UIViewController` instance.
    ///
    /// - Parameter message: The message the alert will display.
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .default)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
