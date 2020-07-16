//
//  ViewController.swift
//  Quadratic Solver
//
//  Created by Andrew on 08/07/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var root1: UILabel!
    @IBOutlet weak var root2: UILabel!
    @IBOutlet weak var a: UITextField!
    @IBOutlet weak var b: UITextField!
    @IBOutlet weak var c: UITextField!

    override func viewDidLoad() {
        print("View did load reached")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        root1.isHidden = true
        root2.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        ///Accessibility identifiers
        root1.accessibilityIdentifier = "root1"
        root2.accessibilityIdentifier = "root2"
        a.accessibilityIdentifier = "aTextField"
        b.accessibilityIdentifier = "bTextField"
        c.accessibilityIdentifier = "cTextField"
        
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        a.resignFirstResponder()
        b.resignFirstResponder()
        c.resignFirstResponder()
    }

    @IBAction func helpMe(_ sender: Any) {
        let alertController =
            UIAlertController(title: "About this method",
        message: "A new alternate method proposed by Po-Shen Loh from Carnegie Mellon university. It calculates the average of the two roots from the sum of b. More detail here: https://www.poshenloh.com/quadraticdetail/", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Got it, thanks!", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func solve(_ sender: Any) {
    
        print("I'm in! This is b.text: \(String(describing: b.text))")
        
        var A = Double(a.text ?? "1") ?? 1
        var B = Double(b.text ?? "0") ?? 0
        var C = Double(c.text ?? "0") ?? 0
        
        print("A = \(A)")
        print("B = \(B)")
        print("C = \(C)")
        
        if(A != 1) {
            B = B/A
            C = C/A
            A = 1
            print("#########################")
            print("A = \(A)")
            print("B = \(B)")
            print("C = \(C)")
        }
        
        let average = B == 0 ? 0 : -B / 2
        
        print("Average = \(average)")
        
        var u: Double {
            return (pow(average, 2) - C).squareRoot()
        }
        
        print("u = \(u)")
        
        let positiveRoot = average + u
        let negativeRoot = average - u
        
        print("Positive root = \(positiveRoot)")
        print("Negative root = \(negativeRoot)")
        
        //No real roots
        if positiveRoot.isNaN || negativeRoot.isNaN {
            root1.text = "No real roots"
            root1.isHidden = false
            root2.isHidden = true
        }
        
        //Two real roots
        else if positiveRoot != negativeRoot {
            root1.text = "x₁: \(positiveRoot)"
            root2.text = "x₂: \(negativeRoot)"
            root1.isHidden = false
            root2.isHidden = false
        }
        //One real root
        else if positiveRoot == negativeRoot {
            root1.text = "x: \(positiveRoot)"
            root1.isHidden = false
            root2.isHidden = true
        }
        
    }
    
}

