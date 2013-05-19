//
//  Deck.m
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Deck.h"

@implementation Deck


NSMutableArray* _cards;



-(NSMutableArray*) cards
{
    if(!_cards) _cards= [[NSMutableArray alloc] init];
    return _cards;
}





-(void) addCard:(id)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    
}

-(Card*)drawRandomCard {
    Card* randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = [self.cards objectAtIndex:index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}
@end
