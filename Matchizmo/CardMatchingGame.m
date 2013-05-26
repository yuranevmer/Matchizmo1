//
//  CardMatchingGame.m
//  Matchizmo
//
//  Created by admin on 26.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property(nonatomic,retain) NSMutableArray* cards;
@property(nonatomic) int score;
@end

@implementation CardMatchingGame

@synthesize score = _score;
@synthesize cards = _cards;

-(NSMutableArray*) cards 
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    if (self == [super init]) {
        for (int i = 0; i < cardCount; i++) {
            Card* card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                [self.cards insertObject:card atIndex:i];
            }
        }
    }
    return self;
}

-(Card*) cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? [self.cards objectAtIndex:index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

-(void) flipCardAtIndex:(NSUInteger)index
{
    Card* card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        for (Card* otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                int matchScore = [card match:[NSArray arrayWithObject:otherCard]];
                if (matchScore) {
                    otherCard.unplayable = YES;
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                } else {
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                }
            }
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.isFaceUp;
}

@end
