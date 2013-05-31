//
//  ContainerView.m
//  Matchizmo
//
//  Created by yura on 5/30/13.
//
//

#import "ContainerView.h"

@implementation ContainerView


@synthesize centered;
@synthesize horisontalSpacing;
@synthesize verticalSpacing;
@synthesize topBorder, rightBorder;


#pragma mark -
#pragma mark Methods for overriding

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.contentSize = CGSizeMake(self.bounds.size.width, 1000);
        [self setBackgroundColor:[UIColor grayColor]];
        //[self setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
        //[self setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    }
    return self;
}

-(void) addSubview:(UIView *)view
{
    [super addSubview:view];
    [self setNeedsDisplay];
}
-(void) willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    [self performSelector:@selector(setNeedsDisplay) withObject:self afterDelay:0.1];
}


#pragma mark -
#pragma mark drawing

- (void)drawRect:(CGRect)rect
{
    //NSLog(@"drawRect   %i", self.subviews.count);
    if (self.subviews.count) {
        CGSize containerSize = self.bounds.size;
        CGSize viewSize = [[self.subviews objectAtIndex:0] bounds].size;
        int width = viewSize.width;    
        int height = viewSize.height; 
        
        int horCount = floor(containerSize.width / (viewSize.width + self.horisontalSpacing));
        if (horCount == 0) {
            horCount = 1;
        }
        CGFloat newRightBorder = (containerSize.width - (width * horCount + self.horisontalSpacing*(horCount-1))) / 2;
        CGFloat rBorder = (self.centered) ? newRightBorder : self.rightBorder;
        CGFloat tBorder = self.topBorder;
        
        int totalCounter = 0;
        int rowCounter = 0;        
        while (totalCounter < self.subviews.count) {
            for (int i = 0; i<horCount; i++) {
                CGRect frame = CGRectMake(rBorder + (i*(width + self.horisontalSpacing)), tBorder + rowCounter*(height+self.verticalSpacing), width, height);
                UIView* view = [self.subviews objectAtIndex:totalCounter];
                view.frame = frame;
                totalCounter++;
                if (totalCounter == self.subviews.count) break;
            }
            rowCounter++;
        }
    }
}


#pragma mark -
#pragma mark setters

-(void) setCentered:(BOOL)cent
{
    centered = cent;
    [self setNeedsDisplay];
}
-(void) setHorisontalSpacing:(CGFloat)newHorisontalSpacing
{
    horisontalSpacing = newHorisontalSpacing;
    [self setNeedsDisplay];
}
-(void) setVerticalSpacing:(CGFloat)newVerticalSpacing
{
    verticalSpacing = newVerticalSpacing;
    [self setNeedsDisplay];
}
-(void) setRightBorder:(CGFloat)rb
{
    rightBorder = rb;
    [self setNeedsDisplay];
}
-(void) setTopBorder:(CGFloat)tb
{
    topBorder = tb;
    [self setNeedsDisplay];
}


@end
