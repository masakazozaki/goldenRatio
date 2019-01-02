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
    
    var goldenRatio = (1.0 + sqrt(5.0)) / 2
    var isA = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        textField.delegate = self
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isA = true
        case 1:
            isA = false
        default:
            isA = true
        }
    }
    
    @IBAction func calcButtonTapped() {
        if isA {
            label.text = "b: " + String(calc(x: atof(textField.text)))
        } else {
            label.text = "a: " + String(calc(x: atof(textField.text)))
        }
    }
    
    func calc(x: Double) -> Double {
        if isA {
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