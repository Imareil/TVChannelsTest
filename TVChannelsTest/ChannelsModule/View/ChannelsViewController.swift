// ChannelsViewController.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class ChannelsViewController: UIViewController {
    // MARK: - UI Components

    private let scrollView = UIScrollView()
    private lazy var collectionView = UICollectionView()

    // MARK: - Public Properties

    var presenter: ChannelsViewPresenterProtocol?

    // MARK: - Viewcontroller (ChannelsViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV Program"

        runMethods()
    }

    // MARK: - Viewcontroller (ChannelsViewController)

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }

    // MARK: Private Methods

    private func runMethods() {
        configureScrollView()

        configureCollectionView()
        presenter?.getChannels(view: self)
    }

    private func registerCells() {
        collectionView.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: CellIdentifiers.ItemCell
        )
        collectionView.register(
            TimeCollectionViewCell.self,
            forCellWithReuseIdentifier: CellIdentifiers.TimeCell
        )
        collectionView.register(
            ChannelCollectionViewCell.self,
            forCellWithReuseIdentifier: CellIdentifiers.ChannelCell
        )
    }

    private func configureScrollView() {
        scrollView.backgroundColor = .lightGray
        scrollView.alwaysBounceHorizontal = true
        view.addSubview(scrollView)
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(
            frame: scrollView.bounds,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .lightGray

        registerCells()

        scrollView.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setScrollViewContentSize(width: Int, height: Int) {
        scrollView.contentSize = CGSize(width: width, height: height)
    }

    private func setCollectionViewSize(width: Int, height: Int) {
        collectionView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

    private func configureTimeText(position: Int) -> String {
        let hours = Array(1 ... 23)
        var positions: [String] = []
        for index in hours {
            positions.append("\(index):00")
            positions.append("\(index):30")
        }
        return positions[position]
    }
}

// MARK: - Extensions

extension ChannelsViewController: ChannelsViewProtocol {
    func updateData() {
        DispatchQueue.main.async {
            let count = (self.presenter?.channels?.count ?? 0) + 1
            let height = count * Constants.itemHeight
            let width = 47 * Constants.itemWidth
            self.setScrollViewContentSize(width: width, height: height)
            self.setCollectionViewSize(width: width, height: height)
            self.collectionView.reloadData()
        }
    }
}

extension ChannelsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0), (_, 0), (0, _):
            break
        case let (section, row):
            presenter?.showDetails(channelNumber: section - 1, itemNumber: row - 1)
        }
    }
}

extension ChannelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch (indexPath.section, indexPath.row) {
        case (0, 0), (_, 0), (0, _):
            return CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        case let (section, row):
            guard let width = presenter?.programItems?[section - 1][row - 1].length
            else { return CGSize(width: 0, height: 0) }
            return CGSize(width: width * 4, height: Constants.itemHeight)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0.0
    }
}

extension ChannelsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = presenter?.channels?.count else { return 0 }
        return count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.numberOfTimeItems
        case let section:
            guard let count = presenter?.programItems?[section - 1].count else { return 0 }
            return count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.TimeCell,
                for: indexPath
            ) as? TimeCollectionViewCell else { return UICollectionViewCell() }

            cell.configureCell(time: "Today,\n\(Constants.currentDate)")

            return cell

        case let (0, row):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.TimeCell,
                for: indexPath
            ) as? TimeCollectionViewCell else { return UICollectionViewCell() }

            cell.configureCell(time: configureTimeText(position: row - 1))

            return cell

        case let (section, 0):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.ChannelCell,
                for: indexPath
            ) as? ChannelCollectionViewCell else { return UICollectionViewCell() }

            cell.configureCell(
                index: indexPath.section,
                channelName: presenter?.channels?[section - 1].callSign
            )
            return cell

        case let (section, row):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.ItemCell,
                for: indexPath
            ) as? ItemCollectionViewCell else { return UICollectionViewCell() }
            guard let name = presenter?.programItems?[section - 1][row - 1].name
            else { return UICollectionViewCell() }

            cell.configureCell(itemName: name)

            return cell
        }
    }
}
