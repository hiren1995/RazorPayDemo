//
//  ViewController.swift
//  RazorPay_Demo
//
//  Created by LogicalWings Mac on 05/11/18.
//  Copyright © 2018 LogicalWings Mac. All rights reserved.
//

import UIKit
import Razorpay

class ViewController: UIViewController {

    private var razorpay : Razorpay!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAmt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Razorpay Integration Demo"
        
        razorpay = Razorpay.initWithKey("rzp_test_1vwAsHLCvibGXW", andDelegate: self)
        
    }
    @IBAction func btnCheckout(_ sender: UIButton) {
        
        // amount mandatory in paise
        
        let options: [String:Any] = [
            "amount" : (txtAmt.text as! NSString).floatValue * 100 ,
            "description": "First Trial Purchase",
            "name": txtName.text!,
            "prefill": [
            "contact": txtContact.text!,
            "email": txtEmail.text!
            ],
            "theme": [
                "color": "#F37254"
                //"color": "#0000ff"
            ]
        ]
        razorpay.open(options)
    }
}

extension ViewController:RazorpayPaymentCompletionProtocol{
    
    func onPaymentError(_ code: Int32, description str: String) {
        UIAlertView.init(title: "Error", message: str, delegate: self, cancelButtonTitle: "OK").show()
       
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        
        print(payment_id)
        UIAlertView.init(title: "Payment Successful", message: payment_id, delegate: self, cancelButtonTitle: "OK").show()
    }
    
    
}

