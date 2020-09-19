//
//  StringExtension.swift
//  AhoyTemperatureMeter
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import Foundation

extension String {
    func convertedDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dateFromString = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: dateFromString)
    }
    
    func timeComponent() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dateFromString = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: dateFromString)
    }
    
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
