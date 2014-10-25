//
//  JSON.h
//  Frank
//
//  Created by Pete Hodgson on 10/19/12.
//
//

//#import "AnyJSON.h"

#ifndef Frank_JSON_h
#define Frank_JSON_h


//#define TO_JSON(obj) ([[[NSString alloc] initWithData:AnyJSONEncode((obj), nil) encoding:NSUTF8StringEncoding] autorelease])

#define TO_JSON(obj) ([[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:(obj) options:NSJSONWritingPrettyPrinted error:nil]  encoding:NSUTF8StringEncoding])

//#define FROM_JSON(str) (AnyJSONDecode([(str) dataUsingEncoding:NSUTF8StringEncoding], nil))

#define FROM_JSON(str) ([NSJSONSerialization JSONObjectWithData: [(str) dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: nil])

#endif
