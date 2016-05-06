//
//  UIViewController+CUNKDynamicType.m
//  DynamicTypeAlpha
//
//  Created by Paul Goracke on 5/5/16.
//  Copyright © 2016 Corporation Unknown. All rights reserved.
//

#import "UIViewController+CUNKDynamicType.h"

#import "CUNKTextStyleResponder.h"

@implementation UIViewController (CUNKDynamicType)

- (void) cunk_updateFonts {
    [[UIApplication sharedApplication] sendAction:@selector(updateFonts) to:nil from:self forEvent:nil];
}

@end
