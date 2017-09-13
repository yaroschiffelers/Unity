//
//  main.m
//  CAppleSrcObC
//
//  Created by Yaro Schiffelers on 09-07-17.
//  Copyright © 2017 Yaro Schiffelers. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
