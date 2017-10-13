//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Ricardo Lousada on 08/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePickecer: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
        
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        }
      
        storePickecer.delegate = self
        storePickecer.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        /* Teste data to load stores
        let store = Store(context: context)
        store.name = "Best By"
    
        let store2 = Store(context: context)
        store2.name = "Amazon"
        
        let store3 = Store(context: context)
        store3.name = "Tesla Dealership"
        
        let store4 = Store(context: context)
        store4.name = "Target"
        
        let store5 = Store(context: context)
        store5.name = "OLX"
        
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        ad.saveContext()
        */
        
        getStores()
        
        if itemToEdit != nil {
        
            loadItemData()
        
        }
        
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // When selected
    }
    
    func getStores() {
    
        let fecthRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
        
            self.stores = try context.fetch(fecthRequest)
            self.storePickecer.reloadAllComponents()
        
        } catch {
            
            // handle the error
            
        }
    
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        
        
        if itemToEdit == nil {
        
            item  = Item(context: context)
        
        } else {
        
            item = itemToEdit
        
        }
        
        item.toImage = picture
        if let title = titleField.text {
        
            item.title = title
        
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
            
        }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        item.toStore = stores[storePickecer.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
        
            titleField.text = item.title
            priceField.text = String(item.price)
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
            
                var index = 0
                repeat {
                
                    let s = stores[index]
                    if s.name == store.name {
                    
                        storePickecer.selectRow(index, inComponent: 0, animated: false)
                        break
                        
                    }
                index += 1
                } while (index < stores.count)
                
            }
        
        }
    
    }
    
    
    @IBAction func deletedPressed(_ sender: Any) {
        
        if itemToEdit != nil {
        
            context.delete(itemToEdit!)
            ad.saveContext()
        
        }
        
        _ = navigationController?.popViewController(animated:true)
    }
    
    
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            thumbImage.image = img
        
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}
