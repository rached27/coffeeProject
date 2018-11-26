//
//  ViewController.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    var tabBarIteam = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkGray], for: .normal)
      
        let selectedImageAdd = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
        let DeSelectedImageAdd = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = (self.tabBar.items?[0])!
        tabBarIteam.image = DeSelectedImageAdd
        tabBarIteam.selectedImage = selectedImageAdd
        
         let selectedImageAlert =  UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
         let deselectedImageAlert = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = (self.tabBar.items?[1])!
        tabBarIteam.image = deselectedImageAlert
        tabBarIteam.selectedImage =  selectedImageAlert
        
        
         // selected tab background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
       
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) , size: tabBarItemSize)
        
        // initaial tab bar index
        self.selectedIndex = 0
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
