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
@property(nonatomic, retain) NSString* lastFlipResult;
@property(nonatomic) NSUInteger gameMode;
@end

@implementation CardMatchingGame

@synthesize score = _score;
@synthesize cards = _cards;
@synthesize lastFlipResult = _lastFlipResult;
@synthesize gameMode = _gameMode;

-(NSMutableArray*) cards 
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck gameMode: (NSUInteger) gameMode
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
        self.gameMode = gameMode;
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
        self.lastFlipResult = [NSString stringWithFormat:@"Flipped up %@",card.contents];
        for (Card* otherCard in self.cards) {
          if (self.gameMode == 2) {
            if (otherCard.isFaceUp && otherCard != card && !otherCard.isUnplayable) {
                int matchScore = [card match:[NSArray arrayWithObject:otherCard]];
                if (matchScore) {
                    otherCard.unplayable = YES;
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    self.lastFlipResult = [NSString stringWithFormat:@"Match %@ & %@ for %i points",card.contents, otherCard.contents, MATCH_BONUS];
                } else {
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    self.lastFlipResult = [NSString stringWithFormat:@"%@ & %@ don't match! %i point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                }
            }
          }
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.isFaceUp;
}
-(void) setGameMode:(NSUInteger)gameMode
{
    if (gameMode != 2 && gameMode != 3) gameMode = 2;
    _gameMode = gameMode;
}

-(NSString*) lastFlipResult
{
    if (!_lastFlipResult) {
        _lastFlipResult = [[NSString alloc] initWithFormat:@"..."];
    }
    return _lastFlipResult;
}

@end
