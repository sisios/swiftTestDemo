import UIKit
class SGMationViewController: SGBaseViewCon {
    @IBOutlet weak var SGIconImgView: UIImageView!
    @IBOutlet weak var SGNameLabel: UILabel!
    @IBOutlet weak var SGHcLabel: UILabel!
    @IBOutlet weak var SGTelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.SGTelLabel.text = (UserDefaults.standard.object(forKey: "current") as! String)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.reloadUI()
    }
    func reloadUI(){
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            for dic in (UserDefaults.standard.object(forKey: "UserList") as! [[String:Any]]) {
                if (dic["name"] as! String) == (UserDefaults.standard.object(forKey: "current") as! String) {
                    if let img = dic["icon"] as? Data {
                        self.SGIconImgView.image = UIImage.init(data: img)
                    }
                    if let nick = dic["nick"] as? String {
                        self.SGNameLabel.text = nick
                    }
                    if let tel = dic["sj"] as? String {
                        self.SGTelLabel.text = tel
                    }
                    break
                }
            }
        }
        else{
            self.SGIconImgView.image = UIImage.init(named: "defaultIcon")
            self.SGNameLabel.text = "点击登录"
            self.SGTelLabel.text = ""
        }
    }
    @IBAction func btn1Action(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            let vc = SGMZViewCon()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SGLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btn2Action(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            let vc = SGFeedViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SGLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btn3Action(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            let vc = SGSecurityViewCon()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SGLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btn4Action(_ sender: UIButton) {
        let alertView = CWBAlertView.init(title: "温馨提示", message: "清除所有缓存吗？", preferredStyle: .alert)
        let sureAction = CWBAlertAction.init(title: "确定", style: .default) { (_) in
            ToolsManager.AlertInfoWith(msg: "缓存清除成功！")
            self.SGHcLabel.text = "0.000MB"
        }
        let cancelAction = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        alertView.addAction(sureAction)
        alertView.show()
    }
    @IBAction func btn6Action(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            let alertView = CWBAlertView.init(title: "温馨提示", message: "确定要退出当前账户？", preferredStyle: .alert)
            let sureAction = CWBAlertAction.init(title: "确定", style: .default) { (_) in
                SVProgressHUD.show()
                SVProgressHUD.dismiss(withDelay: 1) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set("", forKey: "current")
                        self.reloadUI()
                    }
                }
            }
            let cancelAction = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alertView.addAction(cancelAction)
            alertView.addAction(sureAction)
            alertView.show()
        }
        else{
            let vc = SGLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func iconBtnAction(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != ""{
            let vc = SGInfoViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SGLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
