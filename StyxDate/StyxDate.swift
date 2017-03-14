//
//  StyxDate.swift
//
//  Created by 刘奥明 on 16/7/11.
//  Copyright © 2016年 mobile263. All rights reserved.
//  日期扩展类

import Foundation

extension String {
    /**
     字符串日期格式转换
     
     - parameter inputFormat:  输入格式字符串
     - parameter outputFormat: 输出格式字符串
     
     - returns: 转换后的字符串
     */
    func formatConversion(_ inputFormat: String, outputFormat: String) -> String? {
        let fmt = DateFormatter()
        fmt.dateFormat = inputFormat
        let date = fmt.date(from: self)
        fmt.dateFormat = outputFormat
        if date == nil {
            return nil
        }
        return fmt.string(from: date!)
    }
    
    /**
     根据字符串返回NSDate
     
     - parameter format: 日期格式字符串
     
     - returns: Date
     */
    func date(_ format: String) -> Date? {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        return fmt.date(from: self)
    }
}

extension Int {
    var years: DateComponents { return DateComponents(year: self) }
    var months: DateComponents { return DateComponents(month: self) }
    var days: DateComponents { return DateComponents(day: self) }
    var weeks: DateComponents { return DateComponents(day: 7*self) }
    var hours: DateComponents { return DateComponents(hour: self) }
    var minuts: DateComponents { return DateComponents(minute: self) }
    var seconds: DateComponents { return DateComponents(second: self) }
    var nanosecond: DateComponents { return DateComponents(nanosecond: self)}
}

extension Date {
    
    var year: Int { return dateComponents.year! }
    var years: Int { return year }
    var month: Int { return dateComponents.month! }
    var months: Int { return month }
    var day: Int { return dateComponents.day! }
    var days: Int { return day }
    var hour: Int { return dateComponents.hour! }
    var hours: Int { return hour }
    var minute: Int { return dateComponents.minute! }
    var minutes: Int { return minute }
    var second: Int { return dateComponents.second! }
    var seconds: Int { return second }
    var nanosecond: Int { return dateComponents.nanosecond! }
    var nanoseconds: Int { return nanosecond }
    var weekday: Int { return dateComponents.weekday! }
    var weekdays: Int { return weekday }
    
    var calendar: Calendar { return .current }
    var dateComponents: DateComponents { return calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: self) }
    
    
    init(year: Int, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let now = Date()
        var dateComponents = Calendar.current.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: now)
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        let date = Calendar.current.date(from: dateComponents)
        self.init(timeInterval: 0, since: date!)
    }
    
    static func today() -> Date {
        let now = Date()
        return Date(year: now.year, month: now.month, day: now.day)
    }
    
    static func yesterday() -> Date {
        return (today() - 1.days)!
    }
    
    static func tomorrow() -> Date {
        return (today() + 1.days)!
    }
    
    static func + (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: right, to: left)
    }
    
    static func - (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: -right, to: left)
    }
    
    func changed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) -> Date? {
        var dateComponents = self.dateComponents
        dateComponents.year = year ?? self.year
        dateComponents.month = month ?? self.month
        dateComponents.day = day ?? self.day
        dateComponents.hour = hour ?? self.hour
        dateComponents.minute = minute ?? self.minute
        dateComponents.second = second ?? self.second
        dateComponents.nanosecond = nanosecond ?? self.nanosecond
        
        return calendar.date(from: dateComponents)
    }
    
    func string(inDateStyle dateStyle: DateFormatter.Style, andTimeStyle timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = dateStyle
        
        return dateFormatter.string(from: self)
    }
    
    func dateString(in dateStyle: DateFormatter.Style) -> String {
        return string(inDateStyle: dateStyle, andTimeStyle: .none)
    }
    
    func timeString(in timeStyle: DateFormatter.Style) -> String {
        return string(inDateStyle: .none, andTimeStyle: timeStyle)
    }
    
    
    /**
     根据Date返回字符串
     
     - parameter formaterString: 日期格式字符串
     
     - returns: 字符串
     */
    func string(_ formaterString: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = formaterString
        
        return fmt.string(from: self)
    }
}



extension DateComponents {
    
    var ago: Date? { return Calendar.current.date(byAdding: -self, to: Date()) }
    var later: Date? { return Calendar.current.date(byAdding: self, to: Date()) }
    
    /// 取负
    static prefix func -(rhs: DateComponents) -> DateComponents {
        var dateComponents = DateComponents()
        
        if let year = rhs.year {
            dateComponents.year = -year
        }
        
        if let month = rhs.month {
            dateComponents.month = -month
        }
        
        if let day = rhs.day {
            dateComponents.day = -day
        }
        
        if let hour = rhs.hour {
            dateComponents.hour = -hour
        }
        
        if let minute = rhs.minute {
            dateComponents.minute = -minute
        }
        
        if let second = rhs.second {
            dateComponents.second = -second
        }
        
        if let nanosecond = rhs.nanosecond {
            dateComponents.nanosecond = -nanosecond
        }
        
        return dateComponents
    }
    
    /// 相加
    static func + (left: DateComponents, right: DateComponents) -> DateComponents {
        var dateComponents = left
        
        if let year = right.year {
            dateComponents.year = (dateComponents.year ?? 0) + year
        }
        
        if let month = right.month {
            dateComponents.month = (dateComponents.month ?? 0) + month
        }
        
        if let day = right.day {
            dateComponents.day = (dateComponents.day ?? 0) + day
        }
        
        if let hour = right.hour {
            dateComponents.hour = (dateComponents.hour ?? 0) + hour
        }
        
        if let minute = right.minute {
            dateComponents.minute = (dateComponents.minute ?? 0) + minute
        }
        
        if let second = right.second {
            dateComponents.second = (dateComponents.second ?? 0) + second
        }
        
        if let nanosecond = right.nanosecond {
            dateComponents.nanosecond = ( dateComponents.nanosecond ?? 0) + nanosecond
        }
        
        return dateComponents
    }
    
    /// 相减
    static func - (left: DateComponents, right: DateComponents) -> DateComponents {
        return left + (-right)
    }
    
    public func string(in unitsStyle: DateComponentsFormatter.UnitsStyle) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = unitsStyle
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second, .nanosecond]
        
        return dateComponentsFormatter.string(from: self)
    }
}
