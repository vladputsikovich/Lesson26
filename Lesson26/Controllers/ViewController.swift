//
//  ViewController.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabController()
    }
    
    func createTabController() {
        
        let usersViewController = UINavigationController(rootViewController: UsersViewController())
        usersViewController.tabBarItem = UITabBarItem(title: usersViewController.navigationItem.title, image: UIImage(named: "user"), selectedImage: UIImage(named: "user"))
        usersViewController.tabBarItem.title = "Users"
        
        let coursesViewController = UINavigationController(rootViewController: CourseController())
        coursesViewController.tabBarItem = UITabBarItem(title: coursesViewController.navigationItem.title, image: UIImage(named: "course"), selectedImage: UIImage(named: "course"))
        coursesViewController.tabBarItem.title = "Courses"
        
        viewControllers = [usersViewController, coursesViewController]
    }
}
