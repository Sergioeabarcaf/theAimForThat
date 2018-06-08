//
//  ViewController.swift
//  theAimForThat
//
//  Created by Sergio Abarca Flores on 31-05-18.
//  Copyright © 2018 sergioeabarcaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue : Int = 0
    var targetValue : Int = 0
    var roundsValue : Int = 0
    var scoreValue : Int = 0
    var differenceValue : Int = 0
    var point : Int = 0

    @IBOutlet weak var scoreLabels: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nuevaRonda()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        
        self.differenceValue = Int((self.currentValue - self.targetValue).magnitude)
        
        self.point = differenceValue > 0 ? 100 - differenceValue : 1000
        
        self.scoreValue += self.point
        
        let mensaje = """
        tu puntaje es \(self.point)
        """
        
        let alert = UIAlertController(title: "Puntuacion", message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "genial!", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        nuevaRonda()
    }
    @IBAction func sliderPoint(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetValues()
    }
    func nuevaRonda(){
        self.targetValue = Int(arc4random_uniform(100) + 1)
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.roundsValue += 1
        actualizarLabels()
    }
    
    func actualizarLabels(){
        self.targetLabel.text = String(self.targetValue)
        self.roundsLabel.text = String(self.roundsValue)
        self.scoreLabels.text = String(self.scoreValue)
    }
    
    func resetValues(){
        self.roundsValue = 0
        self.scoreValue = 0
        self.targetValue = Int(arc4random_uniform(100) + 1)
        self.currentValue = 50
        actualizarLabels()
    }
    
}

