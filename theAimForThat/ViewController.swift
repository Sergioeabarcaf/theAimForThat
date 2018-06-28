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
    var time : Int = 20
    var timer : Timer?

    @IBOutlet weak var scoreLabels: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSlider()
        nuevaRonda()
    }
    
    func setupSlider(){
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        let trackImageLeft = UIImage(named: "SliderTrackLeft")
        let trackImageRight = UIImage(named: "SliderTrackRight")
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let trackLeftResizable = trackImageLeft?.resizableImage(withCapInsets: insets)
        let trackRightRezisable = trackImageRight?.resizableImage(withCapInsets: insets)
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightRezisable, for: .normal)
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
            self.tittle = "¡¡¡ Puntuación perfecta 🎉🎉🎉 !!! "
            self.point *= 10
        case 1...5:
            self.tittle = "Caaaasii... perfecto 😇😇😇"
            self.point *= 5
        case 6...12:
            self.tittle = "Te estas escapando del objetivo 😕😕😕"
            self.point *= 3
        default:
            self.tittle = "NOOOO!!! 🤦🏽‍♂️🤦🏽‍♂️🤦🏽‍♂️"
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
    
    @IBAction func resetNew() {
        let mensaje: String = "Seguro que quieres reiniciar y perder tus \(self.scoreValue) puntos"
        
        let alert = UIAlertController(title: "Reiniciar", message: mensaje, preferredStyle: .alert)
        
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
        self.time = 20
        
        if(self.timer != nil){
            self.timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tickTac), userInfo: nil, repeats: true)
        
        actualizarLabels()
    }
    
    func actualizarLabels(){
        self.targetLabel.text = String(self.targetValue)
        self.roundsLabel.text = String(self.roundsValue)
        self.scoreLabels.text = String(self.scoreValue)
        self.timeLabel.text = String(self.time)
        
        let maxScore = UserDefaults.standard.integer(forKey: "maxscore")
        if (maxScore < self.scoreValue){
            UserDefaults.standard.set(self.scoreValue, forKey: "maxscore")
            self.maxScoreLabel.text = String(self.scoreValue)
        }
        else{
            self.maxScoreLabel.text = String(maxScore)
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        self.view.layer.add(transition, forKey: nil)
    }
    
    func resetValues(){
        self.roundsValue = 1
        self.scoreValue = 0
        self.targetValue = Int(arc4random_uniform(100) + 1)
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.time = 20
        
        if(self.timer != nil){
            self.timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tickTac), userInfo: nil, repeats: true)
        
        let maxScore = UserDefaults.standard.integer(forKey: "maxscore")
        
        if (maxScore < self.scoreValue){
            UserDefaults.standard.set(self.scoreValue, forKey: "maxscore")
        }
        
        actualizarLabels()
    }
    
    @objc func tickTac(){
        self.time -= 1
        self.timeLabel.text = String(self.time)
        
        if(self.time <= 0){
            
            let alert = UIAlertController(title: "Tiempo Acabado 😔😔😔", message: nil, preferredStyle: .alert )
            
            let continueAction = UIAlertAction(title: "Vamos de nuevo!", style: .default, handler: {
                action in
                self.nuevaRonda()
            })
            
            alert.addAction(continueAction)
            
            present(alert, animated: true)
            
            if(self.timer != nil){
                self.timer?.invalidate()
            }
        }
    }
    
}

