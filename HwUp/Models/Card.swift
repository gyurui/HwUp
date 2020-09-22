//
//  Cards.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

public struct Card {

    // MARK: - Properties
    public let cardId: String
    public let issuer: String
    public let cardNumber: String
    public let expirationDate: String
    public let cardHolderName: String
    public let friendlyName: String
    public let currency: String
    public let cvv: String
    public let availableBalance: Float
    public let currentBalance: Float
    public let minPayment: Float
    public let dueDate: String
    public let reservations: Float
    public let balanceCarriedOverFromLastStatement: Float
    public let spendingsSinceLastStatement: Float
    public let accountDetails: AccountDetails
    public let yourLastRepayment: String
    public let status: String
    public let cardImage: String

}

// MARK: - Codable
extension Card: Codable {
    enum CodingKeys: String, CodingKey {
        case cardId = "cardId"
        case issuer = "issuer"
        case cardNumber = "cardNumber"
        case expirationDate = "expirationDate"
        case cardHolderName = "cardHolderName"
        case friendlyName = "friendlyName"
        case currency = "currency"
        case cvv = "cvv"
        case availableBalance = "availableBalance"
        case currentBalance = "currentBalance"
        case minPayment = "minPayment"
        case dueDate = "dueDate"
        case reservations = "reservations"
        case balanceCarriedOverFromLastStatement = "balanceCarriedOverFromLastStatement"
        case spendingsSinceLastStatement = "spendingsSinceLastStatement"
        case accountDetails = "accountDetails"
        case yourLastRepayment = "yourLastRepayment"
        case status = "status"
        case cardImage = "cardImage"
    }
}
