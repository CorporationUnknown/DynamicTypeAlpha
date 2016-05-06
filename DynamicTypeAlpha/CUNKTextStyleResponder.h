//
//  CUNKTextStyleResponder.h
//  DynamicTypeDemo
//
//  Created by Paul Goracke on 5/5/16.
//  Copyright © 2016 Corporation Unknown. All rights reserved.
//

@import UIKit;

@interface CUNKTextStyleResponder : UIResponder

- (instancetype) initWithViewController:(UIViewController*)vc;

- (void) setFontForLabel:(UILabel*)label;

- (void) updateFonts;

@end
