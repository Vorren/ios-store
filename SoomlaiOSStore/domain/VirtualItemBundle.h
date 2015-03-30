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

#import "VirtualGood.h"
/**
 A VirtualItemBundle allows to group different  VirtualItems into a single purchasable  VirtualGood</c>
 The  VirtualItemBundle's characteristics are:
 1. Can be purchased an unlimited number of times.
 2. Doesn't have a balance in the database. The  VirtualItems that are associated with this bundle
    have their own balance. When your users buy a  VirtualItemBundle, the balance of the associated
     VirtualItem goes up in the specified amount.
 Real Game Examples: 'Box Of Chocolates' and '10 Swords' for '5 Gems'

 NOTE: In case you want this item to be available for purchase in the market (PurchaseWithMarket),
 you will need to define the item in the market (Apple App Store, Google Play, Amazon App Store, etc...).

*/
@interface VirtualItemBundle : VirtualGood{
}

@property (readonly, nonatomic) NSDictionary* itemIdsToAmounts;

/**
 Constructor
 @param oItemIdsToAmounts Associative collection of virtual items ids (NSString *) as keys and their respective amounts (NSNumber *) as values.
 @param oName see parent
 @param oDescription see parent
 @param oItemId see parent
 @param oPurchaseType see parent
 */
- (id)initWithItemToAmountDictionary:(NSDictionary *)oItemIdsToAmounts andName:(NSString *)oName andDescription:(NSString *)oDescription andItemId:(NSString *)oItemId andPurchaseType:(PurchaseType *)oPurchaseType;

@end
