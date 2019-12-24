#import "SGPermission.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
static SGPermission *_instance = nil;
@implementation SGPermission
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copyWithZone:(nullable NSZone *)zone {
    return _instance;
}
- (void)SGPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion API_AVAILABLE(ios(10.0)){
    switch (type) {
        case PrivacyPermissionTypePhoto: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied) {
                    completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == PHAuthorizationStatusRestricted) {
                    completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }break;
            
        case PrivacyPermissionTypeCamera: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == AVAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
        default:
            break;
    }
}
@end
