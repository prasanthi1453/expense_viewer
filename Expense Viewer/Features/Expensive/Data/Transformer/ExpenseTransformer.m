//
//  ExpenseTransformer.m
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


#import "ExpenseTransformer.h"

@implementation ExpenseTransformer

- (NSArray *)transform:(NSData *)data {
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error || ![json isKindOfClass:[NSArray class]]) {
        return @[];
    }
    
    NSArray *jsonArray = (NSArray *)json;
    NSMutableArray *result = [NSMutableArray array];
        
    for (NSDictionary *dict in jsonArray) {
        if (![dict isKindOfClass:[NSDictionary class]]) { continue; }
        
        NSMutableDictionary *expense = [NSMutableDictionary dictionary];
        
        id idvalue = dict[@"id"];
        if (idvalue) { expense[@"id"] = idvalue; }
        
        id title = dict[@"title"];
        if (title) { expense[@"title"] = title; }
        
        NSNumber *amountNumber = dict[@"amount"];
        if ([amountNumber isKindOfClass:[NSNumber class]]) {
            expense[@"amount"] = @([amountNumber doubleValue]);
        }
        
        NSString *dateString = [dict[@"date"] isKindOfClass:[NSString class]] ? dict[@"date"] : nil;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssXXXXX";
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        
        NSDate *date = dateString ? [formatter dateFromString:dateString] : nil;
        if (date) { expense[@"date"] = date; }
        
        [result addObject:[expense copy]];
    }
    
    return [result copy];
}

@end