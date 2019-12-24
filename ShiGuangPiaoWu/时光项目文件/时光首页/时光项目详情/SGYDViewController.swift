import UIKit
class SGYDViewController: SGBaseViewCon {
    var SGDic = [String:String]()
    @IBOutlet weak var SGTimeLabel: UILabel!
    @IBOutlet weak var SGImgView: UIImageView!
    @IBOutlet weak var SGTitleLabel: UILabel!
    @IBOutlet weak var SGAddrLabel: UILabel!
    @IBOutlet weak var SGSureBtn: UIButton!
    @IBOutlet weak var SGBtn2: UIButton!
    @IBOutlet weak var SGTelLabel: UILabel!
    @IBOutlet weak var SGLxtTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "预定"
        self.SGImgView.layer.masksToBounds = true
        self.SGImgView.layer.cornerRadius = 4
        self.SGSureBtn.layer.masksToBounds = true
        self.SGSureBtn.layer.cornerRadius = 20
        if let title = SGDic["title"] {
            self.SGTitleLabel.text = title
        }
        if let addr = SGDic["addr"] {
            self.SGAddrLabel.text = addr
        }
        if let time = SGDic["time"] {
            self.SGTimeLabel.text = time
        }
        if let img = SGDic["img"] {
            self.SGImgView.image = UIImage.init(named: img)
        }
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd HH:mm"
        for dic in (UserDefaults.standard.object(forKey: "UserList") as! [[String:Any]]) {
            if (dic["name"] as! String) == (UserDefaults.standard.object(forKey: "current") as! String) {
                self.SGTelLabel.text = dic["sj"] as? String
                self.SGLxtTextField.text = dic["nick"] as? String
                break
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func sureBtnAction(_ sender: UIButton) {
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            let dateF = DateFormatter()
            dateF.dateFormat = "yyyyMMddHHmmss"
            let dd = ["status":"0","key":(UserDefaults.standard.object(forKey: "current") as! String),"id":dateF.string(from: Date()),"data":self.SGDic,"sub1":self.SGTimeLabel.text!,"sub2":self.SGBtn2.titleLabel!.text!,"sub3":"演唱会门票","sub4":self.SGTelLabel.text!,"sub5":self.SGLxtTextField.text!] as [String : Any]
            var arr = UserDefaults.standard.object(forKey: "ddList") as! [[String:Any]]
            arr.append(dd)
            UserDefaults.standard.set(arr, forKey: "ddList")
            let vc = SGDetailViewController()
            vc.SGDic = dd
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
            let vi = CWBAlertView.init(title: "温馨提示", message: "您的门票预定成功，请您准时参加，否则视为放弃该门票。", preferredStyle: .alert)
            let sure = CWBAlertAction.init(title: "确定", style: .default, handler: nil)
            vi.addAction(sure)
            vi.show()
        }
    }
    @IBAction func btn2Action(_ sender: UIButton) {
        let ac = CWBAlertView.init(title: "选择人数", message: nil, preferredStyle: .actionSheet)
        let a1 = CWBAlertAction.init(title: "1人", style: .default) { (_) in
            self.SGBtn2.setTitle("1人", for: .normal)
        }
        let a2 = CWBAlertAction.init(title: "2人", style: .default) { (_) in
            self.SGBtn2.setTitle("2人", for: .normal)
        }
        let a3 = CWBAlertAction.init(title: "3人", style: .default) { (_) in
            self.SGBtn2.setTitle("3人", for: .normal)
        }
        let a4 = CWBAlertAction.init(title: "更多", style: .default) { (_) in
            self.SGBtn2.setTitle("更多", for: .normal)
        }
        let a5 = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        ac.addAction(a1)
        ac.addAction(a2)
        ac.addAction(a3)
        ac.addAction(a4)
        ac.addAction(a5)
        ac.show()
    }
}
