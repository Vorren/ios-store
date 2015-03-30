/*
 Copyright (C) 2015 Philipp Maevskiy
 Copyright (C) 2012-2014 Soomla Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


#import "VirtualItemBundle.h"

#import "SingleUsePackVG.h"
#import "StoreJSONConsts.h"
#import "StorageManager.h"
#import "VirtualGoodStorage.h"
#import "SingleUseVG.h"
#import "StoreInfo.h"
#import "SoomlaUtils.h"
#import "VirtualItemNotFoundException.h"

@implementation VirtualItemBundle

static NSString* TAG = @"SOOMLA VirtualItemBundle";

- (id)initWithItemToAmountDictionary:(NSDictionary *)oItemIdsToAmounts andName:(NSString *)oName andDescription:(NSString *)oDescription andItemId:(NSString *)oItemId andPurchaseType:(PurchaseType *)oPurchaseType {

    if (self = [super initWithName:oName andDescription:oDescription andItemId:oItemId andPurchaseType:oPurchaseType]) {
        _itemIdsToAmounts = oItemIdsToAmounts;
    }

    return self;
}

/**
 see parent

 @param dict see parent.
 */
- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _itemIdsToAmounts = [dict objectForKey:VIB_ITEMS_ARRAY];
    }

    return self;
}

/**
 see parent

 @return see parent.
 */
- (NSDictionary*)toDictionary {
    NSDictionary* parentDict = [super toDictionary];

    NSMutableDictionary* toReturn = [[NSMutableDictionary alloc] initWithDictionary:parentDict];
    [toReturn setValue: _itemIdsToAmounts forKey: VIB_ITEMS_ARRAY];

    return toReturn;
}

/**
 Will give a certain amount of VirtualItems stored in itemIdsToAmounts.
 Always returns 0.
 see parent

 @param oAmount see parent.
 @return see parent.
 */
- (int)giveAmount:(int)oAmount withEvent:(BOOL)notify {

    for(NSString * itemId in _itemIdsToAmounts){
        VirtualItem * item = (VirtualItem*)[[StoreInfo getInstance] virtualItemWithId:itemId];
        int amount = [(NSNumber *)[_itemIdsToAmounts objectForKey: itemId] intValue];
        [item giveAmount:amount * oAmount withEvent: notify];
    }

    return 0;
}

/**
 Will take a certain amount of <c>VirtualItem</c>s stored in itemsToAmounts.
 Always returns 0.
 see parent

 @param oAmount see parent.
 @return see parent.
 */
- (int)takeAmount:(int)oAmount withEvent:(BOOL)notify {

    for(NSString * itemId in _itemIdsToAmounts){
        VirtualItem * item = (VirtualItem*)[[StoreInfo getInstance] virtualItemWithId:itemId];
        int amount = [(NSNumber *)[_itemIdsToAmounts objectForKey: itemId] intValue];
        [item takeAmount:amount * oAmount withEvent: notify];
    }

    return 0;
}


/**
 DON'T APPLY FOR A BUNDLE
 see parent

 @param balance see parent.
 @param notify see parent.
 @return see parent.
 */
- (int)resetBalance:(int)balance withEvent:(BOOL)notify {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Someone tried to reset balance of ItemBundle. That's not right."
                                 userInfo:nil];
}

/*
 see parent

 @return see parent.
 */
- (BOOL)canBuy {
    return YES;
}

@end