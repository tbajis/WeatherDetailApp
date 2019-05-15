//
//  LoadingSpinnerViewController.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import UIKit

/// A View used to show a loading indicator.
class LoadingSpinnerViewController: UIViewController {

    // MARK: - Properties

    let spinner = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .gray
        view.alpha = 0.9
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
