//
//  CreateEditTransactionViewController.swift
//  iFinance
//
//  Created by ITA student on 9/17/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import UIKit

class CreateEditTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var nameTextField:       UITextField!
    @IBOutlet weak var categoryTextField:   UITextField!
    @IBOutlet weak var valueTextField:      UITextField!
    @IBOutlet weak var descriptionTextArea: UITextView!
    @IBOutlet weak var dateDataPicker:      UIDatePicker!
    
    let model = TransferModel.transferModel
    var record: Transaction?
    var recordCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transaction"
        
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        self.categoryTextField.inputAccessoryView = categoryPicker
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.saveTransaction))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.getCategoryList().count //categoryStorege.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.getCategoryList()[row].getName() //categoryStorege[row].getName()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = model.getCategoryList()[row].getName() //categoryStorege[row].getName()
        recordCategory = model.getCategoryList()[row] //categoryStorege[row]
    }
    
    @objc func saveTransaction() {
        if let name = nameTextField.text, let value = valueTextField.text {
        record = Transaction(tCategory: recordCategory!, tDate: dateDataPicker.date, tName: name, tDescription: descriptionTextArea.text, tValue: Double(value)!)
            
            model.addTransaction(transaction: record!)
            //transactionHistory.append(record!)
            model.codeTransactions()
        }
    
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    
}