//
//  CardView.h
//  Matchizmo
//
//  Created by yura on 5/31/13.
//
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic, retain) NSString* suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL isFaceup;
@property (nonatomic, retain) NSString* contents;

@end
