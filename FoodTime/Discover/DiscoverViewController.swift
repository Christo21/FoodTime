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
    
    var discoverItem:[Item] = []
    func loadItems(){
        let Burger: Item = Item(name: "Burger", quantity: 2, image: "camera", price: 20000, note: "This is your Burger", registDate: Date(timeIntervalSinceNow: 0), expiredDate: Date(timeIntervalSinceNow: 60))
        
        var items: [Item] = []
        items.append(Burger)
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

