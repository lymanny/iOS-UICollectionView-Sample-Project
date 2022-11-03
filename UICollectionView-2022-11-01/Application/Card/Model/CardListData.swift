//
//  CardListData.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 1/9/22.
//

import Foundation

enum CardListRowType: String, CaseIterable {
    case Banner
    case Card
    case AmountOfEachCard
    case Receipt
}

struct CardListDatas <T> {
    var rowType : CardListRowType?
    var value   : T?
}

struct CardListData {
    //Card
    struct Card {
        var object  : [object]
        
        struct object {
            let cardNumber : String?
            let validThru  : String?
            let cvc        : String?
            let cardType   : String?
        }
    }
    
    //AmountOfEachCard
    struct AmountOfEachCard {
        var object  : [object]
        
        struct object {
            let value      : String?
        }
    }
    
}

struct Receipt {
    var object: [object]
    
    struct object {
        let name  : String?
        let date  : String?
        let type  : String?
        let price : String?
    }
}


