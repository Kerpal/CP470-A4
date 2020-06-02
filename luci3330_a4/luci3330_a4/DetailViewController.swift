//
//  ViewController.swift
//  luci3330_a1
//

import UIKit

let imgApple = UIImage(named:"apple.jpg")
let imgOrange = UIImage(named:"orange.jpg")
let imgWatermelon = UIImage(named:"watermelon.jpg")
let imgDragonfruit = UIImage(named:"dragonfruit.jpg")

var index: Int?
var currentFruit: Fruit?
//var sharedFruitCollection: FruitCollection?

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var fruitNav: UINavigationItem!
    @IBOutlet weak var fruitsImageView: UIImageView!
    
    @IBOutlet weak var fruitName: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var dislikesLabel: UILabel!
    var fruitCollection = FruitCollection()
    
    func initWithData(_ fruit: Fruit) {
        currentFruit = fruit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        fruitsImageView.image = currentFruit?.returnFruitImage()
        
        fruitName.text = currentFruit?.returnFruitName()
        fruitName.sizeToFit()
        
        let likes = String(currentFruit!.numLikes())
        likesLabel.text = likes
        likesLabel.sizeToFit()
        
        let dislikes = String(currentFruit!.numDislikes())
        dislikesLabel.text = dislikes
        dislikesLabel.sizeToFit()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        fruitsImageView.image = currentFruit?.returnFruitImage()
        
        fruitName.text = currentFruit?.returnFruitName()
        fruitName.sizeToFit()
        
        let likes = String(currentFruit!.numLikes())
        likesLabel.text = likes
        likesLabel.sizeToFit()
        
        let dislikes = String(currentFruit!.numDislikes())
        dislikesLabel.text = dislikes
        dislikesLabel.sizeToFit()
        
        
    }

    @IBAction func likes(_ sender: Any) {
        print("likes button clicked")
        
        currentFruit?.increaseLikes()
        let likes = String(currentFruit!.numLikes())
        likesLabel.text = likes
        likesLabel.sizeToFit()
    }
    
    @IBAction func dislikes(_ sender: Any) {
        print("dislikes button clicked")
        
        currentFruit?.increaseDislikes()
        let dislikes = String(currentFruit!.numDislikes())
        dislikesLabel.text = dislikes
        dislikesLabel.sizeToFit()

    }
    
    @IBAction func next(_ sender: Any) {
        print("next button clicked")
        
            
        if (sharedFruitCollection!.fruitAmount() > 0) {
            sharedFruitCollection?.nextFruit()
            
            currentFruit = sharedFruitCollection!.currentFruit()
            
            fruitsImageView.image = currentFruit?.returnFruitImage()
            
            fruitName.text = currentFruit?.returnFruitName()
            fruitName.sizeToFit()
            
            let likes = String(currentFruit!.numLikes())
            likesLabel.text = likes
            likesLabel.sizeToFit()
            
            let dislikes = String(currentFruit!.numDislikes())
            dislikesLabel.text = dislikes
            dislikesLabel.sizeToFit()
        }
        
        
    }

}

