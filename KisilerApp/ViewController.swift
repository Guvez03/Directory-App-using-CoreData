//
//  ViewController.swift
//  KisilerApp
//
//  Created by ahmet on 30.06.2020.
//  Copyright © 2020 ahmet. All rights reserved.
//

import UIKit
import CoreData
import Foundation

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var kisilerListe:[Kisidepolama] = [Kisidepolama]()
          
    var aramaKelimesi : String?
    
    var aramaYapiliyorMu = false

    let context = appDelegate.persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
        
    searchBar.delegate = self

    }
   override func viewWillAppear(_ animated: Bool) {
    if aramaYapiliyorMu{
        aramayap(kisi_ad:aramaKelimesi!)
    }else{
        tumKisileriAl()
    }
    tableView.reloadData()
    }
   func aramayap(kisi_ad:String){
             
         let  fetchRequest : NSFetchRequest<Kisidepolama> = Kisidepolama.fetchRequest()
      
         fetchRequest.predicate = NSPredicate(format:"kisiAd contains %@", kisi_ad.lowercased())
            
         do{
             self.kisilerListe = try context.fetch(fetchRequest)
         }catch{
             print("errror")
         }
    
      }
      func tumKisileriAl(){
          do{
              kisilerListe = try context.fetch(Kisidepolama.fetchRequest())
          }catch{
              print("kisiler alınırken hata")
          }
          
          }
    
    @IBAction func kisiEkleButton(_ sender: Any) {
        
     tableView.reloadData()

     performSegue(withIdentifier: "kisiEkleGecis", sender: nil)
        
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
/* BU GÖSTERİM HATALI VERİ TABANINDAKİ VERİLERİ ÇEKİP GÖSTERİYOR SÜREKLİ VE SEARCHBARDA YAZILANI ARATMIYOR HERHANGİ BİR DÖNÜŞ SAĞLAMIYOR
    do{
        kisilerListe = try context.fetch(Kisidepolama.fetchRequest())

       }catch{
           print("veri çekerken hata")
       }
    */
        
    return kisilerListe.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre", for: indexPath) as! KisilerHucre
        
        cell.kisiLabel.text = "\(kisilerListe[indexPath.row].kisiAd!) - \(kisilerListe[indexPath.row].kisiTel!)"
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Üzerine tıklanan kisinin verilerinin diğer tarafa taşımak için tıklanma özelliği olan didselectrowat methodu oluşturduk
        //Bu sınıftaki verileri aldık ve diğer sayfaya taşımak için performSegue kullandık
        // 2 veriyi gönderdik
        // performsegue prepare methodunu tetikler o  methodda ise gelenverileri aldık ve diğer sayfadaki oluşturduğumuz değişkene atadık

        let tiklananAd = kisilerListe[indexPath.row].kisiAd
        let tiklananTel = kisilerListe[indexPath.row].kisiTel

        performSegue(withIdentifier: "kisilerdetay", sender: (tiklananAd,tiklananTel))
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let update = UITableViewRowAction(style: .normal, title: "Güncelle") { action, index in  // closure yapısı
            
    
            let guncellenecekVeri = self.kisilerListe[indexPath.row]
            

            self.performSegue(withIdentifier: "kisiGuncelleGecis", sender: guncellenecekVeri)
                    
            self.tableView.reloadData()
            
        }
    let delete = UITableViewRowAction(style: .default, title: "Sil") { action, index in
        
        let silinecekKisi = self.kisilerListe[indexPath.row]
        
        self.context.delete(silinecekKisi)
        
        appDelegate.saveContext()
       
        if self.aramaYapiliyorMu{
            self.aramayap(kisi_ad: self.aramaKelimesi!)
        }else{
            self.tumKisileriAl()
        }
        tableView.reloadData()
        
        print("\(silinecekKisi.kisiAd!) başarıyla silindi")
        
    }
    return [delete, update]
    
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     if segue.identifier == "kisilerdetay" {
        
        if let gelenVeri = sender as? (String,String) {
               print(gelenVeri.0)
               print(gelenVeri.1)

            // Veri Transferi
               
               let gidilecekVC = segue.destination as! KisiDetay
            
               gidilecekVC.gelenVeriAd = gelenVeri.0
               gidilecekVC.gelenVeriTel = gelenVeri.1
               
           }
        }
        
    if segue.identifier == "kisiGuncelleGecis"{
       
        if let gelenVeri = sender as? Kisidepolama {

          // Veri Transferi
          
          let gidilecekVC = segue.destination as! KisiGuncelle
       
          gidilecekVC.gelenGuncellenecekKisi = gelenVeri
          
      }
    }
}
}
extension  ViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    print("arama sonucu \(searchText)")
    
    aramaKelimesi = searchText
    
   if searchText == "" {
        aramaYapiliyorMu = false
        self.tumKisileriAl()
    }else{
        aramaYapiliyorMu = true
        
        
    self.aramayap(kisi_ad: searchText)
    }
        tableView.reloadData()
    }
}
