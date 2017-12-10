//
//  DiscoverViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DiscoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var locationManager = CLLocationManager()
//    var loadingIndicator: LoadingIndicator!
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var discoverFlowLayout: UICollectionViewFlowLayout!
    
    var itemCoreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
    var discoverItem:[Item] = []
    func loadItems(){
        let dataStored = itemCoreData.getData()
        let dataStoredCount = dataStored.count
        
        for itemStored in dataStored{
            discoverItem.append(Item(item: itemStored))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverItem.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DiscoverCollectionViewCell
        
        cell.detailImageView.image = discoverItem[indexPath.row].getUIImage()
        
        if indexPath.row % 2 == 0 {
            let width = (self.discoverCollectionView.frame.width-15.0)/2.0
            let height = (self.discoverCollectionView.frame.width-15.0)/2.0
            cell.detailImageView.frame = CGRect(x: 5, y: 5, width: width , height: height)
            cell.background.frame = CGRect(x: 5, y: height - 65, width: width, height: 70)
            cell.itemName.frame = CGRect(x: 10, y: height - 60, width: width-5, height: 20)
            cell.itemNote.frame = CGRect(x: 10, y: height - 40, width: width-5, height: 40)
            cell.distance.frame = CGRect(x: width - 70 , y: 5, width: 75, height: 20)
        } else {
            let width = (self.discoverCollectionView.frame.width-15.0)/2.0
            let height = (self.discoverCollectionView.frame.width-15.0)/2.0
            cell.detailImageView.frame = CGRect(x: 2, y: 5, width: width, height: height)
            cell.background.frame = CGRect(x: 2, y: height - 65, width: width, height: 70)
            cell.itemName.frame = CGRect(x: 7, y: height - 60, width: width-5, height: 20)
            cell.itemNote.frame = CGRect(x: 7, y: height - 40, width: width-5, height: 40)
            cell.distance.frame = CGRect(x: width - 73 , y: 5, width: 75, height: 20)
        }
        
        cell.itemNote.lineBreakMode = .byWordWrapping
        cell.itemNote.numberOfLines = 3
        cell.itemName.text = discoverItem[indexPath.row].getName()
        cell.itemNote.text = discoverItem[indexPath.row].getNote()
        
        cell.background.layer.cornerRadius = 5
        cell.detailImageView.layer.cornerRadius = 5
        cell.distance.layer.cornerRadius = 5
        
        cell.detailImageView.clipsToBounds = true
        cell.background.clipsToBounds = true
        cell.distance.clipsToBounds = true
        
//        cell.distance = discoverItem[indexPath.row].getDistance()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    var selectedImage: UIImage!
    var nameLbl: String = ""
    var noteLbl: String = ""
    var quantityLbl: String = ""
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = discoverItem[indexPath.row].getUIImage()
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
    override func viewWillAppear(_ animated: Bool) {
        discoverItem.removeAll()
        loadItems()
        discoverCollectionView.reloadData()
    }
    override func viewDidLoad() {
        loadItems()
        super.viewDidLoad()
        
        
        setupNavigationBarItem()
        
        discoverFlowLayout.itemSize = CGSize(width: (self.discoverCollectionView.frame.width-1.0)/2.0, height: (self.discoverCollectionView.frame.width-5.0)/2.0)
    
        discoverCollectionView.reloadData()
        self.discoverCollectionView.delegate = self
        self.discoverCollectionView.dataSource = self
        
        
        ////////////Added by Alfian///////////
//        loadingIndicator = loadingIndicator(view: self.view)
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters   //higher accuracy will needs more resource such internet quota, battery
            locationManager.startMonitoringSignificantLocationChanges()
                        var latitude = locationManager.location?.coordinate.latitude
                        var longitude = locationManager.location?.coordinate.longitude
            //
                        print("\(String(describing: latitude)),\(String(describing: longitude))")
        }
        
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

