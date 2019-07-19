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
        
        view.backgroundColor = .black
        
        guard let path = Bundle.main.path(forResource: "users", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            else {return}
        
        users = try? JSONDecoder().decode([User].self, from: data)
        
        userView.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UsersDataSource.identifier)
        userDataSource = UsersDataSource(users: users!)
        userView.tableView.dataSource = userDataSource
        
        userView.tableView.reloadData()
        
    }

    override func loadView() {
        self.view = userView
    }
}

class UsersView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        //        tableView.separatorInset = UIEdgeInsets.zero
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersDataSource.identifier, for: indexPath) as! UserTableViewCell
//        cell.textLabel?.text = users[indexPath.row].name
        cell.configure(user: users[indexPath.row])
        return cell
    }
    
    
}

class UserTableViewCell: UITableViewCell {
    
    private lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var username = UILabel()
    var name = UILabel()
    var foto = UIImageView()
    
    func configure(user: User) {
        
        username.text = user.username
        username.translatesAutoresizingMaskIntoConstraints = false
        username.textColor = .white
        username.font = UIFont(name: "System", size: 16)
        username.numberOfLines = 0
        
        name.text = user.name
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        name.font = UIFont(name: "System", size: 14)
        name.numberOfLines = 0
        
        foto.translatesAutoresizingMaskIntoConstraints = false
        foto.layer.cornerRadius = foto.frame.size.width / 2;
        foto.clipsToBounds = true;
        
        let url = URL(string: user.img)!
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                foto.image = image
            }
        }
        
        self.addSubview(viewCell)
        self.viewCell.addSubview(foto)
        self.viewCell.addSubview(username)
        self.viewCell.addSubview(name)
        
        NSLayoutConstraint.activate([
            viewCell.heightAnchor.constraint(equalToConstant: 76),
            viewCell.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            viewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            viewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            viewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            foto.heightAnchor.constraint(equalToConstant: 52),
            foto.widthAnchor.constraint(equalToConstant: 52),
            foto.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 12),
            foto.leadingAnchor.constraint(equalTo: self.viewCell.leadingAnchor, constant: 20),
            
            username.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: 18),
            username.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: foto.trailingAnchor, constant: 16),
            username.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 20),
            
            name.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: foto.trailingAnchor, constant: 16),
            name.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.username.bottomAnchor, constant: 2),
            name.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 17),
            ])
    }
    
}
