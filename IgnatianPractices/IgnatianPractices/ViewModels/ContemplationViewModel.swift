//
//  ContemplationViewModel.swift
//  IgnatianPractices
//
//  Created by Laurel Walker Davis on 4/17/23.
//

import Foundation

class ContemplationViewModel : ObservableObject {
    @Published private(set) var contemplationImages = [
        ContemplationModel(fileName: "Baptism_Slovakia", description: "Baptism of Jesus by John the Baptist", credit: "Baptism of Jesus Christ by John the Baptist, graphic collage from engraving of Nazareene School, published in The Holy Bible, St.Vojtech Publishing, Trnava, Slovakia, 1937. ©fluenta - stock.adobe.com"),
        ContemplationModel(fileName: "Birth", description: "Jesus's Birth", credit: "Christmas religious illustration - fresco in Byzantine style. ©Julia - stock.adobe.com"),
        ContemplationModel(fileName: "Death", description: "Christ's Body Being Prepared", credit: "Christ's body being prepared after his death - mosaic in Jerusalem. ©jorisvo - stock.adobe.com"),
        ContemplationModel(fileName: "Emmaus", description: "Supper In Emaus", credit: "ROME, ITALY - AUGUST 28, 2021: The painting of Supper in Emaus in the church Chiesa san Giacomo in Augusta by Ettore Ballerini (1910). ©Renáta Sedmáková - stock.adobe.com"),
        ContemplationModel(fileName: "Gethsemane", description: "Jesus Christ Praying in Gethsemane", credit: "Jesus Christ praying in the garden of Gethsemane before His crucifixion oil painting created with generative AI. ©JoelMasson - stock.adobe.com"),
        ContemplationModel(fileName: "GloryKing", description: "Christ the King", credit: "COMO, ITALY - MAY 8, 2015: The fresco of Glory of Christ the King in church Santuario del Santissimo Crocifisso by Gersam Turri (1927-1929). ©Renáta Sedmáková - stock.adobe.com"),
        ContemplationModel(fileName: "LastSupper", description: "The Last Supper", credit: "Paris, France: May 06, 2017: La Cene (Last Supper), a famous painting by Philippe de CHAMPAIGNE exposed in Louvre Museum. ©agcreativelab - stock.adobe.com"),
        ContemplationModel(fileName: "PalmSunday", description: "Christ's Entrance on Palm Sunday", credit: "Christ's Entrance to Jerusalem by Hippolyte Flandrin in church Saint-Germain-des-Pres, Paris. ©Onyshchenko - stock.adobe.com"),
        ContemplationModel(fileName: "Pantocrator", description: "Christ Pantocrator - \"Ruler of the Universe\"", credit: "Golden mosaic with Christ Pantocrator in the apse of Cefalù Cathedral. Sicily, southern Italy. ©e55evu - stock.adobe.com"),
        ContemplationModel(fileName: "Resurrection", description: "Resurrection of Jesus from Death", credit: "Christian symbol of faith, art illustration painted oil style. ©vladischern - stock.adobe.com"),
        ContemplationModel(fileName: "Temptation", description: "The Temptation of Christ", credit: "Antwerp - Fresco of Temptation of Jesus in Joriskerk or st. George church. ©Renáta Sedmáková - stock.adobe.com")
    ]
    
    
    func getTodaysImage() -> ContemplationModel {
        let index = Int.random(in: 0...10)
        return contemplationImages[index]
    }
    
}

