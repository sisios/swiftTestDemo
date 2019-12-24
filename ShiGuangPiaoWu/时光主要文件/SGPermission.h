#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,PrivacyPermissionType) {
    PrivacyPermissionTypePhoto = 0,
    PrivacyPermissionTypeCamera,
    PrivacyPermissionTypeMedia,
    PrivacyPermissionTypeMicrophone,
    PrivacyPermissionTypeLocation,
    PrivacyPermissionTypeBluetooth,
    PrivacyPermissionTypePushNotification,
    PrivacyPermissionTypeSpeech,
    PrivacyPermissionTypeEvent,
    PrivacyPermissionTypeContact,
    PrivacyPermissionTypeReminder,
};
typedef NS_ENUM(NSUInteger,PrivacyPermissionAuthorizationStatus) {
    PrivacyPermissionAuthorizationStatusAuthorized = 0,
    PrivacyPermissionAuthorizationStatusDenied,
    PrivacyPermissionAuthorizationStatusNotDetermined,
    PrivacyPermissionAuthorizationStatusRestricted,
    PrivacyPermissionAuthorizationStatusLocationAlways,
    PrivacyPermissionAuthorizationStatusLocationWhenInUse,
    PrivacyPermissionAuthorizationStatusUnkonwn,
};
@interface SGPermission : NSObject
+ (instancetype)shared;
-(void)SGPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion;
@end
