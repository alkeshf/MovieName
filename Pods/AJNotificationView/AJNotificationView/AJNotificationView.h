//
//  AJNotificationView.h
//  AJNotificationViewDemo
//
//  Created by Alberto Jerez on 02/08/12.
//  Copyright (c) 2012 CodeApps. All rights reserved.
//
//Copyright © 2012 Alberto Jerez - CodeApps
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”),
//to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//IN THE SOFTWARE.

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef void (^responseBlock)();
typedef void (^buttonBlock)();
typedef void (^notificationBlock)();

typedef enum {
    AJNotificationTypeRed,
    AJNotificationTypeGreen,
    AJNotificationTypeYellow,
    AJNotificationTypeDefault
} AJNotificationType;

typedef enum {
    AJDisclosureTypeClose,
    AJDisclosureTypeNone
} AJDisclosureType;

@interface AJNotificationView : UIView

+ (AJNotificationView *)showInView:(UIView *)view type:(AJNotificationType)type title:(NSString *)title message:(NSString *)message hideAfter:(NSTimeInterval)hideInterval offset:(float)offset;

+ (AJNotificationView *)showInView:(UIView *)view type:(AJNotificationType)type title:(NSString *)title message:(NSString *)message hideAfter:(NSTimeInterval)hideInterval offset:(float)offset disclosureType:(AJDisclosureType)disclosureType disclosureResponse:(responseBlock)disclosureResponse notificationResponse:(responseBlock)notificationResponse;

- (void)hide;
- (UIFont *)titleFont;
- (UIFont *)messageFont;

+ (void)clearQueue;
+ (void)hideCurrentNotificationView;
+ (void)hideCurrentNotificationViewAndClearQueue;

@end

