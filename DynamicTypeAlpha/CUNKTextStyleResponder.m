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

- (instancetype) initWithViewController:(UIViewController*)vc {
    self = [super init];
    if ( self != nil ) {
        self->_viewController = vc;
    }
    return self;
}

- (void) setFontForLabel:(UILabel*)label {
    
}

- (UIResponder*) nextResponder {
    UIResponder* nextResponder = nil;
    UIResponder* parentResponder = self.viewController;
    // Runtime contortions to invoke the view controller's superclass' -nextResponder method
    // Since the view controller's -nextResponder method would just return us again
    Class vcSuper = class_getSuperclass(parentResponder.class);
    Method method = class_getInstanceMethod(vcSuper, @selector(nextResponder));
    id (*_method_invoke_super)(id, Method, ...) = (id (*)(id, Method, ...)) method_invoke;
    nextResponder = _method_invoke_super(parentResponder, method);
    return nextResponder;
}

@end
