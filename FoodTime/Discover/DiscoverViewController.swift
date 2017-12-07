//
//  DiscoverViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var discoverFlowLayout: UICollectionViewFlowLayout!
    
    var discoverItem:[Item] = []
    func loadItems(){
        let Burger: Item = Item(idItem: "1", name: "Burger", type: "Food", quantity: 2, image: "camera", price: 20000, note: "This is your Burger", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 60))
        let Spaghetti: Item = Item(idItem: "2", name: "Spaghetti", type: "Food", quantity: 1, image: "camera", price: 30000, note: "This is your Spaghetti", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 120))
        let Fish: Item = Item(idItem: "3", name: "Fish", type: "Food", quantity: 3, image: "camera", price: 40000, note: "This is your Fish", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 180))
        let Paprika: Item = Item(idItem: "4", name: "paprika", type: "Vegetable", quantity: 10, image: "camera", price: 50000, note: "This is your paprika", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 240))
        let Risole: Item = Item(idItem: "5", name: "Risole", type: "Food", quantity: 5, image: "camera", price: 60000, note: "This is your Risole", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 300))
        
        var items: [Item] = []
        items.append(Burger)
        items.append(Spaghetti)
        items.append(Fish)
        items.append(Paprika)
        items.append(Risole)
        discoverItem = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DiscoverCollectionViewCell
        cell.detailImageView.image = UIImage(named: discoverItem[indexPath.row].getImage())
        return cell
    }
    
    var selectedImage: String = ""
    var nameLbl: String = ""
    var noteLbl: String = ""
    var quantityLbl: String = ""
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = discoverItem[indexPath.row].getImage()
        nameLbl = discoverItem[indexPath.row].getName()
        noteLbl = discoverItem[indexPath.row].getNote()
        quantityLbl = String(discoverItem[indexPath.row].getQuantity())
        
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let destination = segue.destination as! DetailDiscoverViewController
            destination.image = selectedImage
            destination.name = nameLbl
            destination.note = noteLbl
            destination.quantity = quantityLbl
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
        
        discoverFlowLayout.itemSize = CGSize(width: (self.discoverCollectionView.frame.width-2.0)/2.0, height: (self.discoverCollectionView.frame.width-2.0)/2.0)
        
        loadItems()
        discoverCollectionView.reloadData()
        self.discoverCollectionView.delegate = self
        self.discoverCollectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func setupNavigationBarItem(){
        //kiri
        let leftButton = UIButton(type: .system)
        leftButton.setImage(#imageLiteral(resourceName: "mail").withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        leftButton.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
}

