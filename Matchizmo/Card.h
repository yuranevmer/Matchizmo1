//
//  Card.h
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject


@property (nonatomic,retain) NSString* contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

-(int)match:(NSArray*)otherCards;

@end
