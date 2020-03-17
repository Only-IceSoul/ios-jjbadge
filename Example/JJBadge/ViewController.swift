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
        .setText(text: "99+")
            .setTextColor(UIColor.green)
        .setTextSize(20)
        .setFont("Lato-Bold")
            .setStrokeWidth(0.5)
            .setStrokeColor(UIColor.red)
            .setTextOffsetX(-2)
            .setTextOffsetY(4)
            .setBackgroundColor(UIColor.black)
    
        view.addSubview(child)
        child.clCenterInParent()
        .clApply()
    
        
       
    }



}

