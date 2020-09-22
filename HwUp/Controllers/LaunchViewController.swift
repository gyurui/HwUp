//
//  LaunchViewController.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Alamofire
import PromiseKit
import UIKit

class LaunchViewController: UIViewController {

    private let session = Session()

    override func viewDidLoad() {
        super.viewDidLoad()

        URLCache.shared.removeAllCachedResponses()

        self.session.request(.getCards).done { [weak self] (cards: [Card]) in
            DataManager.cards = cards
            DataManager.choosedCardIndex = 0

            self?.presentTabBarController()
        }
        .catch { error in
            print("TEST - Error: \(error)")
            switch error {
            case MyError.badAPIRequest: self.showError(withMessage: "Bad API request happened,")
            case MyError.unauthorized: self.showError(withMessage: "Unathorized connection")
            case MyError.noInternet:
                self.showError(
                    withMessage: "There is no internet conection. Please try Again Later"
                )
            default: self.showError(withMessage: "Unknown error")
            }
        }
        .finally {
            print("TEST - Request is complete 🎉")
        }
    }

    private func showError(withMessage: String) {
        let alert = UIAlertController(
            title: "Error happened",
            message: withMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    private func presentTabBarController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController =
            storyBoard.instantiateViewController(withIdentifier: "tabBarController")
            as! UITabBarController
        tabBarController.modalPresentationStyle = .fullScreen

        self.present(tabBarController, animated: true, completion: nil)
    }

}
