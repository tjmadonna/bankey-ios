//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Tyler Madonna on 7/31/22.
//

import UIKit

class AccountSummaryCell: UITableViewCell {

    // MARK: - Account
    enum AccountType: String {
        case banking = "Banking"
        case creditCard = "Credit Card"
        case investment = "Investment"
    }

    // MARK: - View Model
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal

        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }

    let viewModel: ViewModel? = nil

    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()

    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()

    let chevronImageView = UIImageView()

    static let reuseId = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) cannot be used to create cell")
    }
    
}

extension AccountSummaryCell {

    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"

        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "Account name"

        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0

        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.text = "Some balance"

        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")

        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)

        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)

        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
    }

    private func layout() {

        // Type label
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])

        // Underline view
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4)
        ])

        // Name label
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])

        // Balance stack
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
        ])

        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }

    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]

        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)

        rootString.append(dollarString)
        rootString.append(centString)

        return rootString
    }

}

extension AccountSummaryCell {

    func configure(with viewModel: ViewModel) {

        typeLabel.text = viewModel.accountType.rawValue
        nameLabel.text = viewModel.accountName
        balanceAmountLabel.attributedText = viewModel.balanceAsAttributedString

        switch viewModel.accountType {
        case .banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current balance"
        case .creditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
        case .investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }

}
