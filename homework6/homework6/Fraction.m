//
//  Fraction.m
//  homework6
//
//  Created by WF on 2018/5/3.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction
@synthesize numerator, denominator;

-(id)init{
    self = [super init];
    [self setTo:0 over:1];
    return self;
}
-(void) print{
    NSLog(@"%i/%i",numerator,denominator);
}

-(double) convertToNum{
    if(denominator!= 0)
        return(double) numerator/denominator;
    else
        return NAN;
}

-(void)setTo:(int)n over:(int)d{
    numerator = n;
    denominator =d;
}

-(void) reduce{
    int u =numerator;
    int v =denominator;
    int temp;
    while(v!=0){
        temp = u%v;
        u=v;
        v=temp;
    }
    numerator /=u;
    denominator /=u;
}

-(Fraction *) add: (Fraction *)f{
    
    Fraction * result = [[Fraction alloc] init];
    
    result.numerator = numerator*f.denominator + denominator*f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}

-(Fraction *) subtract: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator *f.denominator - denominator *f.numerator;
    result.denominator = denominator *f.denominator;
    [result reduce];
    return  result;
    
}

-(Fraction *) multiply: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator *f.numerator;
    result.denominator = denominator *f.denominator;
    [result reduce];
    return result;
}

-(Fraction *) divide: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator *f.denominator;
    result.denominator = denominator *f.numerator;
    [result reduce];
    return result;
}

-(NSString*)convertToString{
    if(numerator == denominator){
        if(numerator == 0)
            return @"0";
        else
            return @"1";
    }
    else if(denominator ==1)
        return [NSString stringWithFormat:@"%i",numerator];
    else
        return [NSString stringWithFormat:@"%i/%i",numerator,denominator];
    
}
@end

