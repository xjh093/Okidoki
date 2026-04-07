//
//  TestsTests.m
//  TestsTests
//
//  Created by HaoCold on 2020/7/30.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Okidoki.h"

@interface TestsTests : XCTestCase

@end

@implementation TestsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testView {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    UIView *view = [[UIView alloc] init];
    
    view.okidoki.tag(@"1");
    XCTAssert(view.tag == 1, @"");
    
    view.okidoki.tag(@2);
    XCTAssert(view.tag == 2, @"");
    
    view.okidoki.frame([NSValue valueWithCGRect:CGRectMake(0, 1, 2, 3)]);
    XCTAssert(CGRectEqualToRect(view.frame , CGRectMake(0, 1, 2, 3)), @"");
    
    view.okidoki.frame(@"{{4,5},{6,7}}");
    XCTAssert(CGRectEqualToRect(view.frame , CGRectMake(4, 5, 6, 7)), @"");
    
    view.okidoki.alpha(@"0.5");
    XCTAssert(view.alpha == 0.5, @"");
    
    view.okidoki.alpha(@(0.7));
    XCTAssert(fabs(view.alpha - 0.7) < 0.000001, @"");
    // 0.69999998807907104
    
    view.okidoki.hidden(@"1");
    XCTAssert(view.hidden == YES, @"");
    
    view.okidoki.hidden(@0);
    XCTAssert(view.hidden == NO, @"");
    
    view.okidoki.bgColor([UIColor blackColor]);
    XCTAssert([view.backgroundColor isEqual:[UIColor blackColor]], @"");
    
    view.okidoki.bgColor(@"ff0000");
    XCTAssert([view.backgroundColor isEqual:[UIColor redColor]], @"");
    
    view.okidoki.bgColor(@"#00ff00");
    XCTAssert([view.backgroundColor isEqual:[UIColor greenColor]], @"");
    
    view.okidoki.bgColor(@"0x0000ff");
    XCTAssert([view.backgroundColor isEqual:[UIColor blueColor]], @"");
    
    view.okidoki.bdColor([UIColor blackColor]);
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor] isEqual:[UIColor blackColor]], @"");
    
    view.okidoki.bdColor(@"ff0000");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor redColor]], @"");
    
    view.okidoki.bdColor(@"#00ff00");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor greenColor]], @"");
    
    view.okidoki.bdColor(@"0x0000ff");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor blueColor]], @"");
    
    view.okidoki.bdWidth(@"1");
    XCTAssert(view.layer.borderWidth == 1, @"");
    
    view.okidoki.bdWidth(@"1.5");
    XCTAssert(view.layer.borderWidth == 1.5, @"");
    
    view.okidoki.bdWidth(@2);
    XCTAssert(view.layer.borderWidth == 2, @"");
    
    view.okidoki.bdWidth(@2.5);
    XCTAssert(view.layer.borderWidth == 2.5, @"");
    
    view.okidoki.cnRadius(@"1");
    XCTAssert(view.layer.cornerRadius == 1, @"");
    
    view.okidoki.cnRadius(@"0.6");
    XCTAssert(fabs(view.layer.cornerRadius - 0.6) < 0.000001, @"");
    
    view.okidoki.cnRadius(@"0.7");
    XCTAssert(fabs(view.layer.cornerRadius - 0.7) < 0.000001, @"");
    
    view.okidoki.cnRadius(@0.8);
    XCTAssert(fabs(view.layer.cornerRadius - 0.8) < 0.000001, @"");
    
    view.okidoki.mtBounds(@"1");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@1);
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@(-1));
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@(+1));
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"y");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"ya");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"Y");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"t");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"T");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"a");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"0");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@0);
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"f");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"n");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
}


- (void)testLabel{
    UILabel *label = [[UILabel alloc] init];
    
    label.okidoki.text(@"123");
    XCTAssert([label.text isEqualToString:@"123"], @"");
    
    label.okidoki.font(@"12");
    XCTAssert([label.font isEqual:[UIFont systemFontOfSize:12]], @"");
    
    label.okidoki.font(@"b13");
    XCTAssert([label.font isEqual:[UIFont boldSystemFontOfSize:13]], @"");
    
    label.okidoki.font(@"i14");
    XCTAssert([label.font isEqual:[UIFont italicSystemFontOfSize:14]], @"");
    
    label.okidoki.font([UIFont systemFontOfSize:15]);
    XCTAssert([label.font isEqual:[UIFont systemFontOfSize:15]], @"");
    
    label.okidoki.font([UIFont boldSystemFontOfSize:16]);
    XCTAssert([label.font isEqual:[UIFont boldSystemFontOfSize:16]], @"");
    
    label.okidoki.font([UIFont italicSystemFontOfSize:17]);
    XCTAssert([label.font isEqual:[UIFont italicSystemFontOfSize:17]], @"");
    
    label.okidoki.color([UIColor blackColor]);
    XCTAssert([label.textColor isEqual:[UIColor blackColor]], @"");
    
    label.okidoki.color(@"ff0000");
    XCTAssert([label.textColor isEqual:[UIColor redColor]], @"");
    
    label.okidoki.color(@"#00ff00");
    XCTAssert([label.textColor isEqual:[UIColor greenColor]], @"");
    
    label.okidoki.color(@"0x0000ff");
    XCTAssert([label.textColor isEqual:[UIColor blueColor]], @"");
    
    label.okidoki.align(@0);
    XCTAssert(label.textAlignment == NSTextAlignmentLeft, @"");
    
    label.okidoki.align(@1);
    XCTAssert(label.textAlignment == NSTextAlignmentCenter, @"");
    
    label.okidoki.align(@2);
    XCTAssert(label.textAlignment == NSTextAlignmentRight, @"");
    
    label.okidoki.align(@"0");
    XCTAssert(label.textAlignment == NSTextAlignmentLeft, @"");
    
    label.okidoki.align(@"1");
    XCTAssert(label.textAlignment == NSTextAlignmentCenter, @"");
    
    label.okidoki.align(@"2");
    XCTAssert(label.textAlignment == NSTextAlignmentRight, @"");
    
    label.okidoki.lines(@2);
    XCTAssert(label.numberOfLines == 2, @"");
    
    label.okidoki.lines(@"3");
    XCTAssert(label.numberOfLines == 3, @"");
    
    label.okidoki.adjust(@0);
    XCTAssert(label.adjustsFontSizeToFitWidth == NO, @"");
    
    label.okidoki.adjust(@1);
    XCTAssert(label.adjustsFontSizeToFitWidth == YES, @"");
    
    label.okidoki.adjust(@"0");
    XCTAssert(label.adjustsFontSizeToFitWidth == NO, @"");
    
    label.okidoki.adjust(@"1");
    XCTAssert(label.adjustsFontSizeToFitWidth == YES, @"");
    

    // attributedSubstring - UIColor
    {
    UILabel *label = [[UILabel alloc] init];
    label.okidoki.text(@"haha123");
    label.okidoki.attributedSubstring(@"haha", [UIColor redColor]);
    
    NSMutableAttributedString *matts = [[NSMutableAttributedString alloc] initWithString:@"haha123"];
    [matts addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[@"haha123" rangeOfString:@"haha"]];
    
    NSRange range = [@"haha123" rangeOfString:@"haha"];
    
    __block NSDictionary *dic1;
    [label.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic1 = attrs;
        NSLog(@"1.attrs:%@",attrs);
    }];
    
    __block NSDictionary *dic2;
    [matts enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic2 = attrs;
        NSLog(@"2.attrs:%@",attrs);
    }];
    
    XCTAssert([dic1[@"NSColor"] isEqual:dic2[@"NSColor"]],@"");
    }
    
    // attributedSubstring - UIFont
    {
    UILabel *label = [[UILabel alloc] init];
    
    label.okidoki.text(@"foo456");
    label.okidoki.attributedSubstring(@"456", [UIFont systemFontOfSize:14]);
    
    NSMutableAttributedString *matts = [[NSMutableAttributedString alloc] initWithString:@"foo456"];
    [matts addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[@"foo456" rangeOfString:@"456"]];

    NSRange range = [@"foo456" rangeOfString:@"456"];
    
    __block NSDictionary *dic1;
    [label.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic1 = attrs;
        NSLog(@"1.attrs:%@",attrs);
    }];
    
    __block NSDictionary *dic2;
    [matts enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic2 = attrs;
        NSLog(@"2.attrs:%@",attrs);
    }];
    
    XCTAssert([dic1[@"NSFont"] isEqual:dic2[@"NSFont"]],@"");
    
    }
    
    // attributedSubstringInRange - UIColor
    {
    NSRange range = NSMakeRange(2, 2);
    
    UILabel *label = [[UILabel alloc] init];
    label.okidoki.text(@"haha123");
    label.okidoki.attributedSubstringInRange(@"haha", [UIColor redColor], [NSValue valueWithRange:range]);
    
    NSMutableAttributedString *matts = [[NSMutableAttributedString alloc] initWithString:@"haha123"];
    [matts addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

    
    __block NSDictionary *dic1;
    [label.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic1 = attrs;
        NSLog(@"1.attrs:%@",attrs);
    }];
    
    __block NSDictionary *dic2;
    [matts enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic2 = attrs;
        NSLog(@"2.attrs:%@",attrs);
    }];
    
    XCTAssert([dic1[@"NSColor"] isEqual:dic2[@"NSColor"]],@"");
    }
    
    // attributedSubstringInRange - UIFont
    {
    
    NSRange range = NSMakeRange(3, 3);
    
    UILabel *label = [[UILabel alloc] init];
    
    label.okidoki.text(@"foofoo456");
    label.okidoki.attributedSubstringInRange(@"456", [UIFont systemFontOfSize:14], [NSValue valueWithRange:range]);
    
    NSMutableAttributedString *matts = [[NSMutableAttributedString alloc] initWithString:@"foofoo456"];
    [matts addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    
    __block NSDictionary *dic1;
    [label.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic1 = attrs;
        NSLog(@"1.attrs:%@",attrs);
    }];
    
    __block NSDictionary *dic2;
    [matts enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic2 = attrs;
        NSLog(@"2.attrs:%@",attrs);
    }];
    
    XCTAssert([dic1[@"NSFont"] isEqual:dic2[@"NSFont"]],@"");
    
    }
    
}

- (void)testFrame{
    CGRect frame = CGRectMake(10, 10, 40, 40);
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 5, 1, 2);
    CGRect frame1 = UIEdgeInsetsInsetRect(frame, inset);
    
    XCTAssert([NSStringFromCGRect(frame1) isEqualToString:NSStringFromCGRect(CGRectMake(15, 15, 33, 34))], @"");
    
}

@end
