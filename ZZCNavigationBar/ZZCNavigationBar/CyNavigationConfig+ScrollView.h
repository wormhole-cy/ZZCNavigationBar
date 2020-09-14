//
//  CyNavigationConfig+ScrollView.h
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2019/4/12.
//  Copyright © 2019 zzc-20170215. All rights reserved.
//

#import "CyNavigationConfig.h"

NS_ASSUME_NONNULL_BEGIN
@interface CyNavigationBarStateModel : NSObject

@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, assign) CGFloat scrollOffset;

@end

@interface CyNavigationConfig (ScrollView)

@property (nonatomic, strong) CyNavigationBarStateModel *startStateModel;

@property (nonatomic, strong) CyNavigationBarStateModel *endStateModel;


@end

NS_ASSUME_NONNULL_END
