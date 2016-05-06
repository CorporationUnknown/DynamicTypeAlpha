//
//  ViewController.m
//  DynamicTypeAlpha
//
//  Created by Paul Goracke on 5/5/16.
//  Copyright © 2016 Corporation Unknown. All rights reserved.
//

#import "ViewController.h"

#import "CUNKTextStyleResponder.h"
#import "UIViewController+CUNKDynamicType.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;

@property (strong, nonatomic) CUNKTextStyleResponder* textStyleResponder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textStyleResponder = [[CUNKTextStyleResponder alloc] initWithViewController:self];
    
    [self cunk_updateFonts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIResponder*) nextResponder {
    return self.textStyleResponder;
}

@end
