//
//  CustomTabBarController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 19/01/23.
//
//  MARK: Explicação de como Embedar a TabBar em uma NavigationController. Precisamos colocar a ViewController dentro da NavigationController e inicialiar a tabBar com a NavigationController, então como fazemos isso ?

import UIKit

class CustomTabBarController: UITabBarController {
    
    //MARK: Hierarquia de Views
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instantiate ViewController
        let studyPlanTVC = StudyPlanTableViewController()
        let settingsVC = SettingsViewController()
        
        //Change Titles
        studyPlanTVC.title = "Planos de Estudo"
        settingsVC.title = "Configurações"
        
        //Associate ViewControllers to a NavigationController
        let firstNavigation = UINavigationController(rootViewController: studyPlanTVC)
        let secondNavigation = UINavigationController(rootViewController: settingsVC)
        
    
        //Associate TabBar to NavigationController
        self.viewControllers = [firstNavigation,secondNavigation]
        
        //Define third configuration
        self.tabBar.tintColor = .black
    }
}
