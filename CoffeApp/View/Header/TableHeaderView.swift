//
//  TableHeaderView.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import UIKit
class TableHeaderView : UIView {
    @IBOutlet private var contentView:UIView?
    // other outlets
    var name:String?
    var tapGesture = UITapGestureRecognizer()
    var Delegate:UserdidChoose?
    
    
    
    
    
    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
        self.coffeeName.text = name
        
        tapGesture = UITapGestureRecognizer(target:self, action: #selector(self.headerTaped(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true

    }
    @objc func headerTaped(_ sender: UITapGestureRecognizer) {
        Delegate?.didChooseDelegate(index: self.coffeeName.tag)
    }

    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
        
        
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TableHeader", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }
}
protocol UserdidChoose {
    func didChooseDelegate(index:Int)
}
