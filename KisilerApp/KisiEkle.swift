//
//  KisiEkle.swift
//  KisilerApp
//
//  Created by ahmet on 30.06.2020.
//  Copyright © 2020 ahmet. All rights reserved.
//

import UIKit


class KisiEkle: UIViewController {

    @IBOutlet weak var kisiAd: UITextField!
    
    @IBOutlet weak var kisiTel: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
    }

    @IBAction func kisiKaydet(_ sender: Any) {
        
    let kisiKayıt = Kisidepolama(context: context)
    
        kisiKayıt.kisiAd = kisiAd.text
        kisiKayıt.kisiTel = kisiTel.text
        
        appDelegate.saveContext()
        
        print("\(kisiKayıt.kisiAd!) kayıt edildi")
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
