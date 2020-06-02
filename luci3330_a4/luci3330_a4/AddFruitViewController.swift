//
//  AddFruitViewController.swift
//  luci3330_a1
//
//  Created by Stefan Lucic on 2020-02-15.
//  Copyright © 2020 wlu. All rights reserved.
//

import UIKit

class AddFruitViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var fruitName: UITextField!
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitImageButton: UIButton!
    var imagePicker = UIImagePickerController()
    var fruit: Fruit?
    var isImage = false
    
    
 
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //SharingFruitCollection.sharedFruitCollection.fruitCollection = sharedFruitCollection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //SharingFruitCollection.sharedFruitCollection.loadFruitCollection()
        //sharedFruitCollection = SharingFruitCollection.sharedFruitCollection.fruitCollection
        //let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        //self.navigationItem.leftBarButtonItem = backButton
        updateSaveButton()
        
    }
    
    @IBAction func addFruitButton(_ sender: Any) {
        print("add fruit button pressed")
        
        sharedFruitCollection?.addFruit(fruit: Fruit(fruitName: fruitName.text!, fruitImage: fruitImage.image!, likes: 0, disLikes: 0)!)
        
        showAlert(fruit: fruitName.text!)
        
        fruitName.text = ""
        fruitImage.image = UIImage(systemName: "questionmark")
    }
    
    /*
    @IBAction func saveButton(_ sender: Any) {
        print("save fruit button pressed")
        
        if (fruitName.text != "" && isImage) {
            sharedFruitCollection?.addFruit(fruit: Fruit(fruitName: fruitName.text!, fruitImage: fruitImage.image!, likes: 0, disLikes: 0)!)
            
            showAlert(fruit: fruitName.text!)
            
            fruitName.text = ""
            fruitImage.image = UIImage(systemName: "questionmark")
            isImage = false
        }
        
        
    }*/
    
    func textFieldDidEndEditing(_ field_name: UITextField) {
        updateSaveButton()
    }
    func textFieldDidBeginEditing(_ field_name: UITextField) {
       saveButton.isEnabled = false;
    }
    
    private func updateSaveButton() {
        // Disable the Save button if the text field is empty.

        let text = fruitName.text ?? ""
        print(text)
        saveButton.isEnabled = !text.isEmpty
    }
    
    func showAlert(fruit: String) {
        let alert = UIAlertController(title: "Add a fruit", message: "The fruit \(fruit) is added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func fruitImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func textfield(_ sender: Any) {
        navItem.rightBarButtonItem?.isEnabled = (!fruitName.text!.isEmpty && isImage)
        fruitName.resignFirstResponder()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print("Image Picker Called")
        guard let selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Expected dictionary conaining image, but was provided with the following: \(info)")
        }
        fruitImage.image = selectedPhoto
        dismiss(animated: true, completion: nil)
        isImage = true
    }
    
    func getFruit() -> Fruit {
        return self.fruit!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { super.prepare(for: segue, sender: sender)
        fruit = Fruit(fruitName: fruitName.text!, fruitImage: fruitImage.image!, likes: 0, disLikes: 0)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
