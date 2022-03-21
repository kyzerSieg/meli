//
//  FinderViewController.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import Foundation
import UIKit


class FinderViewController: UIViewController{
    @IBOutlet var txtSearch: UITextField!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSearch_OnToch(_ sender: Any){
        if(txtSearch.text != ""){
            self.performSegue(withIdentifier: "gotoSearch", sender: txtSearch.text)
        }else{
            self.showAlert("title".getLocalized(), message: "not_data".getLocalized())
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName: String = segue.identifier!
        if (segueName == "gotoSearch") {
            self.navigationItem.title = ""
            let vc = segue.destination as? SearchViewController
            vc?.textSearch = (sender as! String)
        }
    }
    
    @IBAction func unwindFinder(unwindSegue: UIStoryboardSegue){
        
    }
}
