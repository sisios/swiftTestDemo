#import "CycleImageViewCell.h"

@interface CycleImageViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CycleImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

@end
