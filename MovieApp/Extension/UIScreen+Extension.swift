//
//  UIScreen+Extension.swift
//  Hagazt
//
//  Created by POMAC-IOS on 12/07/2023.
//

import Foundation
import UIKit
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UINavigationBar {
    static func changeAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }
}
extension Date {
    func equal(to date: Date) -> Bool {
        Calendar.current.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedSame && Calendar.current.compare(self, to: date, toGranularity: .month) == ComparisonResult.orderedSame && Calendar.current.compare(self, to: date, toGranularity: .year) == ComparisonResult.orderedSame
    }
    
    func toString(format: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .current
       // dateFormatter.locale = .init(identifier: LanguageHandler.currentLanguage().rawValue)
        return dateFormatter.string(from: self)
    }
    func toEnglishString(format: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .current
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    func toHijriFormate(format: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
    
        dateFormatter.calendar = Calendar(identifier: .islamic)
        let date = dateFormatter.string(from: format)
        print(date)
        return date
    }
    func toHijiriNumber(format: DateFormate)-> String{
//           let dateFormatter = DateFormatter()
//                dateFormatter.locale = .init(identifier: "en_US_POSIX")
//                dateFormatter.calendar = Calendar(identifier: .islamic)
//                let islamic = NSCalendar(identifier: NSCalendar.Identifier.islamicUmmAlQura)
//                var components = islamic?.components(NSCalendar.Unit(rawValue: UInt.max), from: format)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = .init(identifier: LanguageHandler.currentLanguage().rawValue)
        dateFormatter.calendar = Calendar(identifier: .islamic)
        let date = dateFormatter.string(from: self)
        print(date)
        return date
    }
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        let locale = Locale.init(identifier: LanguageHandler.currentLanguage().rawValue)
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: locale)
    }
    func getNextDay(date : Date) -> Date?{
        return Calendar.current.date(byAdding: .day, value: 1, to: date)
    }
    
    func getPreviousDay(date : Date) -> Date?{
        return Calendar.current.date(byAdding: .day, value: -1, to: date)
    }
    
    func remainingDays(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        if secondsAgo < minute {
            return "Just Now".localized
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)"+" min ago".localized
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)"+" hrs ago".localized
        } else if secondsAgo < week {
            return "\(secondsAgo / day)"+" days ago".localized
        }
        return "\(secondsAgo / week)"+" weeks ago".localized
    }
    
//    func DateWithToday() -> String {
//        let secondsAgo = Int(Date().timeIntervalSince(self))
//        let minute = 60
//        let hour = 60 * minute
//        let day = 24 * hour
//        let week = 7 * day
//        if secondsAgo < minute || secondsAgo < hour{
//            return "Today".localized
//        }
//        return self.toString(format: .dayMonthYearwithSlech)
//    }
    func DateWithToday() -> String {
                let secondsAgo = Int(Date().timeIntervalSince(self))
                let minute = 60
                let hour = 60 * minute
                let day = 24 * hour
                let week = 7 * day
                if secondsAgo < minute || secondsAgo < hour{
                    return "Today".localized
                }
        // Check if the date is today
        if Calendar.current.isDateInToday(self) {
                    return "Today".localized
                }
                
                // Check if the date is yesterday
        if Calendar.current.isDateInYesterday(self) {
                    return "Yesterday".localized
                }
        else if secondsAgo < week {
                        let days = secondsAgo / day
            return "\(days) \(days == 1 ? "day".localized : "days".localized) " + "ago".localized
                    }
                return self.toString(format: .dayMonthYearwithSlech)
            }
}
