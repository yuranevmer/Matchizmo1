//
//  PlayingCard.m
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        PlayingCard* otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    }
    
    
    return score;
}


-(NSString*) contents
{
    return [[[PlayingCard rankStrings] objectAtIndex:self.rank] stringByAppendingString:self.suit];
}


+(NSArray*) validSuits
{
    static NSArray* validSuits = nil;
    if (!validSuits) validSuits = [[NSArray alloc] initWithObjects:@"♠",@"♣",@"♥",@"♦", nil];
    return validSuits;
}
+(NSUInteger) maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

@synthesize suit = _suit;
-(void) setSuit:(NSString*) suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

@synthesize rank = _rank;
+(NSArray*) rankStrings
{
    NSArray* rankStrings = [[NSArray alloc] initWithObjects:@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",nil];
    return rankStrings;
}

-(void) setRank: (NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



@end
