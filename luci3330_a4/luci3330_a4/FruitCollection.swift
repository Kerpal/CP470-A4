//
//  FruitCollection.swift
//  luci3330_a1
//

import Foundation
import UIKit

class FruitCollection: NSObject, NSCoding {
    var collection = [Fruit]() // a collection is an array of fruits
    var current:Int = 0 // the current fruit in the collection (to be shown in the scene)

    let collectionKey = "collectionKey"
    let currentKey = "currentKey"

    // MARK: - NSCoding methods
    override init(){
        super.init()
        setup()
    }
    
    func setup(){ // init is automatically called when you make an instance of the FruitCollection
        collection.append(Fruit(fruitName: "apple", fruitImage: UIImage(named: "images/apple")!, likes: 0, disLikes: 0)!)
        collection.append(Fruit(fruitName: "orange", fruitImage: UIImage(named: "images/orange")!, likes: 0, disLikes: 0)!)
        collection.append(Fruit(fruitName: "watermelon", fruitImage: UIImage(named: "images/watermelon")!, likes: 0, disLikes: 0)!)
        collection.append(Fruit(fruitName: "dragonfruit", fruitImage: UIImage(named: "images/dragonfruit")!, likes: 0, disLikes: 0)!)

    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        collection = (decoder.decodeObject(forKey: collectionKey) as? [Fruit])!
        current = (decoder.decodeInteger(forKey: currentKey))
    }

    func encode(with acoder: NSCoder) {
        acoder.encode(collection, forKey: collectionKey)
        acoder.encode(current, forKey: currentKey)
    }

     // return the current fruit
     func currentFruit() -> Fruit {
        let fruit = collection[self.current]
        return fruit
     }
    
    func addFruit(fruit: Fruit) {
        collection.append(fruit)
    }
    
    func removeFruit() {
        if (self.current == self.collection.count - 1) {
            collection.remove(at: current)
            self.current = 0
        }
        else {
            collection.remove(at: current)
        }
    }
    
    func getIndex()-> Int {
        return self.current
    }
    
    func setIndex(index: Int) {
        current = index
    }
    
    func nextFruit() {
        current += 1
        if (self.current == self.collection.count) {
            current = 0
        }
    }
    
    func prevFruit() {
        current -= 1
        if (self.current < 0) {
            current = self.collection.count
        }
    }
    
    func fruitAmount()-> Int {
        return collection.count
    }
    
    func compareByName(fruitName: String) -> Int {
        var index = 0
        for currentFruit in collection {
            if (currentFruit.fruitName == fruitName) {
                return index
            }
            index += 1
        }
        return -1
    }
    
    // other helper functions you may need when relaunching the app
} // FruitCollection
