//
//  ReportModel.swift
//  iFinance
//
//  Created by ITA student on 9/23/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class ReportModel {
    private let model = TransferModel.transferModel
    var report: [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] = []
  
    init() {
        for transaction in model.getTransactionList() {
            let date = transaction.getInfo().actionDate
            let name = transaction.getInfo().actionName
            let value = transaction.getInfo().actionValue
            let category = transaction.getInfo().actionCategory
            let incomeType = transaction.getInfo().actionIsIncome
            report.append((name: name, date: date, value: value, category: category, isIncome: incomeType))
        }
    }    
    //MARK: Work with date
    func getRange(from: Date, to: Date) -> [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] {
        let result = report.filter({ $0.date >= from && $0.date <= to })
        return result
    }
    func getToday() -> [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] {
        if let dayProp = setDayStartEnd(Date()) { return getRange(from: dayProp.start, to: dayProp.end) }
        return getRange(from: setDaysBefore(0)!, to: setDayStartEnd(Date())!.end)
    }
    func getLastSevenDays() -> [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] {
        return getRange(from: setDaysBefore(7)!, to: Date())
    }
    func getLastThirtyDays() -> [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] {
        return getRange(from: setDaysBefore(30)!, to: Date())
    }
    func setDaysBefore(_ dayCount: Int) -> Date? {
        let calendar = Calendar.current
        if let daysBefore = calendar.date(byAdding: .day, value: -dayCount, to: Date()) {
            if let day = setDayStartEnd(daysBefore)?.start { return day }
        }
        return nil
    }
    private func setDayStartEnd(_ day: Date) -> (start: Date, end: Date)? {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        guard let dayStart: Date = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: day), let dayEnd: Date = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: day) else { return nil }
        return (dayStart, dayEnd)
    }
  
    func getTransactionByRange(from: Date, to: Date, categorySpecified: Category?) -> [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)] {
        if categorySpecified != nil {
            return getRange(from: from, to: from).filter({ $0.category == categorySpecified})
        }
        return getRange(from: from, to: from)
    }
    
    func prepareForChars(data: [(name: String, date: Date, value: Double, category: Category, isIncome: Bool)]) -> (names: [String], values: [Double]) {
        let result = data.filter({ $0.name != "" && $0.value != 0.0 && $0.category.getInfo().cName != ""})
        return (result.map({$0.name}), result.map({$0.value}))

    }
    
}
