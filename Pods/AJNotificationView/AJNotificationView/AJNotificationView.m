//
//  AJNotificationView.m
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


#import "AJNotificationView.h"

@interface AJNotificationView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *parentView;

@property (nonatomic, strong) UIButton *disclosureButton;

@property (nonatomic, assign) float viewOffset;
@property (nonatomic, assign) NSTimeInterval hideInterval;

@property (nonatomic) AJDisclosureType disclosureType;
@property (nonatomic) AJNotificationType notificationType;

@property (nonatomic, copy) notificationBlock notificationResponse;
@property (nonatomic, copy) buttonBlock buttonResponse;

- (void)_drawBackgroundInRect:(CGRect)rect;

@end

#define PANEL_HEIGHT        44.0f
#define DISCLOSURE_HEIGHT   44.0f
#define Title_ORIGIN_X      10.0f
#define GAP_TITLE_BUTTON    10.0f
#define SHOW_DURATION       1.0f
#define HIDE_DURATION       0.5f

static NSMutableArray *notificationQueue = nil; // Global notification queue

@implementation AJNotificationView

#pragma mark - View LifeCycle

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame title:@"" message:@"" inParentView:nil disclosureType:AJDisclosureTypeNone buttonResponse:nil notificationResponse:nil];
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message inParentView:(UIView *)parentView disclosureType:(AJDisclosureType)disclosureType buttonResponse:(responseBlock)buttonResponse notificationResponse:(responseBlock)notificationResponse {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0f;
        
        _notificationType = AJNotificationTypeRed;
        _notificationResponse = notificationResponse;
        _buttonResponse = buttonResponse;
        
        // Title Label
        _parentView = parentView;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [self titleFont];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
        // Message Label
        _parentView = parentView;
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [self messageFont];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.numberOfLines = 0;
        _messageLabel.alpha = 0.0f;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.text = message;
        [self addSubview:_messageLabel];
        
        // Button
        _disclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _disclosureButton.frame = CGRectMake(self.frame.size.width, 0, 0, 0);
        _disclosureButton.alpha = 0.0f;
        if(disclosureType == AJDisclosureTypeClose)
            [_disclosureButton setImage:[UIImage imageNamed:@"close_white.png"] forState:UIControlStateNormal];
        else
            [_disclosureButton setImage:nil forState:UIControlStateNormal];
        
        [_disclosureButton addTarget:self action:@selector(detailDisclosureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_disclosureButton];
    }
    return self;
}

- (UIFont *)titleFont {
    return [UIFont boldSystemFontOfSize:14.0];
}

- (UIFont *)messageFont {
    return [UIFont systemFontOfSize:14.0];
}

- (void)drawRect:(CGRect)rect {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self _drawBackgroundInRect:(CGRect)rect];
}

- (void)detailDisclosureButtonPressed:(id)sender {
    if (self.buttonResponse != nil) {
        self.buttonResponse();
    }
    [self hide];
}

#pragma mark - Show

+ (AJNotificationView *)showInView:(UIView *)view type:(AJNotificationType)type title:(NSString *)title message:(NSString *)message hideAfter:(NSTimeInterval)hideInterval offset:(float)offset {
    return [self showInView:view type:type title:title message: message hideAfter:hideInterval offset:offset disclosureType:AJDisclosureTypeNone disclosureResponse:nil notificationResponse:nil];
}


+ (AJNotificationView *)showInView:(UIView *)view type:(AJNotificationType)type title:(NSString *)title message:(NSString *)message hideAfter:(NSTimeInterval)hideInterval offset:(float)offset disclosureType:(AJDisclosureType)disclosureType disclosureResponse:(responseBlock)disclosureResponse notificationResponse:(responseBlock)notificationResponse {
    
    AJNotificationView *noticeView = [[self alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 0)
                                                           title:title
                                                         message: message
                                                    inParentView:view
                                                  disclosureType:disclosureType
                                                  buttonResponse:disclosureResponse
                                            notificationResponse:notificationResponse];
    noticeView.notificationType = type;
    noticeView.viewOffset = offset;
    noticeView.hideInterval = hideInterval;
    noticeView.disclosureType = disclosureType;
    
    if (notificationQueue == nil) {
        notificationQueue = [[NSMutableArray alloc] init];
    }
    
    [notificationQueue addObject:noticeView];
    
    if ([notificationQueue count] == 1) {
        [noticeView show];
    }
    
    return noticeView;
}

- (void)show {
    [self.parentView addSubview:self];
    
    [self setNeedsDisplay];
    
    double statusBarOffset = ([self.parentView isKindOfClass:[UIWindow class]] && (! [[UIApplication sharedApplication] isStatusBarHidden])) ? [[UIApplication sharedApplication] statusBarFrame].size.height : 0.0;
    
    if (self.disclosureType != AJDisclosureTypeNone) {
        _disclosureButton.frame = CGRectMake(self.frame.size.width-DISCLOSURE_HEIGHT, statusBarOffset, DISCLOSURE_HEIGHT, DISCLOSURE_HEIGHT);
    }
    
    CGFloat titleWidth = self.frame.size.width-Title_ORIGIN_X-GAP_TITLE_BUTTON-_disclosureButton.frame.size.width;
    
    _titleLabel.frame = CGRectMake(Title_ORIGIN_X, statusBarOffset+15, titleWidth, [self getSizeOfString:self.titleLabel.text width:titleWidth font:[self titleFont]]);
    
    CGFloat messageOriginY = _titleLabel.frame.origin.y+_titleLabel.frame.size.height;
    
    _messageLabel.frame = CGRectMake(Title_ORIGIN_X, messageOriginY, titleWidth, [self getSizeOfString:self.messageLabel.text width:titleWidth font:[self messageFont]]);
    
    //Animation
    [UIView animateWithDuration:SHOW_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 1.0;
                         self.titleLabel.alpha = 1.0;
                         self.messageLabel.alpha = 1.0;
                         
                         if(self.disclosureType != AJDisclosureTypeNone) {
                             self.disclosureButton.alpha = 1.0;
                         }
                         
                         self.frame = CGRectMake(0.0, self.viewOffset, self.frame.size.width, MAX(_messageLabel.frame.origin.y+_messageLabel.frame.size.height+8.0f, PANEL_HEIGHT+statusBarOffset));
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             if (self.hideInterval > 0)
                                 [self performSelector:@selector(hide) withObject:self.parentView afterDelay:self.hideInterval];
                         }
                     }];
}

#pragma mark - Hide

- (void)hide {
    [UIView animateWithDuration:HIDE_DURATION
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0.0;
                         self.titleLabel.alpha = 0.0;
                         self.messageLabel.alpha = 0.0;
                         self.disclosureButton.alpha = 0.0;
                         
                         self.frame = CGRectMake(0.0, 0.0, self.frame.size.width, 0.0);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1f];
                             
                             // Remove this notification from the queue
                             [notificationQueue removeObjectIdenticalTo:self];
                             
                             // Show the next notification in the queue
                             if([notificationQueue count] > 0) {
                                 AJNotificationView *nextNotification = [notificationQueue objectAtIndex:0];
                                 [nextNotification show];
                             }
                         }
                     }];
}

+ (void)hideCurrentNotificationView {
    if ([notificationQueue count] > 0) {
        AJNotificationView *currentNotification = [notificationQueue objectAtIndex:0];
        [currentNotification hide];
    }
}

+ (void)hideCurrentNotificationViewAndClearQueue {
    NSUInteger numberOfNotification = [notificationQueue count];
    
    if (numberOfNotification > 1) {
        // remove all notification except the current notification
        [notificationQueue removeObjectsInRange:NSMakeRange(1, numberOfNotification -1)];
    }
    
    [AJNotificationView hideCurrentNotificationView];
}

+ (void)clearQueue {
    NSUInteger numberOfNotification = [notificationQueue count];
    
    if (numberOfNotification > 1) {
        // remove all notification except the current notification
        [notificationQueue removeObjectsInRange:NSMakeRange(1, numberOfNotification -1)];
    }
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch= [touches anyObject];
    if(![[touch view] isDescendantOfView:_disclosureButton]) {
        [self hide];
        
        if (self.notificationResponse != nil) {
            self.notificationResponse();
        }
    }
}

#pragma mark - Private

- (void)_drawBackgroundInRect:(CGRect)rect {
    UIColor *firstColor = nil;
    UIColor *secondColor = nil;
    UIColor *toplineColor = nil;
    
    switch (self.notificationType) {
        case AJNotificationTypeGreen: { //Green
            firstColor = RGBA(73,187,123, 1.0);
            secondColor = RGBA(73,187,123, 1.0);
            toplineColor = RGBA(73,187,123, 1.0);
            break;
        }
        case AJNotificationTypeRed: { //Red
            firstColor = RGBA(200,72,65, 1.0);
            secondColor = RGBA(200,72,65, 1.0);
            toplineColor = RGBA(200,72,65, 1.0);
            break;
        }
        case AJNotificationTypeYellow: { //Yellow
            firstColor = RGBA(242,200,89, 1.0);
            secondColor = RGBA(242,200,89, 1.0);
            toplineColor = RGBA(242,200,89, 1.0);
            break;
        }
        default: { //Gray
            firstColor = RGBA(150, 150, 150, 1.0);
            secondColor = RGBA(150, 150, 150, 1.0);
            toplineColor = RGBA(150, 150, 150, 1.0);
            break;
        }
    }
    
    //gradient
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint startPoint1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextSaveGState(ctx);
    CGContextAddRect(ctx, rect);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, gradient, startPoint1, endPoint1, 0);
    CGContextRestoreGState(ctx);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //shadow
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.layer.shadowRadius = 2.0f;
}

- (CGFloat)getSizeOfString:(NSString *)message width:(CGFloat)width font:(UIFont *)font {
    if(message.length <= 0)
        return 0;
    
    CGRect bounds = [message boundingRectWithSize:CGSizeMake(width, 1000000)
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    
    return ceilf(bounds.size.height);
}

@end

