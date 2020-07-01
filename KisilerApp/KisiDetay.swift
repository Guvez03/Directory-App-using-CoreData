//
//  KisiDetay.swift
//  KisilerApp
//
//  Created by ahmet on 30.06.2020.
//  Copyright © 2020 ahmet. All rights reserved.
//

import UIKit

class KisiDetay: UIViewController {

    @IBOutlet weak var kisiAd: UILabel!
  
    @IBOutlet weak var kisiTel: UILabel!
    
    var gelenVeriAd:String?
    var gelenVeriTel:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        kisiAd.text = gelenVeriAd
        kisiTel.text = gelenVeriTel

        
    }
    

    

}
