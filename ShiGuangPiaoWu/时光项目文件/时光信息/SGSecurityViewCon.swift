import UIKit
class SGSecurityViewCon: SGBaseViewCon {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号与安全"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func btn1Action(_ sender: UIButton) {
        self.navigationController?.pushViewController(SGResetViewCon(), animated: true)
    }
    @IBAction func btn2Action(_ sender: UIButton) {
        let alertVC = CWBAlertView.init(title: "温馨提示", message: "您是否确定注销账号，注销账号将清除您的所有数据，是否继续？", preferredStyle: .alert)
        let sure = CWBAlertAction.init(title: "注销", style: .default) { (_) in
            SVProgressHUD.show()
            SVProgressHUD.dismiss(withDelay: 1, completion: {
                var arr = UserDefaults.standard.object(forKey: "UserList") as! [[String:Any]]
                for (inde,dic) in arr.enumerated() {
                    if (dic["name"] as! String) == (UserDefaults.standard.object(forKey: "current") as! String) {
                        arr.remove(at: inde)
                        UserDefaults.standard.set(arr, forKey: "UserList")
                        self.view.alertViewMsg(msg: "您的账号已注销")
                        UserDefaults.standard.set("", forKey: "current")
                        UserDefaults.standard.set(false, forKey: "isAutoLogin")
                        self.navigationController?.popViewController(animated: true)
                        break
                    }
                }
            })
        }
        let cancel = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        alertVC.addAction(sure)
        alertVC.show()
    }
}
