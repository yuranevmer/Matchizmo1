//
//  ContainerView.h
//  Matchizmo
//
//  Created by yura on 5/30/13.
//
//

#import <UIKit/UIKit.h>

@interface ContainerView : UIView

@property(retain,nonatomic) NSMutableArray* views;
@property(nonatomic) CGFloat horisontalSpacing;
@property(nonatomic) BOOL centered;

@end
