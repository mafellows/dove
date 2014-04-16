//
//  DOVEInstructionsViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/16/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "DOVEInstructionsViewController.h"
#import "SAMGradientView.h"
#import "InstructionsView.h"

@interface DOVEInstructionsViewController ()

@end

@implementation DOVEInstructionsViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)loadView
{
    SAMGradientView *gradientView = [[SAMGradientView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    gradientView.gradientColors = @[ [UIColor colorWithRed:198.0f / 255.0f green:68.0f / 255.0f blue:252.0f / 255.0f alpha:1.0f],
                                     [UIColor colorWithRed:88.0f / 255.0f green:86.0f / 255.0f blue:214.0f / 255.0f alpha:1.0f] ];
    self.view = gradientView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [gradientView addSubview:scrollView];
    
    InstructionsView *instructionsView = [[InstructionsView alloc] initWithFrame:gradientView.bounds];
    [scrollView addSubview:instructionsView];
    
    [instructionsView.finishedButton addTarget:self
                                        action:@selector(dismiss:)
                              forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; 
}

@end
