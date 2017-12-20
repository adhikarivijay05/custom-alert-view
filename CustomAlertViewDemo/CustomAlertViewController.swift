//
//  ViewController.swift
//  alertview
//
//  Created by Vijay Adhikari on 20/12/17.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//
import UIKit

class CustomAlertViewController : UIViewController {
    let transitioner = CAVTransitioner()
    
    @IBOutlet weak var txtview: UITextView!
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
        
        
    }
    
    override func viewDidLoad() {
        print("hwo  ru ")
        self.test()

    }
    func test()  {
        
        let linkAttributes = [
            NSAttributedStringKey.link: URL(string: "https://www.apple.com")!,
            NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 18.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.blue
            ] as [NSAttributedStringKey : Any]
        
        let attributedString = NSMutableAttributedString(string: "As you are the guest user , you are not allow to perform this task . please contact our branch")
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(20, 30))
        
        txtview.attributedText = attributedString
        txtview.translatesAutoresizingMaskIntoConstraints = false
        txtview.attributedText = attributedString
    }
    
    
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDismiss(_ sender:Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}







