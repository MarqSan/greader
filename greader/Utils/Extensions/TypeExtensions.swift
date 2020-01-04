//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

// MARK: CGFLOAT
extension CGFloat {
    
    func toInt() -> Int {
        return Int(self)
    }
}

// MARK: STRING
extension String {
    
    func toDate(inputFormat format: String = "dd/MM/yyyy HH:mm") -> Date? {
        let formattedString = self.replacingOccurrences(of: ".000Z", with: "")
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        
        guard let date = formatter.date(from: formattedString) else { return nil }
        
        return date
    }
}

// MARK: DATE
extension Date {
    
    var relativeTime: String {
        if yearsFromNow > 0 { return "\(yearsFromNow) \(yearsFromNow == 1 ? "ano" : "anos") atrás" }
        if monthsFromNow > 0 { return "\(monthsFromNow) \(monthsFromNow == 1 ? "mês" : "meses") atrás" }
        if weeksFromNow > 0 { return "\(weeksFromNow) \(weeksFromNow == 1 ? "semana" : "semanas") atrás" }
        if daysFromNow > 0 { return "\(daysFromNow) \(daysFromNow == 1 ? "dia" : "dias") atrás" }
        if hoursFromNow > 0 { return "\(hoursFromNow) \(hoursFromNow == 1 ? "hora" : "horas") atrás" }
        if minutesFromNow > 0 { return minutesFromNow == 1 ? "agora" : "\(minutesFromNow) minutos atrás" }
        
        return "agora"
    }
    
    fileprivate var yearsFromNow: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    fileprivate var monthsFromNow: Int {
        return Calendar.current.dateComponents([.month], from: self, to: Date()).month!
    }
    
    fileprivate var weeksFromNow: Int {
        return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear!
    }
    
    fileprivate var daysFromNow: Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day!
    }
    
    fileprivate var hoursFromNow: Int {
        return Calendar.current.dateComponents([.hour], from: self, to: Date()).hour!
    }
    
    fileprivate var minutesFromNow: Int {
        return Calendar.current.dateComponents([.minute], from: self, to: Date()).minute!
    }
}
