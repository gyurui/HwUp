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

    private let cards = DataManager.cards

    private var cellSize: CGSize = CGSize()
    private var indexPath: IndexPath = IndexPath(row: 0, section: 0)

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
            width: cardCollectionView.frame.size.width,
            height: cardCollectionView.frame.size.height
        )

        cardCollectionView.reloadData()

        cardsPageControll.hidesForSinglePage = true
        cardsPageControll.numberOfPages = cards.count
        cardsPageControll.isEnabled = false

        setChoosedCardIndex(index: DataManager.choosedCardIndex)
    }

    private func setChoosedCardIndex(index: Int) {
        DataManager.choosedCardIndex = index
        cardsPageControll
            .currentPage = index
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

    @IBAction func prevButtonDidTouch(_ sender: Any) {
        scrollTo(index: DataManager.choosedCardIndex - 1)
    }

    @IBAction func nextButtonDidTouch(_ sender: Any) {
        scrollTo(index: DataManager.choosedCardIndex + 1)
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

        setChoosedCardIndex(index: Int(offSet + horizontalCenter) / Int(width))
    }

}
