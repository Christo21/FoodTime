//
//  ProfileViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(shareItem.count)
        return shareItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: "itemDetailCell", for: indexPath) as! ProfileViewCell
        
        cell.detailImage.image = self.shareItem[indexPath.row].getUIImage()
        
        if indexPath.row % 2 == 0 {
            let width = (self.profileCollectionView.frame.width-15.0)/2.0
            let height = (self.profileCollectionView.frame.width-15.0)/2.0
            cell.detailImage.frame = CGRect(x: 5, y: 5, width: width , height: height)
            cell.background.frame = CGRect(x: 5, y: height - 65, width: width, height: 70)
            cell.itemName.frame = CGRect(x: 10, y: height - 60, width: width-5, height: 20)
            cell.itemNote.frame = CGRect(x: 10, y: height - 40, width: width-5, height: 40)
            cell.distance.frame = CGRect(x: width - 70 , y: 5, width: 75, height: 20)
        } else {
            let width = (self.profileCollectionView.frame.width-15.0)/2.0
            let height = (self.profileCollectionView.frame.width-15.0)/2.0
            
            cell.detailImage.frame = CGRect(x: 2, y: 5, width: width, height: height)
            cell.background.frame = CGRect(x: 2, y: height - 65, width: width, height: 70)
            cell.itemName.frame = CGRect(x: 7, y: height - 60, width: width-5, height: 20)
            cell.itemNote.frame = CGRect(x: 7, y: height - 40, width: width-5, height: 40)
            cell.distance.frame = CGRect(x: width - 73 , y: 5, width: 75, height: 20)
        }
        
        cell.itemNote.lineBreakMode = .byWordWrapping
        cell.itemNote.numberOfLines = 3
        cell.itemName.text = shareItem[indexPath.row].getName()
        cell.itemNote.text = shareItem[indexPath.row].getNote()
        
        cell.background.layer.cornerRadius = 5
        cell.detailImage.layer.cornerRadius = 5
        cell.distance.layer.cornerRadius = 5
        
        cell.detailImage.clipsToBounds = true
        cell.background.clipsToBounds = true
        cell.distance.clipsToBounds = true
        
        return cell
    }
    
    var selectedImage: UIImage!
    var nameLbl: String = ""
    var noteLbl: String = ""
    var quantityLbl: String = ""

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = shareItem[indexPath.row].getUIImage()
        nameLbl = shareItem[indexPath.row].getName()
        noteLbl = shareItem[indexPath.row].getNote()
        quantityLbl = String(shareItem[indexPath.row].getQuantity())

        self.performSegue(withIdentifier: "showSharedDetail", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSharedDetail"{
            let destination = segue.destination as! DetailDiscoverViewController
            destination.image = selectedImage
            destination.name = nameLbl
            destination.note = noteLbl
            destination.quantity = quantityLbl
            destination.hiddenButton = true
        }
    }
    
    @IBAction func buttonEditProfile(_ sender: Any) {
        performSegue(withIdentifier: "editProfile", sender: self)
    }
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imageViewProfile : UIImageView!
    @IBAction func buttonEditPhotoProfile(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a sorce", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not Available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profileFlowLayout: UICollectionViewFlowLayout!
    
    var shareItem: [Item] = []
    var itemCoreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
    
    override func viewDidLoad() {
        loadItems()
        super.viewDidLoad()
        scrollView.contentSize.height = 1000
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.layer.borderWidth = 3
        imageViewProfile.layer.borderColor = UIColor.darkGray.cgColor
        imageViewProfile.clipsToBounds = true
        
        profileFlowLayout.itemSize = CGSize(width: (self.profileCollectionView.frame.width-2.0)/2.0, height: (self.profileCollectionView.frame.width-2.0)/2.0)
        profileCollectionView.reloadData()
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        setupNavigationBarItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        shareItem.removeAll()
        loadItems()
        profileCollectionView.reloadData()
    }
    func loadItems(){
        let dataStored = itemCoreData.getData()
        let dataStoredCount = dataStored.count
        
        for itemStored in dataStored{
            shareItem.append(Item(item: itemStored))
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageViewProfile.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
