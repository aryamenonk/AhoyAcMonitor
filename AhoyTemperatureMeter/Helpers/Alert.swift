//
//  Alert.swift
//  AhoyTemperatureMeter
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> ()

class AlertController {

    static func show(error: Error? = nil) {
        let alertController = UIAlertController(title: "Sorry", message: error?.localizedDescription ?? "Sorry an error occurred.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            topMostViewController().present(alertController, animated: true, completion: nil)
        }
    }
    
    class func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
}
