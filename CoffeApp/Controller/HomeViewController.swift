//
//  HomeViewController.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UserdidChoose {

    
    @IBOutlet weak var tableview: UITableView!
    var coffeesArray:Coffees?
    var expandingIndices = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableview.rowHeight = UITableViewAutomaticDimension
        
        DataSource.shared.retrieveData { (coffeesArray) in
            self.coffeesArray = coffeesArray
            let tableCount = (self.coffeesArray?.bars?.count) ?? 0
            for _ in 0...tableCount - 1 {
                self.expandingIndices.append(false)
                
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        closeAllSection()
        tableview.reloadData()
    }
    
    func didChooseDelegate(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let map = storyboard.instantiateViewController(withIdentifier: "myMap") as! MapViewController
        map.selectedCoffee = self.coffeesArray?.bars![index]
        self.navigationController?.pushViewController(map, animated: true)
        
    }
    
}

extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !expandingIndices[section] {
            return 0
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.coffeesArray?.bars?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        let coffeeName = self.coffeesArray?.bars![section].name
        view.coffeeName.text = coffeeName
        view.Delegate  = self
        view.expandBtn.tag = section
        view.expandBtn.addTarget(self, action: #selector(handleExpand(_:)), for: .touchUpInside)
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as? CoffeeTableViewCell
        {
            var coffee = self.coffeesArray?.bars![indexPath.section]
            if (coffee?.tags?.hashValue == Tags.bool(false).hashValue) {
                coffee?.tags = Tags.string("aucun")
                print("aucun")
            }
            cell.coffeeInstance = coffee
            return cell
        }
        return CoffeeTableViewCell()
    }
    
    

    
    
    @objc func handleExpand(_ sender:UIButton){
        let section = sender.tag
        var indexpaths = [IndexPath]()
        let indexpath = IndexPath(row: 0, section: section)
        indexpaths.append(indexpath)
        
        let isExpanded = expandingIndices[section]
        expandingIndices[section] = !isExpanded
        
        if isExpanded {
            tableview.deleteRows(at:indexpaths, with:.fade)
            sender.setImage(#imageLiteral(resourceName: "chevron-arrow-down"), for: .normal)
            
        } else{
            sender.setImage(#imageLiteral(resourceName: "chevron-arrow-up"), for: .normal)
            tableview.insertRows(at: indexpaths, with: .fade)
        }
    }
    
    func closeAllSection(){
        let count = (self.expandingIndices.count)
        for i in 0...count - 1 {
            self.expandingIndices[i] = false
        }
    }

}
