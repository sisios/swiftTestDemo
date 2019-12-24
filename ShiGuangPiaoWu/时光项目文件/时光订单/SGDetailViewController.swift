import UIKit
class SGDetailViewController: SGBaseViewCon {
    var SGDic:[String:Any]?
    @IBOutlet weak var SGDImgView: UIImageView!
    @IBOutlet weak var SGImgView: UIImageView!
    @IBOutlet weak var SGTitleLabel: UILabel!
    @IBOutlet weak var SGAddrLabel: UILabel!
    @IBOutlet weak var SGSub1Label: UILabel!
    @IBOutlet weak var SGSub2Label: UILabel!
    @IBOutlet weak var SGSub3Label: UILabel!
    @IBOutlet weak var SGSub4Label: UILabel!
    @IBOutlet weak var SGSub5Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        self.SGDImgView.layer.masksToBounds = true
        self.SGDImgView.layer.cornerRadius = 4
        self.SGImgView.image = UIImage.generateQRCode("订单编号:\(self.SGDic!["key"]!),扫描失败，请检查您的设备是否为专用设备，或者请检查您的二维码是否正确。", 120, nil, .black)
        if let sub1 = self.SGDic!["sub1"] as? String {
            self.SGSub1Label.text = "票据时间:\(sub1)"
        }
        if let sub2 = self.SGDic!["sub2"] as? String {
            self.SGSub2Label.text = "参与人数:\(sub2)"
        }
        if let sub3 = self.SGDic!["sub3"] as? String {
            self.SGSub3Label.text = "票据类型:\(sub3)"
        }
        if let sub4 = self.SGDic!["sub4"] as? String {
            self.SGSub4Label.text = "手机号:\(sub4)"
        }
        if let sub5 = self.SGDic!["sub5"] as? String {
            self.SGSub5Label.text = "联系人:\(sub5)"
        }
        if let dd = self.SGDic!["data"] as? [String:String] {
            if let img = dd["img"] {
                self.SGDImgView.image = UIImage.init(named: img)
            }
            if let title = dd["title"] {
                self.SGTitleLabel.text = title
            }
            if let addr = dd["addr"] {
                self.SGAddrLabel.text = addr
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}
