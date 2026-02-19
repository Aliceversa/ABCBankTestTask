//
//  StatisticsViewController.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    private let statistics: StatisticsModel
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Lifecycle
    
    init(statistics: StatisticsModel) {
        self.statistics = statistics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupConstraints()
        populateStatistics()
    }
    
    // MARK: Private methods
    
    private func setupAppearance() {
        view.backgroundColor = .white
    }
    
    private func populateStatistics() {
        let titleLabel = createLabel(text: "Statistics", font: .boldSystemFont(ofSize: 24))
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(createSpacer(height: 16))
        
        // Page Stats
        for pageStat in statistics.pagesStats {
            let label = createLabel(
                text: "Page \(pageStat.pageNumber) (\(pageStat.itemCount) items)",
                font: .systemFont(ofSize: 16)
            )
            stackView.addArrangedSubview(label)
        }
        
        stackView.addArrangedSubview(createSpacer(height: 16))
        stackView.addArrangedSubview(createSeparator())
        stackView.addArrangedSubview(createSpacer(height: 16))
        
        let charTitle = createLabel(text: "Top 3 Characters", font: .boldSystemFont(ofSize: 18))
        stackView.addArrangedSubview(charTitle)
        stackView.addArrangedSubview(createSpacer(height: 8))
        
        for charStat in statistics.topCharactersStats {
            let label = createLabel(
                text: "\(charStat.character) = \(charStat.count)",
                font: .systemFont(ofSize: 16)
            )
            stackView.addArrangedSubview(label)
        }
    }
    
    private func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        return label
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
    
    private func createSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }
    
}

// MARK: - Setup constraints

extension StatisticsViewController {
    
    private func setupConstraints() {
        view.addSubview(stackView)
        setupStackViewConstraints()
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
}

