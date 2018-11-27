//
//  CoffeTableViewCell.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {

    @IBOutlet weak var coffeeName: UILabel!
    var coffeeInstance:Coffee?{
        didSet{
            updateCell(of: coffeeInstance!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(of coffee:Coffee){
 //       let url = coffee.tags!
        let tags = getTags(line: coffee.tags!)
        print(tags ?? "")
        self.coffeeName.text = "Tags : \(tags ?? "")"
        self.coffeeName.invalidateIntrinsicContentSize()
        
    }
    
    
    func getTags(line: Tags) -> String? {
        var tag:String?
        if case .string(let value) = line {
            tag = value
        }
        return tag
    }

}
