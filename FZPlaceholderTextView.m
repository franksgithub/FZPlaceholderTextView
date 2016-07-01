//
//  FZPlaceholderTextView.m
//
//  Created by Frank on 15/12/1.
//  Copyright © 2015年. All rights reserved.
//

#import "FZPlaceholderTextView.h"

@implementation FZPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    self.placeholderColor = [UIColor lightGrayColor];
    [self addTextViewNotificationObservers];
}

- (void)dealloc
{
    [self removeTextViewNotificationObservers];
    self.placeholder = nil;
    self.placeholderColor = nil;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if ([placeholder isEqualToString:_placeholder]) {
        return;
    }
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if ([placeholderColor isEqual:_placeholderColor]) {
        return;
    }
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([self.text length] == 0 && self.placeholder) {
        [self.placeholderColor set];
        [self.placeholder drawInRect:CGRectInset(rect, 7.0f, 5.0f) withAttributes:[self placeholderTextAttributes]];
    }
}

- (NSDictionary *)placeholderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    return @{NSFontAttributeName : self.font, NSForegroundColorAttributeName : self.placeholderColor, NSParagraphStyleAttributeName : paragraphStyle};
}

#pragma mark - Notifications

- (void)addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
}

- (void)didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

@end
