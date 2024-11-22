//
//  CurrencyFlagModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 17/11/2024.
//

import Foundation

// Model for each currency detail
struct CurrencyFlagModel: Codable, Equatable {
    let code: String
    let name: String
    let country: String
    let countryCode: String
    let flag: String?
    let symbol: String
    
    // Map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case country
        case countryCode
        case flag
        case symbol
    }
    
    static func == (lhs: CurrencyFlagModel, rhs: CurrencyFlagModel) -> Bool {
        return lhs.code == rhs.code &&
               lhs.name == rhs.name &&
               lhs.country == rhs.country
    }
    
    // Default instances for From and To currencies
    static let defaultFromCurrency = CurrencyFlagModel(
        code: "USD",
        name: "United States Dollar",
        country: "United States",
        countryCode: "US",
        flag: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAALESURBVHja7Jc/aBNxFMc/l0STtqYtihgkYLOYitjuFuwiUgfBUOgSOqS6CNqmRRqLmyjBBDQ4FLRL/TOokEEhgyC4O7RSB0MHWxEtWLGtrW2Su/s9h8ZeUlF7rV4XHzy+995v+d77vnf3fpqIsJ3mYpvtPwENcAPeMjppJlD0APXHj9/44nZvrhh3d45tsvYuAk9GdwM0nTiRkZmZb3L9+jPbuBUDmjyA1zAUIyMviMXaSaVzDPSfJJ3O0V+JqRz9A1acSufQgC+XrlpvJRXCVua06nNXYz36m0kArwtAKUVPTzvJ5FPifR0kk0/pW4/x6jje10GhoEOhaHmx7OtzP50XQDfWOIbb2lISjz+SqakFicVGN4yx2OhWJQh7AAzDJB7vYHDwEclkF4nExnBo6DGz3Rfs959/F8aHGQDKBBSJxEOuXeuit/cemUz3hhBA6d82NfxSKlkStLZekcnJeTl2LC35/Jwt/CsS6LpJT88d7oycJRod5sH9c0Sjw9z/A4Lw8egp0MptLmI9V8br8prPB8WCJYGuK27fPkPk9E2y2T5ORzJks71EIqtxZC2uznd23kJ8y9Vj9zv7MZKGjlROQSg0JKHQZZmYmJVgMLFhDAYTW5YAIBwMJmR8/JPU1Z2XsTF7OL3nkH0PtMj7g20ChDUgHAhczC8tlTAM03ZD52ue258CjwfNX8eBty+bNSBsmmbe5XL2z6yUwu12N3sApve34jFMpKQ7swPs3IGxw2NNgTINRARRpv1tQtbFld3+q3VT3CjTsAgE34/j8/kclWBlZQVqa1cJTO89TI3XiyyvOCNBbQ3LpaK1E5pKVX/B/jkDDaWkQoKPr2hoaHBUgoWFBWhsXCXwLtBCY73fUQJzXxfXKmDqfpPPMu8oAfEDBUwN2AccAfY6vJbPAq+18p3AX0YnrQgsav8vp9tN4PsALYQJa7MTgzkAAAAASUVORK5CYII=",
        symbol: "$"
    )
    
    static let defaultToCurrency = CurrencyFlagModel(
        code: "VND",
        name: "Vietnamese Đồng",
        country: "Vietnam",
        countryCode: "vn",
        flag: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAK4SURBVHja7Jc9axRRFIafMzM7k5jEjUERO0XRKgTE1tbGwir4DxTBXqwsBHut9BdYiD/AThDEQlSiYiWIjQQx0f2YvbP341jMrtldd8lsM2lyYLiwc3fOc+6877l3RFU5yIg44DgEECAGssFYZ3igSICjPzY3d4hrzi/CqadP1xKgSRSxePlyrfn7X74ANBMg0xDQoiC0WjC0pUg5TtpUZHzONBtP/ndiXtRsgrUAWQKAc6gxqDG1VK/GoCUAJYD3hF6P0OvNZ6FlQCF05yRoNAijAOocmufonADJeQ8xFO/mE7AmCTg3AuA92m6j3flKydYL1AjmVTofAKD9/sgrsBbf6aB5Xt1FDUjPdkFA3RJazAGgCkUxAuAcodOZKUJJFckGrUPLq3E6EB3LwUN6NmA+RuU9AUkhtGU2fAgwugJqLXQ66IBq0mpRoixccqzeMEisqAeJBVxptbU7OdoXpKFoX/j9JKP7ojGt9PLZzqGTGqDb/WeNyXA5dJ5B8RbW7hnSMwHCYDWGVWXQ/xqxc/8I9psF7Ox3YC1E0bgGXJ4Pm8Ps5v0eflxXjt81LF0r9gAEOs8zfj1YRH2rkg3jlZU9gOAceA8h7C+gHtjvCjI+122D2lBNhd6XOYfbsTpXCqPKJYGlqwUQ6L2O6b2Jyt+umBKqwjMkhPFO6J0jUa20Aum6p3HOsvtwkT+PMwBWbxtWbxnSC5b+p7iKD8c7YXAOVUUrACxsWLZvLpK/bFAqEXYfpRSfheyipdiSSgB+1AXBOUiS6TvbxPGl2BLMh//n9l4mZBuutMZ+51yRCYBh5fsBKJi3MdMyqJ19b1oMc0YAPoS9Pbym09AYQFBFagSQEYCyEw5WIFperg1iFMAHYLfVos4YKMULcBJYB07UfCz/CXyUwTfBymCsMwqgLYcfpwcN8HcAxaOgKWN6t2cAAAAASUVORK5CYII=",
        symbol: "₫"
    )
}
