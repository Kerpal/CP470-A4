//
//  DeleteFruitViewController.swift
//  luci3330_a1
//
//  Created by Stefan Lucic on 2020-02-15.
//  Copyright © 2020 wlu. All rights reserved.
//

import UIKit

class DeleteFruitViewController: UIViewController {

    @IBOutlet weak var fruitsImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var fruitName: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SharingFruitCollection.sharedFruitCollection.fruitCollection = sharedFruitCollection
        sharedFruitCollection = SharingFruitCollection.sharedFruitCollection.fruitCollection
    
        if (sharedFruitCollection!.fruitAmount() > 0) {
            let currentFruit = SharingFruitCollection.sharedFruitCollection.fruitCollection?.currentFruit()
            fruitsImageView.image = currentFruit?.returnFruitImage()
            
            fruitName.text = currentFruit?.returnFruitName()
            fruitName.sizeToFit()
            
        }
        else {
            fruitsImageView.image = UIImage(systemName:"questionmark")
            
            fruitName.text = "No fruit"
            fruitName.sizeToFit()

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         _ = SharingFruitCollection()
        SharingFruitCollection.sharedFruitCollection.fruitCollection = FruitCollection() //initialize only once
         // set up the view
    
        if (sharedFruitCollection!.fruitAmount() > 0) {
            let currentFruit = SharingFruitCollection.sharedFruitCollection.fruitCollection?.currentFruit()
            fruitsImageView.image = currentFruit?.returnFruitImage()
            
            fruitName.text = currentFruit?.returnFruitName()
            fruitName.sizeToFit()
            
        }
        else {
            fruitsImageView.image = UIImage(systemName:"questionmark")
            
            fruitName.text = "No fruit"
            fruitName.sizeToFit()

        }
    }
    

    @IBAction func nextButton(_ sender: Any) {
        print("next button clicked")
        
        if (sharedFruitCollection!.fruitAmount() > 0) {
            sharedFruitCollection?.nextFruit()
            
            let currentFruit = SharingFruitCollection.sharedFruitCollection.fruitCollection?.currentFruit()
            
            fruitsImageView.image = currentFruit?.returnFruitImage()
            
            fruitName.text = currentFruit?.returnFruitName()
            fruitName.sizeToFit()
        }
        
        else {
            showAlert()
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        print("delete button clicked")
        
        if (sharedFruitCollection!.fruitAmount() > 0) {
            deletedAlert(fruit: (sharedFruitCollection?.currentFruit().fruitName)!)
            sharedFruitCollection?.removeFruit()
            
            
            if (sharedFruitCollection?.fruitAmount() == 0) {
                fruitsImageView.image = UIImage(systemName:"questionmark")
                
                fruitName.text = "No fruit"
                fruitName.sizeToFit()
            }
            else {
                let currentFruit = SharingFruitCollection.sharedFruitCollection.fruitCollection?.currentFruit()
                
                fruitsImageView.image = currentFruit?.returnFruitImage()
                
                fruitName.text = currentFruit?.returnFruitName()
                fruitName.sizeToFit()
            }
        }
        else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No fruit", message: "The fruit collection is empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deletedAlert(fruit: String) {
        let alert = UIAlertController(title: "Delete a fruit", message: "The fruit \(fruit) is deleted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}
