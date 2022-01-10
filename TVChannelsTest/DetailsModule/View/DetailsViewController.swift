// DetailsViewController.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - UI Components

    private let programNameLabel = UILabel()
    private let channelnameLabel = UILabel()
    private let programStartTimeLabel = UILabel()
    private let programLengthLabel = UILabel()

    // MARK: - Public Properties

    var presenter: DetailsViewPresenterProtocol?

    // MARK: - ViewController (DetailsViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        runMethods()
    }

    // MARK: - Private Methods

    private func runMethods() {
        configureView()
        addLabels()

        presenter?.getData(view: self)
    }

    private func configureView() {
        view.backgroundColor = Colors.backGround
    }

    private func addLabels() {
        createLabel(label: programNameLabel, topElement: view)
        createLabel(label: channelnameLabel, topElement: programNameLabel)
        createLabel(label: programStartTimeLabel, topElement: channelnameLabel)
        createLabel(label: programLengthLabel, topElement: programStartTimeLabel)
    }

    private func createLabel(label: UILabel, topElement: AnyObject) {
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 25)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            label.topAnchor.constraint(equalTo: topElement.topAnchor, constant: 100),
        ])
    }
}

// MARK: - Extensions

extension DetailsViewController: DetailsViewProtocol {
    func updateData(item: ProgramItem, channelName: String) {
        title = item.name

        channelnameLabel.text = "Channel name: \(channelName)"
        programNameLabel.text = "Program name: \(item.name)"
        programStartTimeLabel.text = "Start time: \(item.startTime)"
        programLengthLabel.text = "Program length, min: \(item.length)"
    }
}
