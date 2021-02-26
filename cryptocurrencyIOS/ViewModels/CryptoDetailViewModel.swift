//
//  CryptoDetailViewModel.swift
//  cryptocurrencyIOS
//
//  Created by Alan Soares de Oliveira on 26/02/21.
//

import Foundation

enum CryptoDetailOption: Int, CaseIterable {
    case onehour
    case threedays
    case oneweak
    case onemonth
    case threemonths
    
    var description: String {
        switch self {
        case .onehour: return "1 hr"
        case .threedays: return "3 Days"
        case .oneweak: return "1 Week"
        case .onemonth: return "1 Month"
        case .threemonths: return "3 Months"
        }
    }
}
