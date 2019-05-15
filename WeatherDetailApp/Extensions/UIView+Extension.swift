//
//  UIView+Extension.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import UIKit

// MARK: - UIView extension functions

extension UIView {
    
    /// A function to add a subview full screen.
    ///
    /// - Parameter subview: The subview to fill completely with.
    func fillSubviewCompletely(_ subview: UIView) {
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
