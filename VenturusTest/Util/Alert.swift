//
//  Alert.swift
//  VenturusTest
//
//  Created by Albert Oliveira on 14/03/20.
//  Copyright © 2020 Albert Oliveira. All rights reserved.
//

import UIKit

class Alert {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func show(_ title: String = "Alerta", message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
