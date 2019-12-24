#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MovementDirectionType) {
    
    MovementDirectionForHorizontally = 0,
    MovementDirectionVertically,
};

@protocol CycleImageViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CycleImageView : UIView

@property(nonatomic,weak)id<CycleImageViewDelegate> delegate;

@property(nonatomic,assign)MovementDirectionType movementDirection;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,assign)NSTimeInterval timeInterval;

@property(nonatomic,assign)BOOL hidePageControl;

@property(nonatomic,assign)BOOL canFingersSliding;

@end
