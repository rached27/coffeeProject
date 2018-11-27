//
//  ViewController.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import Foundation

class DataSource{
    
    static let shared = DataSource()
    
    private init(){}
    
    func retrieveData(completionHandler:@escaping (Coffees) -> Void){
        let url = Bundle.main.url(forResource: "Pense-bete", withExtension: "json")
        
        guard let jsonData = url else{return }
        guard let data = try? Data(contentsOf: jsonData) else { return }
        let responseObject = try? JSONDecoder().decode(Coffees.self, from: data)
        completionHandler(responseObject!)
        }
        
    }



