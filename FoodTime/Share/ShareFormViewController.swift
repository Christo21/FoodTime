//
//  ShareFormViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 08/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class ShareFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var shareItemCoreData: CoreDataClass = CoreDataClass(entity: "ShareItemModel")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var qtyToPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var photo: UIButton!
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    var imagePicker: UIImagePickerController!
    
    var numberData: [Int] = []
    var unitData: [String] = ["ons", "gram", "kg", "liter(s)", "piece(s)", "bottle(s)", "bag(s)", "can(s)", "jar(s)", "bundle(s)", "glass(es)"]
    
    var shareName: String = ""
    var shareDate: Date = Date()
    
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
        
        super.viewDidLoad()
        
        for i in 1...100 {
            numberData.append(i)
        }
        
        qtyToPicker.dataSource = self
        qtyToPicker.delegate = self
        
        nameField.delegate = self
        notesView.delegate = self
        nameField.textAlignment = .center
        notesView.layer.borderWidth = 1
        notesView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        notesView.layer.cornerRadius = 8
        
        nameField.text = shareName
        datePicker.date = shareDate
        
        setDate()
        setupNavigationBarItem()
    }
    
    func setDate() {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        self.datePicker.minimumDate = minDate as Date
    }
    
    var alert = UIAlertController()
    
    @IBAction func sharing(_ sender: UIBarButtonItem) {
        let alert: UIAlertController!
        if self.validating() {
            alert = UIAlertController(title: "Successfull", message: "Your item has added to your list", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                
            }))
        } else {
            alert = UIAlertController(title: "Warning", message: "Fill the item name or picture or notes", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    var placeholderLabel: UILabel!
    
    func validating() -> Bool{
        let name: String = nameField.text!
        let qtyToShare: String = String(qtyToPicker.selectedRow(inComponent: 0)) + String(qtyToPicker.selectedRow(inComponent: 1))
        let qtyToClaim: String = String(qtyToPicker.selectedRow(inComponent: 2))
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
        if photo.currentImage == #imageLiteral(resourceName: "camera"){
            valid = false
        } else {
            let imageData:NSData = UIImagePNGRepresentation(photo.currentImage!)! as NSData as NSData
            picture = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        if notesView.text == ""{
            valid = false
        } else {
            note = notesView.text!
        }
        
        if !valid {
            return false
        } else {
            
            let item = Share(quantityToShare: Int(qtyToShare)!, quantityToClaim: Int(qtyToClaim)!, name: name, quantity: 0, image: picture, price: 0, note: note, registDate: Date(), expiredDate: datePicker.date)
            print(item)
            shareItemCoreData.saveData(object: item)
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
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 || component == 2 {
            return numberData.count
        } else if component == 1 {
            return unitData.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 || component == 2 {
            return String(numberData[row])
        } else if component == 1 {
            return unitData[row]
        }
        return ""
    }
    public func setupNavigationBarItem(){
        //kiri
        let leftButton = UIButton(type: .system)
        leftButton.setImage(#imageLiteral(resourceName: "mail").withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        leftButton.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.notesView {
            animation(y: -200)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.notesView {
            animation(y: 200)
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
}

