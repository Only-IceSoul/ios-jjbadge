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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let child = JJBadgeView()
            .setTextColor(UIColor.white)
            .setTextSize(10)
            .setStrokeWidth(0.5)
          .setText(text: "99+")
        
    
        
            
        view.addSubview(child)
        child.backgroundColor = UIColor.red
        child.clCenterInParent()
        .clApply()
    
        
    }



}

