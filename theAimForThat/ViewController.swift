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
    var tittle : String = "Titulo"

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
        
        self.point = 100 - self.differenceValue
        
        switch self.differenceValue {
        case 0:
            self.tittle = "¡¡¡ Puntuación perfecta !!! "
            self.point *= 10
        case 1...5:
            self.tittle = "Caaaasii... perfecto"
            self.point *= 5
        case 6...12:
            self.tittle = "Te estas escapando del objetivo"
            self.point *= 3
        default:
            self.tittle = "Me saliste bastante timida"
        }
        
        let mensaje = "tú puntaje es \(self.point)"
        
        let alert = UIAlertController(title: self.tittle, message: mensaje, preferredStyle: .alert )
        
        let continueAction = UIAlertAction(title: "Vamos por otra!", style: .default, handler: {
            action in
                self.nuevaRonda()
            })
        
        alert.addAction(continueAction)
        
        present(alert, animated: true)
        
    }
    @IBAction func sliderPoint(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        let mensaje: String = "Seguro que quieres reiniciar y perder tus \(self.scoreValue) puntos"
        
        let alert = UIAlertController(title: "Reiniciar", message: mensaje, preferredStyle: .actionSheet)
        
        let confirmReset = UIAlertAction(title: "Si", style: .destructive, handler: {
            action in
            self.resetValues()
        })
        
        let notReset = UIAlertAction(title: "No", style: .default )
        
        alert.addAction(notReset)
        alert.addAction(confirmReset)
        
        
        present(alert, animated: true)
    }
    
    
    func nuevaRonda(){
        self.targetValue = Int(arc4random_uniform(100) + 1)
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.roundsValue += 1
        self.scoreValue += self.point
        actualizarLabels()
    }
    
    func actualizarLabels(){
        self.targetLabel.text = String(self.targetValue)
        self.roundsLabel.text = String(self.roundsValue)
        self.scoreLabels.text = String(self.scoreValue)
    }
    
    func resetValues(){
        self.roundsValue = 1
        self.scoreValue = 0
        self.targetValue = Int(arc4random_uniform(100) + 1)
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        actualizarLabels()
    }
    
}

