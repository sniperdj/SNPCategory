//
//  ViewController.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "ViewController.h"
#import "SNPCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ARRAY ------------------
//    NSMutableArray *arr1 = [NSMutableArray array];
//    [arr1 addObject:@"0"];
//    [arr1 addObject:@"1"];
//    NSLog(@"aaa : %@", arr1[3]);
//    NSArray *arr11 = @[arr1, @"2"];
//    NSMutableArray *marrCpDeep = [arr11 mutableCopyDeeply];
//
//    NSLog(@"arr11 == marrCpDeep: %d", arr1 == arr11);
//    NSLog(@"arr11 : %@", arr11);
//    NSLog(@"marrCpDeep : %@", marrCpDeep);
//
//    NSMutableArray *arrX = arr11[0];
//    arrX[1] = @"11";
//
//    NSLog(@"arr11 : %@", arr11);
//    NSLog(@"marrCpDeep : %@", marrCpDeep);
    
}
#pragma mark - Test UIButton Category
- (void)testBtnCategory {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    //    [btn btnOfAreaWithTop:0 left:40 bottom:40 right:40];
    [btn btnOfEdge:10];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnclick:(UIButton *)btn {
    NSLog(@"btn clicked");
}
#pragma mark - Test String Category
- (void)testStringCategory {
//    NSString *strJSON = @"{\"a\" : \"1\", \"b\" : \"2\"}";
//    NSLog(@"dict : %@", strJSON.strToDict());
//
//    NSString *strInt = @"11";
//    NSLog(@"int : %d", strInt.strToInt());
//    NSString *strInteger = @"16";
//    NSLog(@"integer : %ld", strInteger.strToInteger());
//    NSString *strDouble = @"60.051";
//    NSLog(@"double : %.3f", strDouble.strToDouble());
//    NSString *strFloat = @"3.5";
//    NSLog(@"float : %.2f", strFloat.strToFloat());

}


@end
