//
//  ViewController.m
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"


@interface ViewController ()

@property (retain, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (nonatomic, retain) PlayingCardDeck* deck;
@end


@implementation ViewController
@synthesize flipsLabel;
@synthesize flipCount = _flipCount;
@synthesize deck = _deck;
-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %i", self.flipCount];
}

-(PlayingCardDeck*) deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (IBAction)flipCard:(UIButton*)sender {
    if (!sender.isSelected) {
        NSString* newCardTitle = [self.deck drawRandomCard].contents;
        [sender setTitle:newCardTitle forState: UIControlStateSelected];
        sender.selected = YES;
    } else {
        sender.selected = NO;
    }
    self.flipCount++;
}



















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setFlipsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [flipsLabel release];
    [super dealloc];
}
@end
