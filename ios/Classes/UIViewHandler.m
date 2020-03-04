//
// Created by Yohom Bao on 2019/11/22.
//

#import <Flutter/Flutter.h>
#import "UIViewHandler.h"

extern NSMutableDictionary<NSString *, NSObject *> *STACK;
extern NSMutableDictionary<NSNumber *, NSObject *> *HEAP;
extern BOOL enableLog;

void UIViewHandler(NSString* method, NSDictionary* args, FlutterResult methodResult) {
    // UIImage::getFrame
    if ([@"UIView::getFrame" isEqualToString:method]) {
        NSNumber *refId = (NSNumber *) args[@"refId"];
        
        UIView *target = (UIView *) HEAP[refId];
        
        CGRect rect = [target frame];
        NSValue *dataValue = [NSValue value:&rect withObjCType:@encode(CGRect)];
        
        HEAP[@(dataValue.hash)] = dataValue;
        
        methodResult(@(dataValue.hash));
    } else if ([@"UIView::getHidden" isEqualToString:method]) {
        NSNumber *refId = (NSNumber *) args[@"refId"];
        
        UIView *target = (UIView *) HEAP[refId];
        
        methodResult(@(target.isHidden));
    } else if ([@"UIView::create" isEqualToString:method]) {
        UIView* result = [UIView init];
        methodResult(@(result.hash));
    } else if ([@"UIView::setHidden" isEqualToString:method]) {
        NSNumber* refId = (NSNumber*) args[@"refId"];
        NSNumber* hidden = (NSNumber*) args[@"hidden"];
        
        UIView *target = (UIView *) HEAP[refId];
        
        target.hidden = [hidden boolValue];
        
        methodResult(@"success");
    } else {
        methodResult(FlutterMethodNotImplemented);
    }
}
