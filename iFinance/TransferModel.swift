//
//  TransferModel.swift
//  iFinance
//
//  Created by ITA student on 9/20/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class TransferModel {
    
    
    private var categoryStorage:        [Category]     = []
    private var transactionsStorage:    [Transaction]  = []
    private let fileManager                            = FileManager()
    
    private let categoriesPath:   String?
    private let transactionsPath: String?
    
    static let transferModel = TransferModel()
    
    
    private init(){
        //Prepare for Archiving data to files
        let documentDirectoryUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documentDirectoryUrl = documentDirectoryUrls.first {
            self.categoriesPath    = documentDirectoryUrl.appendingPathComponent("categories.archive").path
            self.transactionsPath  = documentDirectoryUrl.appendingPathComponent("transactions.archive").path
        } else {
            self.categoriesPath   = nil
            self.transactionsPath = nil
        }
        
    }
    
    //MARK: Categories functions
    
    func getCategoryList() -> [Category]{
        return categoryStorage
    }
    
    func addCategory(category: Category) {
        categoryStorage.append(category)
    }
    func addCategory(name: String, desctiption: String) {
        categoryStorage.append(Category(name: name, decription: desctiption))
    }
    
    
    
    //MARK: NSCoding for Category List
    func codeCategories(){
        if categoriesPath != nil {
            let success = NSKeyedArchiver.archiveRootObject(categoryStorage, toFile: categoriesPath!)
            if !success {
                print("Unable to save array to \(categoriesPath!)")
            } else {
                print("File not found")
            }
        }
        
    }
    
    func decodeCategories(){
        if categoriesPath != nil,
            let categoryList = NSKeyedUnarchiver.unarchiveObject(withFile: categoriesPath!) as? [Category]
        {
            categoryStorage = categoryList
        } else {
            print("File not found")
        }
        
    }
    
    //MARK: Transactions functions
    
    func getTransactionList() -> [Transaction] {
        return transactionsStorage
    }
    
    func addTransaction(name n: String, category c: Category, value v: Double, date d: Date, ddescription descript: String, isIncomeType type: Bool = false) {
        if type != false {
            transactionsStorage.append(Transaction(tCategory: c, tDate: d, tName: n, tDescription: descript, tValue: v, type: type))
        } else {
            transactionsStorage.append(Transaction(tCategory: c, tDate: d, tName: n, tDescription: descript, tValue: v))
        }
    }
    func addTransaction(transaction instance:Transaction) {
        transactionsStorage.append(instance)
    }
    
    
    //MARK: NSCoding for Transaction list
    func codeTransactions() {
        if transactionsPath != nil {
            let success = NSKeyedArchiver.archiveRootObject(transactionsStorage, toFile: transactionsPath!)
            if !success {
                print("Unable to save array to \(transactionsPath!)")
            } else {
                print("File not found")
            }
        }
    }
    
    func decodeTransactions() {
        if transactionsPath != nil, let transactionList = NSKeyedUnarchiver.unarchiveObject(withFile: transactionsPath!) as? [Transaction]{
            transactionsStorage = transactionList
        } else {
            print("File not found")
        }
    }
    
}
