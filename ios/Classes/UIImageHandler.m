//
// Created by Yohom Bao on 2019/11/22.
//

#import "UIImageHandler.h"

extern NSMutableDictionary<NSString *, NSObject *> *STACK;
extern NSMutableDictionary<NSNumber *, NSObject *> *HEAP;
extern BOOL enableLog;

void UIImageHandler(NSString* method, NSDictionary* args, FlutterResult methodResult) {
    // UIImage::getData
    if ([@"UIImage::getData" isEqualToString:method]) {
        NSNumber *refId = (NSNumber *) args[@"refId"];
        
        UIImage *target = (UIImage *) HEAP[refId];
        NSData *data = UIImageJPEGRepresentation(target, 100);
        methodResult([FlutterStandardTypedData typedDataWithBytes:data]);
    }
    // 创建UIImage
    else if ([@"UIImage::createUIImage" isEqualToString:method]) {
        FlutterStandardTypedData *bitmapBytes = (FlutterStandardTypedData *) args[@"bitmapBytes"];
        
        UIImage *bitmap = [UIImage imageWithData:bitmapBytes.data];
        
        HEAP[@(bitmap.hash)] = bitmap;
        
        methodResult(@(bitmap.hash));
    } else {
        methodResult(FlutterMethodNotImplemented);
    }
}
