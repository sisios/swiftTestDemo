import UIKit
class SGResetViewCon: SGBaseViewCon {
    @IBOutlet weak var SGTextField2: UITextField!
    @IBOutlet weak var SGSureButton: UIButton!
    @IBOutlet weak var SGTextField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "重置密码"
        self.SGSureButton.layer.masksToBounds = true
        self.SGSureButton.layer.cornerRadius = 8
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
