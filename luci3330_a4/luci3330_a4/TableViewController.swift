//
//  TableViewController.swift
//  luci3330_a3
//
//  Created by Stefan Lucic on 2020-02-29.
//  Copyright © 2020 wlu. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
import os.log

let simpleTableIdentifier = "reuseIdentifier"
var sharedFruitCollection : FruitCollection?

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    @IBOutlet weak var numDislikesLabel: UILabel!
}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var FruitTableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var tableData : [Fruit]?
    var filteredData : [Fruit]?
    
    let segueID = "detailViewSegue"
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        _ = SharingFruitCollection()
        SharingFruitCollection.sharedFruitCollection.fruitCollection = FruitCollection()
        SharingFruitCollection.sharedFruitCollection.loadFruitCollection()
        sharedFruitCollection = SharingFruitCollection.sharedFruitCollection.fruitCollection
        
        sharedFruitCollection?.setIndex(index: 0)
        tableData = sharedFruitCollection?.collection
        
        searchBar.delegate = self
        FruitTableView.delegate = self
        FruitTableView.dataSource = self
        
        filteredData = sharedFruitCollection?.collection
        FruitTableView.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableData = sharedFruitCollection?.collection
        filteredData = sharedFruitCollection?.collection
        FruitTableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchBar, searchText)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let searchText = searchBar.text!
        search(searchBar, searchText)
        
    }
    
    func search(_ searchBar: UISearchBar, _ searchText: String) {
        print("searching...")
        filteredData = tableData?.filter({ fruit -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                print(searchBar.selectedScopeButtonIndex)

                if searchText.isEmpty {
                    FruitTableView.reloadData()
                    return true
                    
                }
                FruitTableView.reloadData()
                return fruit.returnFruitName().localizedCaseInsensitiveContains(searchText)
                
            case 1:
                print(searchBar.selectedScopeButtonIndex)

                if searchText.isEmpty {
                    FruitTableView.reloadData()
                    return fruit.numLikes() > 0
                    
                }
                FruitTableView.reloadData()
                return fruit.returnFruitName().localizedCaseInsensitiveContains(searchText) && fruit.numLikes() > 0
                
            case 2:
                print(searchBar.selectedScopeButtonIndex)

                if searchText.isEmpty {
                    
                    FruitTableView.reloadData()
                    return fruit.numDislikes() > 0
                    
                }
                FruitTableView.reloadData()
                return fruit.returnFruitName().localizedCaseInsensitiveContains(searchText) && fruit.numDislikes() > 0
                
            default:
                return false
            }
            
        })
        FruitTableView.reloadData()
    }
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as? CustomCell
        if (cell == nil) {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: simpleTableIdentifier) as CustomCell
            
        } // the cell has an image property, set it
        //let fruit = sharedFruitCollection?.collection[indexPath.row]
        cell?.fruitImage?.image = (filteredData![indexPath.row]).returnFruitImage()
        cell?.fruitLabel?.text = filteredData![indexPath.row].returnFruitName()
        cell?.numLikesLabel.text = String((filteredData![indexPath.row].numLikes()))
        cell?.numDislikesLabel.text = String((filteredData![indexPath.row].numDislikes()))
        return cell!
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            let _ = filteredData!.remove(at: indexPath.row)
            let _ = sharedFruitCollection?.collection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            tableView.endUpdates()
            tableView.reloadData()
            
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.tableData?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
        
    }
    */
    @IBAction func unwindToTableView(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddFruitViewController{

            let fruit = sourceViewController.getFruit()
            let newIndexPath = IndexPath(row: sharedFruitCollection!.fruitAmount(), section: 0)
            filteredData?.append(fruit)
            sharedFruitCollection?.addFruit(fruit: fruit)
            FruitTableView.insertRows(at: [newIndexPath], with: .automatic)
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
        tableView.deselectRow(at: indexPath, animated: true)
        
        sharedFruitCollection?.setIndex(index: indexPath.row)
        performSegue(withIdentifier: segueID, sender: sharedFruitCollection?.currentFruit())
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: <#T##Any?#>)
        
        if segue.identifier == segueID {
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.initWithData(sender as! Fruit)
        }
    }
 
 
    
    
}
