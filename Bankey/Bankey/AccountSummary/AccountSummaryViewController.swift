//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Tyler Madonna on 7/31/22.
//


import UIKit

class AccountSummaryViewController: UIViewController {

    var accounts: [AccountSummaryCell.ViewModel] = []
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension AccountSummaryViewController {

    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchAccounts()
    }

    private func setupTableView() {
        tableView.backgroundColor = appColor

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView() // Blank footer view

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)

        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) // Use intrinsic content size
        size.width = UIScreen.main.bounds.width // Set width to screen width
        header.frame.size = size

        tableView.tableHeaderView = header
    }

}

extension AccountSummaryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as? AccountSummaryCell else {
            fatalError("Table view cell should be of type AccountSummaryCell")
        }

        let account = accounts[indexPath.row]
        cell.configure(with: account)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

}

extension AccountSummaryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

extension AccountSummaryViewController {

    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .banking,
                                                   accountName: "Basic Savings",
                                                   balance: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .creditCard,
                                                accountName: "Visa Avion Card",
                                                balance: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .creditCard,
                                                      accountName: "Student Mastercard",
                                                      balance: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }

}
