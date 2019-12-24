import UIKit
class SGLoginViewController: SGBaseViewCon {
    @IBOutlet weak var SGTelField: UITextField!
    @IBOutlet weak var SGPwdField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SGTelField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        self.SGPwdField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        self.title = "登录"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func logButtonAction(_ sender: UIButton) {
        if self.SGTelField.text != "" && self.SGPwdField.text != "" {
            var name = ""
            var pwd = ""
            if let arr = UserDefaults.standard.object(forKey: "UserList") as? [[String:Any]] {
                for dic in arr {
                    if (dic["name"] as! String) == self.SGTelField.text {
                        name = dic["name"] as! String
                        pwd = dic["pwd"] as! String
                        break
                    }
                }
                if self.SGTelField.text == name && self.SGPwdField.text == pwd{
                    SVProgressHUD.show()
                    SVProgressHUD.dismiss(withDelay: 1) {
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(self.SGTelField.text!, forKey: "current")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else{
                    SVProgressHUD.show()
                    SVProgressHUD.dismiss(withDelay: 1) {
                        self.view.alertViewMsg(msg: "用户名或密码错误")
                    }
                }
            }
            else{
                SVProgressHUD.show()
                SVProgressHUD.dismiss(withDelay: 1) {
                    self.view.alertViewMsg(msg: "用户名或密码错误")
                }
            }
        }
        else{
            self.view.alertViewMsg(msg: "请填写完整信息")
        }
    }
    @IBAction func zcButtonAction(_ sender: UIButton) {
        let vc = SGRegisterViewController()
        vc.blockAction { [weak self] (dic) in
            self?.SGTelField.text = dic.0
            self?.SGPwdField.text = dic.1
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
