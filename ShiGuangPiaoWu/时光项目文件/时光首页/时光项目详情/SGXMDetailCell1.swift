import UIKit
class SGXMDetailCell1: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var margin: NSLayoutConstraint!
    var superVC:UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.margin.constant = KIsiPhoneX ? 40 : 20
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
    @IBAction func returnAction(_ sender: UIButton) {
        self.superVC?.navigationController?.popViewController(animated: true)
    }
}
