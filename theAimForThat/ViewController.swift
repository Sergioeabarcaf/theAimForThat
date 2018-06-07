//
//  ViewController.swift
//  theAimForThat
//
//  Created by Sergio Abarca Flores on 31-05-18.
//  Copyright © 2018 sergioeabarcaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let alert = UIAlertController(title: "Hola Mundo", message: "Ete mensaje es de la descripcion de la alerta", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "genial!", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    @IBAction func sliderPoint(_ sender: UISlider) {
        print("El valor del slide es: \(sender.value)")
    }
    
}

