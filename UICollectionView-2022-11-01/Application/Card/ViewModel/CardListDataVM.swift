//
//  CardListDataViewModel.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 1/9/22.
//

import Foundation

class CardListDataVM {
    
    var cardListData = [CardListDatas<Any>]()
    
    func getCardListData() {
        
        //Card
        let cardListRec = [
            
            CardListData.Card.object(
                cardNumber : "1111    * * * *    * * * *    9999",
                validThru  : "08/23",
                cvc        : "119",
                cardType   : "visa"),
            
            CardListData.Card.object(
                cardNumber : "2222    * * * *    * * * *    8888",
                validThru  : "09/24",
                cvc        : "228",
                cardType   : "mastercard"),
            
            CardListData.Card.object(
                cardNumber : "3333    * * * *    * * * *    7777",
                validThru  : "10/25",
                cvc        : "337",
                cardType   : "visa"),
            
            CardListData.Card.object(
                cardNumber : "4444    * * * *    * * * *    6666",
                validThru  : "11/26",
                cvc        : "446",
                cardType   : "mastercard")
            
        ]
        
        //        let cardListRec = [String]()
        
        //AmountOfEachCard
        let amountOfEachCardRec = [
            
            CardListData.AmountOfEachCard.object(value: "10,000,000 원"),
            CardListData.AmountOfEachCard.object(value: "20,000,000 원"),
            CardListData.AmountOfEachCard.object(value: "30,000,000 원"),
            CardListData.AmountOfEachCard.object(value: "40,000,000 원"),
            
        ]
        
        //        let amountOfEachCardRec = [String]()
        
        
        let receiptRec1 = [
            
            Receipt.object(name: "Cola",   date: "1월 11일(수)", type: "기업1234", price: "100,000 원"),
            Receipt.object(name: "Pepsi",  date: "2월 12일(수)", type: "기업1235", price: "200,000 원"),
            Receipt.object(name: "Sprite", date: "3월 21일(수)", type: "기업1236", price: "300,000 원"),
            Receipt.object(name: "Fanta",  date: "4월 22일(수)", type: "기업1237", price: "400,000 원"),
            Receipt.object(name: "Zenya",  date: "5월 23일(수)", type: "기업1238", price: "500,000 원"),
        
        ]
        
        let receiptRec2 = [
            
            Receipt.object(name: "Espresso",    date: "5월 18일(수)", type: "기업1234", price: "500,000 원"),
            Receipt.object(name: "Latte",       date: "6월 19일(수)", type: "기업1235", price: "600,000 원"),
            Receipt.object(name: "Mocha",       date: "7월 20일(수)", type: "기업1236", price: "700,000 원"),
            Receipt.object(name: "Cappuccino",  date: "8월 21일(수)", type: "기업1237", price: "800,000 원"),
            Receipt.object(name: "Americano",   date: "9월 22일(수)", type: "기업1238", price: "900,000 원"),
        
        ]
        
        //Assign Data
        cardListData = [
            
            CardListDatas(rowType: .Banner,           value: nil),
            CardListDatas(rowType: .Card,             value: cardListRec),
            CardListDatas(rowType: .AmountOfEachCard, value: amountOfEachCardRec),
            CardListDatas(rowType: .Receipt,          value: [receiptRec1, receiptRec2]),
            
        ]
        
    }
}
