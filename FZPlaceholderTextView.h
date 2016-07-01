//
//  KCPlaceholderTextView.h
//
//  Created by Frank on 15/12/1.
//  Copyright © 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FZPlaceholderTextView : UITextView

@property (copy, nonatomic) IBInspectable NSString *placeholder;

@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;

@end
