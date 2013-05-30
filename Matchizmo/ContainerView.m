//
//  ContainerView.m
//  Matchizmo
//
//  Created by yura on 5/30/13.
//
//

#import "ContainerView.h"

@implementation ContainerView

@synthesize views = _views;
@synthesize centered = _centered;
@synthesize horisontalSpacing = _horisontalSpacing;






- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_views) {
            _views = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(void) setViews:(NSMutableArray *)views
{
    [views retain];
    [_views release];
    _views = views;
    
    [self setNeedsDisplay];
}

-(void) addSubview:(UIView *)view
{
    [super addSubview:view];
    //[self.views addObject:view];
    //[self setNeedsDisplay];
}
-(void) removeObjectFromViewsAtIndex:(NSUInteger)index
{
    if (index >= self.views.count) {
        NSLog(@"invalid index");
    }
    
    [self.views removeObjectAtIndex:index];
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect
{
    if (self.views.count) {
        CGSize containerSize = self.bounds.size;
        CGSize viewSize = [[self.views objectAtIndex:0] bounds].size;
        
        int horCount = round(containerSize.width / viewSize.width);
        int verCount = round(self.views.count / horCount);
        
        int width = 30;     int horisontalBorder = 10;
        int height = 50;    int verticalBorder = 10;

        
        
        for (int i = 0; horCount; i++) {
            for (int j = 0; verCount; j++) {
                CGRect frame = CGRectMake(width * j, height * i, width, height);
                UIView* view = [self.views objectAtIndex:i];
                view.frame = frame;
            }
            
        }
    }
    
}


@end
