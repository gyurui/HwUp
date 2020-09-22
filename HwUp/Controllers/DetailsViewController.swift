//
//  DetailsViewController.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var detailsHorizontalBar: DetailsHorizontalBar!

    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var balanceCarriedLabel: UILabel!
    @IBOutlet weak var totalSpendingSinceLabel: UILabel!
    @IBOutlet weak var lastRepaymentLabel: UILabel!
    @IBOutlet weak var accountLimitLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet var currencyCollection: [UILabel]!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var accountHolderLabel: UILabel!

    private let cards = DataManager.cards

    override func viewDidLoad() {
        super.viewDidLoad()

        headerTitle.font = UIFont(name: "Roboto-Medium", size: 20.24)
    }

    override func viewWillAppear(_ animated: Bool) {
        let card = cards[DataManager.choosedCardIndex]
        let allBalance = (card.availableBalance + card.currentBalance)
        detailsHorizontalBar.progress = CGFloat(card.availableBalance / allBalance)
        detailsHorizontalBar.pendingProgress = CGFloat(card.reservations / allBalance)

        currentBalanceLabel.text = card.currentBalance.formatFloatToString()
        availableBalanceLabel.text = card.availableBalance.formatFloatToString()
        reservationLabel.text = card.reservations.formatFloatToString()
        balanceCarriedLabel.text = card.balanceCarriedOverFromLastStatement.formatFloatToString()
        totalSpendingSinceLabel.text = card.spendingsSinceLastStatement.formatFloatToString()
        lastRepaymentLabel.text = card.yourLastRepayment.formatDate()
        accountLimitLabel.text = card.accountDetails.accountLimit.formatFloatToString()
        accountNumberLabel.text = "\(card.accountDetails.accountNumber)"
        currencyCollection.forEach { label in
            label.text = card.currency
        }
        cardNumberLabel.text = "****-****-****-\(String(card.cardNumber.suffix(4)))"
        accountHolderLabel.text = "\(card.cardHolderName)"
    }

    @IBAction func detailsButtonDidTouch(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }

}
