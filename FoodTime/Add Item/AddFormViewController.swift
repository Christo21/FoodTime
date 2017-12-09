//
//  AddFormViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class AddFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let itemData: itemDataList = itemDataList()
    var itemDataLists: [itemDataList.itemData] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ITEM COUNT IS \(itemDataLists.count)")
        return itemDataLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListView.dequeueReusableCell(withIdentifier: "detailItemCell", for: indexPath) as! AddViewCell
        cell.nameLabel.text = itemDataLists[indexPath.row].getName()
        cell.expLabel.text = "Expiration date: +\(itemDataLists[indexPath.row].getExpiredDays()) days"
        
        return cell
    }
    
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    var itemCoreData: CoreDataClass = CoreDataClass(entity: "ItemModel")
    
    
    @IBOutlet weak var ListView: UITableView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var qtyPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var photo: UIButton!
    @IBAction func minimize(_ sender: UIButton) {
        ListView.isHidden = true
        minimizeButton.isHidden = true
    }
    @IBOutlet weak var minimizeButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    var numberData: [Int] = []
    var unitData: [String] = ["ons", "gram", "kg", "liter(s)", "piece(s)", "bottle(s)", "bag(s)", "can(s)", "jar(s)", "bundle(s)", "glass(es)"]
    var placeholderLabel: UILabel!
    
    @IBAction func photoButtonDidTap(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        ListView.isHidden = true
        minimizeButton.isHidden = true
        itemDataLists = itemData.getItemDataList()
        print("ITEM COUNT IS \(itemDataLists.count)")
        super.viewDidLoad()
        
        ListView.reloadData()
        self.ListView.delegate = self
        self.ListView.dataSource = self
        
        for i in 1...100 {
            numberData.append(i)
        }
        
        qtyPicker.dataSource = self
        qtyPicker.delegate = self
        
        nameField.delegate = self
        priceField.delegate = self
        notesView.delegate = self
        
        notesView.layer.borderWidth = 1
        notesView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        notesView.layer.cornerRadius = 8
        
        setDate()
        nameField.addTarget(self, action: #selector(showList), for: UIControlEvents.touchDown)
        nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func showList() {
        ListView.isHidden = false
        minimizeButton.isHidden = false
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            itemDataLists = itemData.getItemDataList()
            self.ListView.reloadData()
        } else {
            itemDataLists = itemDataLists.filter({ $0.getName().lowercased().contains(textField.text!.lowercased())})
            self.ListView.reloadData()
        }
    }
    
    //setting date style
    func setDate() {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        self.datePicker.minimumDate = minDate as Date
    }
    
    @IBAction func saving(_ sender: UIBarButtonItem) {
        let alert: UIAlertController!
        
        if self.validating() {
            alert = UIAlertController(title: "Successfull", message: "Your item has added to your list", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                _ = self.navigationController?.popToRootViewController(animated: false)
            }))
        } else {
            alert = UIAlertController(title: "Warning", message: "Fill the item name or price or picture", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func validating() -> Bool{
        let name: String = nameField.text!
        let price: String = priceField.text!
        let qty: String = String(qtyPicker.selectedRow(inComponent: 0)) + String(qtyPicker.selectedRow(inComponent: 1))
        var note: String = ""
        var picture: String = ""
        
        var valid: Bool = true
        
        if name == "" {
            nameField.text = nil
            nameField.attributedPlaceholder = NSAttributedString(string:"fill the item name", attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 0.75)])
            valid = false
        }
        if name.count > 30{
            nameField.text = nil
            nameField.attributedPlaceholder = NSAttributedString(string:"max 30 characters",attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 0.75)])
            valid = false
        }
        if price == ""{
            priceField.text = nil
            priceField.attributedPlaceholder = NSAttributedString(string:"fill the price", attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 0.75)])
            valid = false
        }
        if photo.currentImage == #imageLiteral(resourceName: "camera") && valid{
            valid = false
            let alert = UIAlertController(title: "Warning", message: "Please take your item's picture", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let imageData:NSData = UIImagePNGRepresentation(photo.currentImage!)! as NSData as NSData
            picture = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        if notesView.text != nil{
            note = notesView.text!
        }
        
        if !valid {
            return false
        } else {
            let item = Item(name: name, quantity: Int(qty)!, image: picture, price: Int(price)!, note: note, registDate: Date(), expiredDate: datePicker.date) //JANGAN LUPA GANTI EXP DATE
            
            delegate?.scheduleNotification(item)
            
            print("item yang disimpan \(item.getName()) \(item.getExipredDate()) \(item.getRegistDate())")
            itemCoreData.saveData(object: item)
        }
        return true
        
    }
    
    //ngambil gambar
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var choosenImage = UIImage()
        choosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photo.contentMode = .scaleAspectFit
        photo.setImage(choosenImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numberData.count
        } else if component == 1 {
            return unitData.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(numberData[row])
        } else if component == 1 {
            return unitData[row]
        }
        return ""
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            priceField.becomeFirstResponder()
        } else {
            self.becomeFirstResponder()
        }
        return false
    }
    
    //buat naikin layar pas mau ngetik
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.priceField {
            animation(y: -80)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == self.priceField {
            animation(y: 80)
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.notesView {
            animation(y: -100)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.notesView {
            animation(y: 100)
        }
    }
    
    func animation(y: CGFloat) {
        UIView .beginAnimations(nil, context: nil)
        UIView .setAnimationDelegate(self)
        UIView .setAnimationDuration(0.5)
        UIView .setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRect(x: self.view.frame.origin.x, y: (self.view.frame.origin.y + y), width: self.view.frame.size.width, height: self.view.frame.size.height)
        UIView .commitAnimations()
    }
    
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
}

