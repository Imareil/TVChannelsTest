// ChannelsView + Extensions.swift
// Copyright © Dmi3. All rights reserved.

//
//  ChannelsView + Extensions.swift
//  TVChannelsTest
//
//  Created by Дмитрий Фёдоров on 10.01.2022.
//
import UIKit

extension ChannelsView {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.ItemCell)
        collectionView.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.TimeCell)
        collectionView.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.ChannelCell)
        collectionView.backgroundColor = Colors.backGround
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }

    func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection in
            self.itemsSectionLayout(section: section)
        }

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = configuration
        return layout
    }

    private func itemsSectionLayout(section: Int) -> NSCollectionLayoutSection {
        var items: [NSCollectionLayoutItem] = []

        switch section {
        case 0:
            for _ in 0 ..< Constants.numberOfTimeItems {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(CGFloat(Constants.itemWidth)),
                    heightDimension: .absolute(CGFloat(Constants.itemHeight))
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                items.append(item)
            }
        case let sec:
            let programItems = presenter?.programItems?[safeIndex: sec - 1]
            let nameItemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(CGFloat(Constants.itemWidth)),
                heightDimension: .absolute(CGFloat(Constants.itemHeight))
            )
            let nameItem = NSCollectionLayoutItem(layoutSize: nameItemSize)
            items.append(nameItem)
            programItems?.forEach { programItem in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(CGFloat(programItem.length * 4)),
                    heightDimension: .absolute(CGFloat(Constants.itemHeight))
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                items.append(item)
            }
        }

        let width = Constants.numberOfTimeItems * Constants.itemWidth
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(CGFloat(width)),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    private func configureTimeText(position: Int) -> String {
        let hours = Array(1 ... 23)
        var positions: [String] = []
        for index in hours {
            positions.append("\(index):00")
            positions.append("\(index):30")
        }
        return positions[safeIndex: position] ?? ""
    }
}

extension ChannelsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = presenter?.channels?.count else { return 0 }
        return count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.numberOfTimeItems
        case let section:
            guard let count = presenter?.programItems?[safeIndex: section - 1]?.count else { return 0 }
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
            ) as? TimeCollectionViewCell else {
                assertionFailure("Cell not found")
                return UICollectionViewCell()
            }

            cell.configureCell(time: "Today,\n\(Constants.currentDate)")

            return cell

        case let (0, row):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.TimeCell,
                for: indexPath
            ) as? TimeCollectionViewCell else {
                assertionFailure("No cell found")
                return UICollectionViewCell()
            }

            cell.configureCell(time: configureTimeText(position: row - 1))

            return cell

        case let (section, 0):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.ChannelCell,
                for: indexPath
            ) as? ChannelCollectionViewCell else {
                assertionFailure("No cell found")
                return UICollectionViewCell()
            }

            cell.configureCell(
                index: indexPath.section,
                channelName: presenter?.channels?[safeIndex: section - 1]?.callSign
            )
            return cell

        case let (section, row):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellIdentifiers.ItemCell,
                for: indexPath
            ) as? ItemCollectionViewCell else {
                assertionFailure("No cell found")
                return UICollectionViewCell()
            }
            guard let name = presenter?.programItems?[safeIndex: section - 1]?[safeIndex: row - 1]?.name
            else {
                assertionFailure("No cell found")
                return UICollectionViewCell()
            }

            cell.configureCell(itemName: name)

            return cell
        }
    }
}

extension ChannelsView: ChannelsViewProtocol {
    func updateData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ChannelsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0), (_, 0), (0, _):
            break
        case let (section, row):
            presenter?.showDetails(channelNumber: section - 1, itemNumber: row - 1)
        }
    }
}
