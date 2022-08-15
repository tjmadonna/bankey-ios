//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by Tyler Madonna on 8/14/22.
//

import Foundation

extension Decimal {

    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }

}
