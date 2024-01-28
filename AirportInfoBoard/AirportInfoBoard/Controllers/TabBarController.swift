//
//  TabBarController.swift
//  AirportInfoBoard
//
//  Created by Михаил Чертов on 22.01.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.navigationItem.hidesBackButton = true
        
        let arrivalController = UINavigationController(rootViewController: ArrivalViewController())
        let departureController = UINavigationController(rootViewController: DepartureViewController())
        
        arrivalController.title = "Прилет"
        departureController.title = "Вылет"
        
        self.modalPresentationStyle = .fullScreen
        
        self.setViewControllers([arrivalController, departureController], animated: true)
        
        guard let items = tabBar.items else { return }
        
        let images = ["airplane.arrival", "airplane.departure"]
        
        for x in 0..<images.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }

}
