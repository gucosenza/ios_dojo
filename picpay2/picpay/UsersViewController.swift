//
//  UsersViewController.swift
//  picpay
//
//  Created by gustavo.cosenza on 19/06/19.
//  Copyright © 2019 gustavo.cosenza. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    let userView = UsersView()
    var users: [User]?
    var userDataSource: UsersDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        guard let path = Bundle.main.path(forResource: "users", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            else {return}
        
        users = try? JSONDecoder().decode([User].self, from: data)
        
        userView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UsersDataSource.identifier)
        userDataSource = UsersDataSource(users: users!)
        userView.tableView.dataSource = userDataSource
        
        userView.tableView.reloadData()
        
    }

    override func loadView() {
        self.view = userView
    }
}

class UsersDataSource: NSObject, UITableViewDataSource {
    
    let users: [User]
    static let identifier = "identifier"
    
    init(users: [User]) {
        self.users = users
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersDataSource.identifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}


class UsersView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets.zero
        
        NSLayoutConstraint.activate([
            tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
