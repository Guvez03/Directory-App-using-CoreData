//
//  KisiGuncelle.swift
//  KisilerApp
//
//  Created by ahmet on 30.06.2020.
//  Copyright © 2020 ahmet. All rights reserved.
//

import UIKit
import CoreData


class KisiGuncelle: UIViewController {


    @IBOutlet weak var kisiAd: UITextField!
    
    @IBOutlet weak var kisiTel: UITextField!
    
    var gelenGuncellenecekKisi:Kisidepolama?
 
    let context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        kisiAd.text = gelenGuncellenecekKisi?.kisiAd
        kisiTel.text = gelenGuncellenecekKisi?.kisiTel
  
    }
    
    @IBAction func kisiGuncelle(_ sender: Any) {
        
        self.gelenGuncellenecekKisi!.kisiAd = kisiAd.text
        self.gelenGuncellenecekKisi!.kisiTel = kisiTel.text

        appDelegate.saveContext()
                
        navigationController?.popViewController(animated: true)
        
    }
    

}
