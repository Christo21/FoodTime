//
//  AddFormViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class AddFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var qtyPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var photo: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    var numberData: [Int] = []
    var unitData: [String] = ["ons", "gram", "kg", "liter(s)", "piece(s)", "bottle(s)", "bag(s)", "can(s)", "jar(s)", "bundle(s)", "glass(es)"]
    
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
        
        qtyPicker.dataSource = self
        qtyPicker.delegate = self
        
        nameField.delegate = self
        priceField.delegate = self
        notesView.delegate = self
        
        notesView.layer.borderWidth = 1
        notesView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        notesView.layer.cornerRadius = 8
        
        setDate()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveItem))
    }
    
    func setDate() {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        self.datePicker.minimumDate = minDate as Date
    }
    
    var alert = UIAlertController()
    @objc func saveItem(sender: UIBarButtonItem){
        if validating() {
            let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                _ = self.navigationController?.popToRootViewController(animated: false)
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
        
    }
    var placeholderLabel: UILabel!
    
    func validating() -> Bool{
        let name: String = nameField.text!
        let price: String = priceField.text!
        
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
        if photo.currentImage == nil{
            valid = false
        } else {
            let imageData:NSData = UIImagePNGRepresentation(photo.currentImage!)! as NSData as NSData
            let picture: String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            print(picture)
        }
        
        if !valid {
            return false
        } else {
            
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
            animation(y: -80)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.notesView {
            animation(y: 80)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

