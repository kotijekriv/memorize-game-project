//
//  MemoryGame.swift
//  Memorize
//
//  Created by Pero Radich on 09.07.2021..
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose (_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex] .isFaceUp,
            !cards[chosenIndex].isMatched {
            
            //ako je jedna karta vec okrenuta
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                //ako se karte poklapaju
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    //ako se karte ne poklapaju
                    if cards[chosenIndex].hasBeenSeen == true{
                        score -= 1
                    }else{
                        cards[chosenIndex].hasBeenSeen = true
                    }
                    
                    if cards[potentialMatchIndex].hasBeenSeen == true{
                        score -= 1
                    }else{
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                }
                
                //vraćanje privremene varijable okrenute karte u nil
                indexOfTheOneAndOnlyFaceUpCard = nil
                 
            } else {
                //ako nije nijedna karta vec okrenuta ili su obje okrenute
                
                //vraćanje svih karata licem prema dolje
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //okretanje samo odabrane karte
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        score = 0
        //add numberOfPairsOfCards x 2 cards to cards array        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
