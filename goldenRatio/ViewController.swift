//
//  ViewController.swift
//  goldenRatio
//
//  Created by Masakaz Ozaki on 2018/06/21.
//  Copyright © 2018 Masakazu Ozaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var segment: UISegmentedControl!
    
//    @IBAction func segmentControlTapped(_ sender: Any) {
//        
//        switch (sender as AnyObject).selectedSegmentIndex {
//        case 0:
//            equalA = true
//        case 1:
//            equalA = false
//        default:
//            equalA = true
//        }
//        
//    }

    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            equalA = true
        case 1:
            equalA = false
        default:
            equalA = true
        }
        
    }
    var goldenRatio = (1.0 + sqrt(5.0)) / 2

    var equalA = true

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        textField.delegate = self
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
//        textField.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBAction func calcButtonTapped() {
        if equalA {
            label.text = "bの長さは" + String(calc(x: atof(textField.text)))
        } else {
            label.text = "aの長さは" + String(calc(x: atof(textField.text)))
        }
        

    }
    
   
    
    func calc(x: Double) -> Double {
        if equalA {
           let y = x * goldenRatio
            
            return y
            
        } else {
            let y = x / goldenRatio
            
            return y
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ユーザがキーボード以外の場所をタップすると、キーボードを閉じる
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // return を押すと、キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }

}

