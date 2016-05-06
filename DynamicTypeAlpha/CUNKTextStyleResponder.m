//
//  CUNKTextStyleResponder.m
//  DynamicTypeDemo
//
//  Created by Paul Goracke on 5/5/16.
//  Copyright © 2016 Corporation Unknown. All rights reserved.
//

#import "CUNKTextStyleResponder.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface CUNKTextStyleResponder ()

@property (weak,nonatomic) UIViewController* viewController;

@end

@implementation CUNKTextStyleResponder

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (instancetype) initWithViewController:(UIViewController*)vc {
    self = [super init];
    if ( self != nil ) {
        self->_viewController = vc;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contentSizeCategoryDidChange:)
                                                     name:UIContentSizeCategoryDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void) setFontForLabel:(UILabel*)label {
    NSLog(@"%s : %@", __PRETTY_FUNCTION__, label);
}

- (void) updateFonts {
    [self updateFontsForLabelsInView:self.viewController.viewIfLoaded];
}

- (void) updateFontsForLabelsInView:(UIView*)view {
    for ( UIView* subview in view.subviews ) {
        if ( [subview isKindOfClass:[UILabel class]] ) {
            UILabel* label = (UILabel*)subview;
            [[UIApplication sharedApplication] sendAction:@selector(setFontForLabel:)
                                                       to:nil
                                                     from:label
                                                 forEvent:nil];
        }
        else {
            // recurse
            [self updateFontsForLabelsInView:subview];
        }
    }
}

- (void) contentSizeCategoryDidChange:(NSNotification*)notification {
    [self updateFonts];
}

#pragma mark - UIResponder chain handling

// Implementing -superNextResponder defines the selector for our
// -nextResponder call below.
// It also serves as a nice easy copy-paste to add to your view controller.
- (UIResponder*) superNextResponder {
    return [super nextResponder];
}

- (UIResponder*) nextResponder {
    UIResponder* nextResponder = nil;
    UIResponder* parentResponder = self.viewController;
    if ( [parentResponder respondsToSelector:@selector(superNextResponder)] ) {
        nextResponder = [(id)parentResponder superNextResponder];
    }
    else {
        // Runtime contortions to invoke the view controller's superclass' -nextResponder method
        // Since the view controller's -nextResponder method would just return us again
        Class vcSuper = class_getSuperclass(parentResponder.class);
        Method method = class_getInstanceMethod(vcSuper, @selector(nextResponder));
        id (*_method_invoke_super)(id, Method, ...) = (id (*)(id, Method, ...)) method_invoke;
        nextResponder = _method_invoke_super(parentResponder, method);
    }
    return nextResponder;
}

@end
