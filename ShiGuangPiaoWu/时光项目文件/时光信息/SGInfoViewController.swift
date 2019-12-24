import UIKit
class SGInfoViewController: SGBaseViewCon,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    var SGDic = [String:Any]()
    var SGImgPic:UIImagePickerController?
    @IBOutlet weak var SGNameField: UITextField!
    @IBOutlet weak var SGTelField: UITextField!
    @IBOutlet weak var SGSexLabel: UILabel!
    @IBOutlet weak var SGIconButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        self.SGImgPic = UIImagePickerController.init()
        self.SGImgPic?.delegate = self
        self.SGImgPic?.navigationController?.navigationBar.isTranslucent = false
        self.SGImgPic?.allowsEditing = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let current = UserDefaults.standard.object(forKey: "current") as! String
        let arr = UserDefaults.standard.object(forKey: "UserList") as! [[String:Any]]
        for dic in arr {
            if (dic["name"] as! String) == current {
                self.SGDic = dic
                self.SGIconButton.setBackgroundImage(UIImage.init(data: (dic["icon"] as! Data)), for: .normal)
                self.SGNameField.text = dic["nick"] as? String
                self.SGSexLabel.text = dic["xb"] as? String
                self.SGTelField.text = dic["sj"] as? String
                break
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.SGDic["nick"] = self.SGNameField.text!
        self.SGDic["xb"] = self.SGSexLabel.text!
        self.SGDic["sj"] = self.SGTelField.text!
        let current = UserDefaults.standard.object(forKey: "current") as! String
        var arr = UserDefaults.standard.object(forKey: "UserList") as! [[String:Any]]
        for (index,dic) in arr.enumerated() {
            if (dic["name"] as! String) == current {
                arr[index] = self.SGDic
                UserDefaults.standard.set(arr, forKey: "UserList")
                break
            }
        }
    }
    @IBAction func IconButtonAction(_ sender: UIButton) {
        let av = CWBAlertView.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let ac1 = CWBAlertAction.init(title: "打开相机", style: .default) { (_) in
            self.SGPermissionAction(type: .camera)
        }
        let ac2 = CWBAlertAction.init(title: "打开相册", style: .default) { (_) in
            self.SGPermissionAction(type: .photo)
        }
        let ac3 = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        av.addAction(ac1)
        av.addAction(ac2)
        av.addAction(ac3)
        av.show()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func SGPermissionAction(type:PrivacyPermissionType){
       SGPermission.shared().sgPermission(with: type) { (bol, status) in
            if !bol {
                if #available(iOS 10.0, *) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
                    }
                }
            }
            else{
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    DispatchQueue.main.async {
                        if type == PrivacyPermissionType.camera {
                            self.SGImgPic?.sourceType = .camera
                        }
                        else{
                            self.SGImgPic?.sourceType = .photoLibrary
                        }
                        self.present(self.SGImgPic!, animated: true, completion: nil)
                    }
                }
                else{
                    self.view.alertViewMsg(msg: "没有可调用的相册资源！")
                }
            }
        }
    }
    @IBAction func SexButtonAction(_ sender: UIButton) {
        let av = CWBAlertView.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let ac1 = CWBAlertAction.init(title: "男", style: .default) { (_) in
            self.SGSexLabel.text = "男"
        }
        let ac2 = CWBAlertAction.init(title: "女", style: .default) { (_) in
            self.SGSexLabel.text = "女"
        }
        let ac3 = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        av.addAction(ac1)
        av.addAction(ac2)
        av.addAction(ac3)
        av.show()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let img = info[.originalImage] as? UIImage {
                self.SGIconButton.setBackgroundImage(img, for: .normal)
                self.SGDic["icon"] = img.pngData()!
            }
        }
    }
}
