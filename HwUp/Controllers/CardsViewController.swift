import Alamofire
import PromiseKit
//
//  ViewController.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 18..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//
import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cardsPageControll: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!

    @IBOutlet weak var availableProgressBar: AvailableHorizontalProgressBar!

    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var availableMoneyLabel: UILabel!

    @IBOutlet weak var informationTableView: UITableView!

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    @IBOutlet weak var detailsButton: UIButton!

    private let cards = DataManager.cards
    private var cellSize: CGSize = CGSize()
    private var items: [CardDetailsItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        headerTitleLabel.font = UIFont(name: "Roboto-Medium", size: 20.24)

        let buttonImage = UIImage.init(named: "arrow")

        prevButton.tintColor = UIColor.appColor(.secondaryBlue)
        prevButton.setImage(buttonImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        prevButton.imageView?.contentMode = .scaleAspectFit

        nextButton.tintColor = UIColor.appColor(.secondaryBlue)
        nextButton.setImage(
            buttonImage?.rotate(radians: .pi).withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        nextButton.imageView?.contentMode = .scaleAspectFit

        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self

        cellSize = CGSize.init(
            width: self.view.frame.size.width,
            height: self.cardCollectionView.frame.size.height
        )

        cardCollectionView.reloadData()
        cardCollectionView.setNeedsLayout()

        cardsPageControll.hidesForSinglePage = true
        cardsPageControll.numberOfPages = cards.count
        cardsPageControll.isEnabled = false

        alertImageView.image = UIImage.init(named: "alert")?.withTintColor(
            UIColor.appColor(.errorRed)!
        )

        informationTableView.register(
            UINib(nibName: "InformationCell", bundle: nil),
            forCellReuseIdentifier: "InformationCell"
        )
        informationTableView.delegate = self
        informationTableView.dataSource = self

        detailsButton.layer.borderColor = UIColor.appColor(.secondaryBlue)?.cgColor
        detailsButton.layer.borderWidth = 1
        detailsButton.layer.cornerRadius = 4

        reloadPage()
    }

    private func reloadPage() {
        let index = DataManager.choosedCardIndex

        cardsPageControll
            .currentPage = index

        headerTitleLabel.text = cards[index].friendlyName

        prevButton.isHidden = index == 0
        nextButton.isHidden = index == cards.count - 1

        availableMoneyLabel.text = cards[index].availableBalance.formatFloatToString()
        availableProgressBar.progress = CGFloat(
            cards[index].availableBalance
                / (cards[index].currentBalance + cards[index].availableBalance)
        )

        alertImageView.isHidden = cards[index].availableBalance > 0.0
        availableMoneyLabel.textColor =
            cards[index].availableBalance > 0.0
            ? UIColor.appColor(.statusBlue) : UIColor.appColor(.errorRed)

        let cellHeight = 48

        items = generateCardDetailItems()

        tableViewHeight.constant = CGFloat(items.count * cellHeight)

        informationTableView.reloadData()
    }

    private func scrollTo(index: Int) {
        if index > -1 && index < cards.count && DataManager.choosedCardIndex != index {
            self.cardCollectionView.scrollToItem(
                at: IndexPath.init(row: index, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
        }
    }

    func generateCardDetailItems() -> [CardDetailsItem] {
        let card = cards[DataManager.choosedCardIndex]
        let currentBalance = CardDetailsItem(
            labelName: "Current balance",
            isShowCurrency: true,
            value: card.currentBalance.formatFloatToString()
        )
        let minPayment = CardDetailsItem(
            labelName: "Min. payment",
            isShowCurrency: true,
            value: card.minPayment.formatFloatToString()
        )
        let dueDate = CardDetailsItem(
            labelName: "Due date",
            isShowCurrency: false,
            value: card.dueDate.formatDate()
        )
        return [currentBalance, minPayment, dueDate]
    }

    @IBAction func prevButtonDidTouch(_ sender: Any) {
        scrollTo(index: DataManager.choosedCardIndex - 1)
    }

    @IBAction func nextButtonDidTouch(_ sender: Any) {
        scrollTo(index: DataManager.choosedCardIndex + 1)
    }

    @IBAction func detailsButtonDidTouch(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }

}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int
    {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cardCell",
            for: indexPath
        ) as? CardCollectionViewCell {
            cell.setUp(card: cards[indexPath.row])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return cellSize
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        let newIndex = Int(offSet + horizontalCenter) / Int(width)
        if newIndex != DataManager.choosedCardIndex {
            DataManager.choosedCardIndex = newIndex
            reloadPage()
        }
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath)
            as! InformationCell

        cell.nameLabel.text = items[indexPath.row].labelName
        cell.currencyLabel.text = cards[DataManager.choosedCardIndex].currency
        cell.currencyLabel.isHidden = !items[indexPath.row].isShowCurrency
        cell.valueLabel.text = items[indexPath.row].value

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
