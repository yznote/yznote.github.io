//
//  qwqwq.m
//  UltTest
//
//  Created by Rookie on 2017/6/28.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "qwqwq.h"

@implementation qwqwq

- (void) setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UILabel* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 10;
        
        size.width = 10;
        
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
        
        
        
    }
    
}



@end
