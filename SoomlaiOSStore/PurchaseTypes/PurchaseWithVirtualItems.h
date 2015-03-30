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

#import "PurchaseType.h"

/**
 This type of purchase allows users to purchase PurchasableVirtualItems with MULTIPLE other VirtualItems.

 Real Game Example: Purchase an 'Axe' in exchange for 100 'Gem's and 5 'Steel'. 'Sword' is the item to be purchased,
 which can be purchased for 100 'Gem's and 5 'Steel'.
*/
@interface PurchaseWithVirtualItems : PurchaseType {
}

@property (readonly, nonatomic) NSDictionary* targetItemIdsToAmounts;

/**
 Constructor

 @param oTargetItemId - The itemIds of the VirtualItems that is used to "pay" in order 
 to make the purchase associated with the corresponding price.
 */
- (id) initWithDictionary:(NSDictionary*)oTargetItemIdsToAmounts;

@end
