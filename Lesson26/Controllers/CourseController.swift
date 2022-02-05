//
//  CourseController.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import UIKit

fileprivate struct  Constants {
    static let identificator = "cell"
}

class CourseController: UIViewController {

    var tableView = UITableView()
    let dbManager: DBManager = DBManagerImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "add"),
            style: .plain,
            target: self,
            action: nil//#selector(addUser)
        )
        createTableView()
        view.backgroundColor = .white
        navigationItem.title = "Courses"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    @objc func addCourse() {
        let createViewController = UserCreateController()
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension CourseController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let models: [CourseModel] = dbManager.obtainUsers()
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models: [CourseModel] = dbManager.obtainUsers()
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.identificator)
        cell.textLabel?.text = "\(models[indexPath.item]["courseName"] ?? "")"
        cell.detailTextLabel?.text = "\(models[indexPath.item]["teacher"] ?? "")"
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
                let models: [CourseModel] = self.dbManager.obtainUsers()
                self.dbManager.removeObject(object: models[indexPath.item])
                tableView.reloadData()
                success(true)
            }
        )
        deleteAction.backgroundColor = .red
    
        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
    }
}
