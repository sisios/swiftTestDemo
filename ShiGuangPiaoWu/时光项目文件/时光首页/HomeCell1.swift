import UIKit

class HomeCell1: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var addrLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.cornerRadius = 4
    }
    func setDic(dic:[String:String]){
        if let img = dic["img"] {
            self.imgView.image = UIImage.init(named: img)
        }
        if let title = dic["title"] {
            self.titleLabel.text = title
        }
        if let time = dic["time"] {
            self.timeLabel.text = time
        }
        if let addr = dic["addr"] {
            self.addrLabel.text = addr
        }
        if let price = dic["price"] {
            self.priceLabel.text = "\(price)元起"
        }
    }
}
