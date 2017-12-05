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
        let Burger: Item = Item(name: "Burger", type: "Food", quantity: 2, image: "camera", note: "This is your Burger", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Spaghetti: Item = Item(name: "Spaghetti", type: "Food", quantity: 1, image: "camera", note: "This is your Spaghetti", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Fish: Item = Item(name: "Fish", type: "Food", quantity: 3, image: "camera", note: "This is your Fish", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Paprika: Item = Item(name: "paprika", type: "Vegetable", quantity: 10, image: "camera", note: "This is your paprika", registDate: "2017/12/1", expiredDate: "2017/12/3")
        let Risole: Item = Item(name: "Risole", type: "Food", quantity: 5, image: "camera", note: "This is your Risole", registDate: "2017/12/1", expiredDate: "2017/12/3")
        
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
    
    var selectedItem: UIImage!
    var nameLbl: String = ""
    var noteLbl: String = ""
    var quantityLbl: String = ""
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = UIImage(named: discoverItem[indexPath.row].getImage())
        nameLbl = discoverItem[indexPath.row].getName()
        noteLbl = discoverItem[indexPath.row].getNote()
        quantityLbl = String(discoverItem[indexPath.row].getQuantity())
        
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let destination = segue.destination as! DetailDiscoverViewController
            destination.detailImageView!.image = selectedItem!
            destination.detailNameView.text = nameLbl
            destination.detailNoteView.text = noteLbl
            destination.detailQuantityView.text = quantityLbl
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
