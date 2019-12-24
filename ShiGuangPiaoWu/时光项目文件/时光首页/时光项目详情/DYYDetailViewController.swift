import UIKit
class DYYDetailViewController: SGBaseViewCon,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var SGTableView: UITableView!
    var SGDic = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            self.SGTableView.delegate = self
            self.SGTableView.dataSource = self
            self.SGTableView.register(UINib.init(nibName: "SGXMDetailCell1", bundle: nil), forCellReuseIdentifier: "cell1")
            self.SGTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.SGTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! SGXMDetailCell1
        cell.setDic(dic: self.SGDic)
        cell.superVC = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 890
    }
    @IBAction func lxBtnAction(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != "" {
            DispatchQueue.main.async {
                UIApplication.shared.openURL(URL.init(string: "tel:(+86)-18408249304")!)
            }
        }
        else{
            let vc = SGLoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func ydBtnAction(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "current") as! String) != "" {
            let vc = SGYDViewController()
            vc.SGDic = self.SGDic
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SGLoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
