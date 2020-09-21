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

        self.session.request(.getCards).done { [weak self] (cards: [Card]) in
            print("TEST - Posts: \(cards)")
            DataManager.cards = cards
            DataManager.choosedCardIndex = 0

            self?.presentTabBarController()
        }
        .catch { error in
            print("TEST - Error: \(error)")
        }
        .finally {
            print("TEST - Request is complete 🎉")
        }
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
