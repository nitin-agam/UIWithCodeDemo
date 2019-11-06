//
//  ExtendedDate.swift
//  Do it
//
//  Created by Nitin A on 26/11/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import Foundation

extension Date {
    
    
    // MARK: - Class Methods
    static func kCurrentCalendar() -> Calendar {
        return Calendar.current
    }
    
    static var kTimeZone: TimeZone {
        return Date.kCurrentCalendar().timeZone
    }
    
    // Use this method when want to perform operation on given date
    static func kDateByAdding(_ component: Calendar.Component, value: Int, inDate date: Date) -> Date {
        switch component {
        case .second:
            return Date.kCurrentCalendar().date(byAdding: .second, value: value, to: date) ?? date
            
        case .minute:
            return Date.kCurrentCalendar().date(byAdding: .minute, value: value, to: date) ?? date
            
        case .hour:
            return Date.kCurrentCalendar().date(byAdding: .hour, value: value, to: date) ?? date
            
        case .day:
            return Date.kCurrentCalendar().date(byAdding: .day, value: value, to: date) ?? date
            
        case .weekOfYear, .weekOfMonth:
            return Date.kCurrentCalendar().date(byAdding: .day, value: value * 7, to: date) ?? date
            
        case .month:
            return Date.kCurrentCalendar().date(byAdding: .month, value: value, to: date) ?? date
            
        case .year:
            return Date.kCurrentCalendar().date(byAdding: .year, value: value, to: date) ?? date
            
        default:
            return date
        }
    }
    
    
    // MARK: - Computed Varibles
    var kYear: Int {
        return Date.kCurrentCalendar().component(.year, from: self)
    }
    
    var kMonth: Int {
        return Date.kCurrentCalendar().component(.month, from: self)
    }
    
    var kWeekOfYear: Int {
        return Date.kCurrentCalendar().component(.weekOfYear, from: self)
    }
    
    var kWeekOfMonth: Int {
        return Date.kCurrentCalendar().component(.weekOfMonth, from: self)
    }
    
    var kWeekday: Int {
        return Date.kCurrentCalendar().component(.weekday, from: self)
    }
    
    var kDay: Int {
        return Date.kCurrentCalendar().component(.day, from: self)
    }
    
    var kHour: Int {
        return Date.kCurrentCalendar().component(.hour, from: self)
    }
    
    var kMinute: Int {
        return Date.kCurrentCalendar().component(.minute, from: self)
    }
    
    var kSecond: Int {
        return Date.kCurrentCalendar().component(.second, from: self)
    }
    
    var kNanosecond: Int {
        return Date.kCurrentCalendar().component(.nanosecond, from: self)
    }
    
    var kFutureDate: Bool {
        return self > Date()
    }
    
    var kPastDate: Bool {
        return self < Date()
    }
    
    var kToday: Bool {
        return self.kDay == Date().kDay && self.kMonth == Date().kMonth && self.kYear == Date().kYear
    }
    
    var kUnixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    
    
    // MARK: - Instance Methods
    
    // Use this method when want to perform operation on current date
    func kDateByAdding(_ component: Calendar.Component, value: Int) -> Date {
        return Date.kDateByAdding(component, value: value, inDate: self)
    }
    
    func kDateTomorrow() -> Date {
        return self.kDateByAdding(.day, value: 1)
    }
    
    func kDateYesterday() -> Date {
        return self.kDateByAdding(.day, value: -1)
    }
    
    func kDateAfterHours(_ hours: NSInteger) -> Date {
        return self.kDateByAdding(.hour, value: hours)
    }
    
    func kDateBeforeHours(_ hours: NSInteger) -> Date {
        return self.kDateByAdding(.hour, value: -hours)
    }
    
    func kDateAfterMinutes(_ minutes: NSInteger) -> Date {
        return self.kDateByAdding(.minute, value: minutes)
    }
    
    func kDateBeforeMinutes(_ minutes: NSInteger) -> Date {
        return self.kDateByAdding(.minute, value: -minutes)
    }
    
    func kDateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func kDateTimeInString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func kDateInString(inFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func kIsWeekend() -> Bool {
        let components = Date.kCurrentCalendar().dateComponents([.weekday], from: self)
        return (components.weekday == 1 || components.weekday == 7) // 1 - Sunday; 7 - Saturday
    }
    
    func kIsWorkday() -> Bool {
        return !self.kIsWeekend()
    }
    
    func kMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

