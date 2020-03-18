//
//  ViewController.swift
//  JJBadge
//
//  Created by only-icesoul on 03/16/2020.
//  Copyright (c) 2020 only-icesoul. All rights reserved.
//

import UIKit
import JJBadge


class ViewController: UIViewController {
    
    
    @IBOutlet weak var badge: JJBadgeView!
      let child = JJBadgeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
      
        child.setText(text: "99+")
            .setTextColor(UIColor.green)
        .setTextSize(20)
        .setFont("Lato-Bold")
            .setStrokeWidth(0.5)
            .setStrokeColor(UIColor.red)
        
            .setBackgroundColor(UIColor.black)
    
        view.addSubview(child)
        child.clCenterInParent()
        .clApply()
    
        
       
    }

    private var mCounter = 1
    @IBAction func handleButton(_ sender: UIButton) {
        mCounter = mCounter + 1
        child.setText(text: String(mCounter))
        
        
    }
    

}

