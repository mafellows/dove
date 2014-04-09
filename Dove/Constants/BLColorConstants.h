//
//  BLColorConstants.h
//  Daily Do
//
//  Created by Michael Fellows on 12/18/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#pragma mark - UINavigationBar

#define kBLNavigationBarTint [UIColor colorWithRed: 247 / 255.0 green: 247 / 255.0 blue: 247 / 255.0 alpha: 1.0]
#define kBLNavigationButtonTint [UIColor colorWithRed:255.0 / 255.0 green:149.0 / 255.0  blue:0.0 / 255.0 alpha:1.0]
#define kBLNavigationTint [UIColor colorWithRed:142.0 / 255.0 green:142.0 / 255.0 blue:147.0 / 255.0 alpha:0.8]


