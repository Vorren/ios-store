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

#import "PurchaseWithVirtualItems.h"
#import "SoomlaUtils.h"
#import "VirtualItem.h"
#import "StoreEventHandling.h"
#import "PurchasableVirtualItem.h"
#import "VirtualItemStorage.h"
#import "StorageManager.h"
#import "InsufficientFundsException.h"
#import "StoreInfo.h"
#import "VirtualItemNotFoundException.h"
#import "VirtualItem.h"

@implementation PurchaseWithVirtualItems

static NSString* TAG = @"SOOMLA PurchaseWithVirtualItems";

- (id) initWithDictionary:(NSDictionary *)oTargetItemIdsToAmounts{
    if (self = [super init]) {
        _targetItemIdsToAmounts = oTargetItemIdsToAmounts;
    }

    return self;
}

/*
 see parent
 */
- (void)buyWithPayload:(NSString*)payload {
    //logging
#ifndef NDEBUG
    NSMutableString * logMessageBuilder = [NSMutableString stringWithFormat:@"Trying to buy a %@ with: ", associatedItem.name ];

    for(NSString * itemId in _targetItemIdsToAmounts){
        NSNumber * amount = [_targetItemIdsToAmounts objectForKey:itemId];
        [logMessageBuilder appendFormat:@"%@ pieces of %@; ", itemId, amount];
    }

    LogDebug(TAG, logMessageBuilder);
#endif

    //event starts
    [StoreEventHandling postItemPurchaseStarted:self.associatedItem.itemId];

    //null checking and balance checking
    for(NSString * itemId in _targetItemIdsToAmounts){
        VirtualItem* item = NULL;
        @try {
            item = [[StoreInfo getInstance] virtualItemWithId:itemId];
        } @catch (VirtualItemNotFoundException* ex) {
            NSString * errorMessage = [NSString stringWithFormat:@"Target virtual item %@ doesn't exist !", itemId];
            LogError(TAG, errorMessage);
            return;
        }

        NSNumber * amount = [_targetItemIdsToAmounts objectForKey:itemId];
        VirtualItemStorage* storage = [[StorageManager getInstance] virtualItemStorage:item];

        assert(storage);

        int balance = [storage balanceForItem:item.itemId];
        if (balance < [amount integerValue]) {
            @throw [[InsufficientFundsException alloc] initWithItemId:itemId];
        }

        [storage removeAmount:amount fromItem:item.itemId];
    }

    //give associated item and wrap up the event
    [self.associatedItem giveAmount:1];
    [StoreEventHandling postItemPurchased:self.associatedItem.itemId withPayload:payload];
}


@end