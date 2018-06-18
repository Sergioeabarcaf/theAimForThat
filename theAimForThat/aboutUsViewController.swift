//
//  AboutUsViewController.swift
//  theAimForThat
//
//  Created by Sergio Abarca Flores on 11-06-18.
//  Copyright © 2018 sergioeabarcaf. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var aboutWeb: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "about", withExtension: "html"){
            
            let myURL = URL(string: "\(url)")
            
            let myRequest = URLRequest(url: myURL!)
            
            self.aboutWeb.load(myRequest)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func regresar(){
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
