import UIKit
class SGMoreViewController: SGBaseViewCon,UITableViewDelegate,UITableViewDataSource {
    var SGDataArray = [[String:String]]()
    
    @IBOutlet weak var SGTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            self.SGTableView.delegate = self
            self.SGTableView.dataSource = self
            self.SGTableView.register(UINib.init(nibName: "HomeCell1", bundle: nil), forCellReuseIdentifier: "cell")
            self.SGTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.SGDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell1
        cell.setDic(dic: self.SGDataArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DYYDetailViewController()
        vc.SGDic = self.SGDataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
