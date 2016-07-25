//
//  NSNull+NullSafe_Yang.m
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/25.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#import "NSNull+NullSafe_Yang.h"


@implementation NSNull (NullSafe_Yang)

#if NULLSAFE_ENABLED

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    @synchronized ([self class]) {
        //look up method signature
        NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
        if (!signature) {
            //not supported by NSNull search other classes
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            if (signatureCache == nil) {
                classList = [[NSMutableSet alloc]init];
                signatureCache = [[NSMutableDictionary alloc]init];
                
                //get class list
                int numClasses = objc_getClassList(NULL , 0);
                Class *classes = (Class *)malloc(sizeof(Class) *(unsigned long)numClasses);
                numClasses = objc_getClassList(classes, numClasses);
                
                //add to list checking
                NSMutableSet *exculded = [NSMutableSet set ];
                for (int i = 0; i < numClasses; i++) {
                    //determine if class has a superclass
                    Class someClass = classes[i];
                    Class superclass = class_getSuperclass(someClass);
                    while (superclass) {
                        if (superclass == [NSObject class]) {
                            
                            [classList addObject:someClass];
                            break;
                        }
                        [exculded addObject:NSStringFromClass(superclass)];
                        superclass = class_getSuperclass(superclass);
                    }
                    
                }
                //remove all classes that subclasses
                for (Class someclass in exculded) {
                    [classList removeObject:someclass];
                }
                //free class list
                free(classes);
            }
            
            //check implementation cache first
            NSString *selectorString = NSStringFromSelector(aSelector);
            signature = signatureCache[selectorString];
            if (!signature) {
                //finde implementation
                for (Class someclass in classList) {
                    if ([someclass instancesRespondToSelector:aSelector]) {
                        signature = [someclass instanceMethodSignatureForSelector:aSelector];
                        break;
                    }
                }
                //cache for next time
                signatureCache[selectorString] = signature?:[NSNull null];
            }else if ([signature isKindOfClass:[NSNull class]]){
                signature = nil;
            }
        }
        return signature;
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    anInvocation.target = nil;
    [anInvocation invoke];
}
#endif


@end
