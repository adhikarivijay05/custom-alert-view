//
//  ViewController.swift
//  alertview
//
//  Created by Vijay Adhikari on 20/12/17.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBAction func doButton (_ sender:Any) {
        let vc = CustomAlertViewController()
        self.present(vc, animated: true)
    }


}
