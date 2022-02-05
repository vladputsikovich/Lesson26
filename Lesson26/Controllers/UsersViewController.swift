//
//  UsersViewController.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import UIKit

fileprivate struct  Constants {
    static let identificator = "cell"
}

class UsersViewController: UIViewController {

    var tableView = UITableView()
    let dbManager: DBManager = DBManagerImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "add"),
            style: .plain,
            target: self,
            action: #selector(addUser)
        )
        navigationItem.title = "Users"
        createTableView()
        //addCourse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addCourse() {
        let model = UserModel()
        model.name = "vlad"
        model.female = "puts"
        model.email = "v@p.com"
        
//        let course = CourseModel()
//        course.courseName = "f4"
//        course.subject = "math"
//        course.industry = "natural"
//        course.teacher = "Uladzislau Putsykovich"
//        course.users.append(model)
        dbManager.save(object: model)
    }
    
    func createTableView() {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let bottomBarHeight = tabBarController?.tabBar.frame.height ?? 0
        tableView = UITableView(
            frame: CGRect(
                x: .zero,
                y: topBarHeight,
                width: view.frame.width,
                height: view.frame.height - topBarHeight - bottomBarHeight
            ),
            style: .plain
        )
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identificator)
        view.addSubview(tableView)
    }
    
    @objc func addUser() {
        let createViewController = UserCreateController()
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let models: [UserModel] = dbManager.obtainUsers()
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models: [UserModel] = dbManager.obtainUsers()
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.identificator)
        cell.textLabel?.text = "\(models[indexPath.item]["female"] ?? "") \(models[indexPath.item]["name"] ?? "")"
        cell.detailTextLabel?.text = "\(models[indexPath.item]["email"] ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(
            style: .normal,
            title:  "Update",
            handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                let createViewController = UserCreateController()
                self.navigationController?.pushViewController(createViewController, animated: true)
                success(true)
            }
        )
        modifyAction.backgroundColor = .blue
        let deleteAction = UIContextualAction(
            style: .normal,
            title:  "Delete",
            handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                let models: [UserModel] = self.dbManager.obtainUsers()
                self.dbManager.removeObject(object: models[indexPath.item])
                tableView.reloadData()
                success(true)
            }
        )
        deleteAction.backgroundColor = .red
    
        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
    }
}

