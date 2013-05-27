//
//  CardMatchingGame.h
//  Matchizmo
//
//  Created by admin on 26.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*) deck gameMode:(NSUInteger)gameMode;
-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*) cardAtIndex:(NSUInteger)index;


@property (nonatomic,readonly) int score;
@property (nonatomic,readonly, retain) NSString* lastFlipResult;

@end
