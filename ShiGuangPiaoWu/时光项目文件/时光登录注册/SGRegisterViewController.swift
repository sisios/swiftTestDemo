import UIKit
class SGRegisterViewController: SGBaseViewCon {
    fileprivate var block:(((String,String)) -> Void)?
    @IBOutlet weak var SGTelField: UITextField!
    @IBOutlet weak var SGPwdField: UITextField!
    @IBOutlet weak var SGPwdField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SGTelField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        self.SGPwdField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        self.SGPwdField1.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        self.title = "注册"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func blockAction(bk:@escaping (((String,String)) -> Void)){
        self.block = bk
    }
    @IBAction func zcAction(_ sender: UIButton) {
        if self.SGTelField.text != "" && self.SGPwdField.text != "" && self.SGPwdField1.text != "" {
            if self.SGPwdField1.text == self.SGPwdField.text  {
                SVProgressHUD.show()
                SVProgressHUD.dismiss(withDelay: 1) {
                    if var arr = UserDefaults.standard.object(forKey: "UserList") as? [[String:Any]] {
                        let imgData = UIImage.init(named: "defaultIcon")!.pngData()!
                        let dic = ["name":self.SGTelField.text!,"pwd":self.SGPwdField.text!,"icon":imgData,"nick":"admin","xb":"","sj":self.SGTelField.text!] as [String : Any]
                        arr.append(dic)
                        UserDefaults.standard.set(arr, forKey: "UserList")
                    }
                    self.view.alertViewMsg(msg: "注册成功")
                    self.navigationController?.popViewController(animated: true)
                    if self.block != nil {
                        self.block!((self.SGTelField.text!,self.SGPwdField.text!))
                    }
                }
            }
            else{
                self.view.alertViewMsg(msg: "两个密码不一直。")
            }
        }
        else{
            self.view.alertViewMsg(msg: "请填写完整信息")
        }
    }
}
