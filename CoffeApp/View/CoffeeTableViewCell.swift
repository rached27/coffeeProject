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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var thisCoffee:Coffee? {
        didSet{
            updateCell(of: thisCoffee!)
        }
    }
    
    
    func updateCell(of coffee:Coffee){
        let url = coffee.tags!
        
        self.coffeeName.text = "Site : \(String(describing: url)))"
        self.coffeeName.invalidateIntrinsicContentSize()
        
    }



}
