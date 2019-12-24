import UIKit
class SGFeedViewController: SGBaseViewCon {
    @IBOutlet weak var SGTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "意见反馈"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func SGSubBtnAction(_ sender: UIButton) {
        if self.SGTextView.text == "" {
            self.view.alertViewMsg(msg: "反馈内容不能为空")
        }
        else{
            SVProgressHUD.show()
            SVProgressHUD.dismiss(withDelay: 1) {
                self.SGTextView.text = "请填写反馈内容...."
                self.view.alertViewMsg(msg: "反馈成功，我们将在1~2个工作日内给您处理，感谢您的反馈")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
