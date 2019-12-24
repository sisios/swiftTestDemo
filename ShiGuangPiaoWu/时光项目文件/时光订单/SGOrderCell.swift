import UIKit
class SGOrderCell: UITableViewCell {
    @IBOutlet weak var SGPriceLabel: UILabel!
    @IBOutlet weak var SGImgView: UIImageView!
    @IBOutlet weak var SGTitleLabel: UILabel!
    @IBOutlet weak var SGButton: UIButton!
    @IBOutlet weak var SGSub1Label: UILabel!
    func setDic(dic:[String:Any]) {
        if let key = dic["id"] as? String{
            self.SGSub1Label.text = "订单编号:\(key)"
        }
        if let dd = dic["data"] as? [String:String] {
            if let img = dd["img"]{
                self.SGImgView.image = UIImage.init(named: img)
            }
            if let title = dd["title"] {
                self.SGTitleLabel.text = title
            }
            if let addr = dd["addr"] {
                self.SGPriceLabel.text = addr
            }
        }
    }
}
