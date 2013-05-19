//
//  PlayingCard.h
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, retain) NSString* suit;
@property (nonatomic) NSUInteger rank;



+(NSArray*) validSuits;
+(NSUInteger) maxRank;
@end
