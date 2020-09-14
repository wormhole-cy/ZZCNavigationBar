//
//  UIControl+BlocksKit.m
//  BlocksKit
//

#import <objc/runtime.h>
#import "UIControl+ZZCBlocksKit.h"

static const void *ZZCControlHandlersKey = &ZZCControlHandlersKey;

#pragma mark Private

@interface ZZCControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation ZZCControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
	self = [super init];
	if (!self) return nil;

	self.handler = handler;
	self.controlEvents = controlEvents;

	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	return [[ZZCControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender
{
	self.handler(sender);
}

@end

#pragma mark Category

@implementation UIControl (ZZCBlocksKit)

- (void)zzc_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
	NSParameterAssert(handler);
	
	NSMutableDictionary *events = objc_getAssociatedObject(self, ZZCControlHandlersKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, ZZCControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	NSNumber *key = @(controlEvents);
	NSMutableSet *handlers = events[key];
	if (!handlers) {
		handlers = [NSMutableSet set];
		events[key] = handlers;
	}
	
	ZZCControlWrapper *target = [[ZZCControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
	[handlers addObject:target];
	[self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)zzc_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
	NSMutableDictionary *events = objc_getAssociatedObject(self, ZZCControlHandlersKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, ZZCControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	NSNumber *key = @(controlEvents);
	NSSet *handlers = events[key];

	if (!handlers)
		return;

	[handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
		[self removeTarget:sender action:NULL forControlEvents:controlEvents];
	}];

	[events removeObjectForKey:key];
}

- (BOOL)zzc_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
	NSMutableDictionary *events = objc_getAssociatedObject(self, ZZCControlHandlersKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, ZZCControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	NSNumber *key = @(controlEvents);
	NSSet *handlers = events[key];
	
	if (!handlers)
    {
		return NO;
    }
	
	return handlers.count > 0;
}

@end
