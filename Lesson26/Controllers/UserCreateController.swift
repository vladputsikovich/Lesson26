//
//  UserCreateController.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import UIKit

fileprivate struct  Constants {
    static let identificator = "cell"
    static let tableFields = ["NAME", "FEMALE", "EMAIL"]
}

class UserCreateController: UIViewController {

    var userTableView = UITableView()
    
    let dbManager: DBManager = DBManagerImpl()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Create user"
        //saveData()
        createTableView()
        
    }
    
    func createTableView() {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let bottomBarHeight = tabBarController?.tabBar.frame.height ?? 0
        userTableView = UITableView(
            frame: CGRect(
                x: .zero,
                y: topBarHeight,
                width: view.frame.width,
                height: view.frame.height - topBarHeight - bottomBarHeight
            ),
            style: .plain
        )
        userTableView.dataSource = self
        userTableView.dragInteractionEnabled = true
        userTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identificator)
        view.addSubview(userTableView)
    }
    
    func saveData() {
        let model = UserModel()
//        model.name = nameText.text ?? "NAME"
//        model.female = femaleText.text ?? "FEMALE"
//        model.email = emailText.text ?? "EMAIL"
        
//        let course = CourseModel()
//        course.courseName = "f4"
//        course.subject = "math"
//        course.industry = "natural"
//        course.teacher = "Uladzislau Putsykovich"
//        course.users.append(model)
        dbManager.save(object: model)
        let alert = UIAlertController(title: "Success", message: "New user create", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.popToPrev()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }

    @objc func popToPrev() {
        navigationController?.popViewController(animated: true)
    }
}

extension UserCreateController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.identificator)
        cell.textLabel?.text = Constants.tableFields[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


