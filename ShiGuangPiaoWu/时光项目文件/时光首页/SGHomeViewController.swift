import UIKit
class SGHomeViewController: SGBaseViewCon,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var SGTable: UITableView!
    fileprivate var SGDataArray = [[String:String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ToolsManager.findHeaderLine(view: self.navigationController!.navigationBar)?.isHidden = true
        self.navigationItem.title = "首页"
        for i in 0 ..< 5 {
            SGDataArray.append(pwArray[i])
        }
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            self.SGTable.delegate = self
            self.SGTable.dataSource = self
            self.SGTable.register(UINib.init(nibName: "SGHomeCell", bundle: nil), forCellReuseIdentifier: "cell")
            self.SGTable.register(UINib.init(nibName: "HomeCell1", bundle: nil), forCellReuseIdentifier: "cell1")
            self.SGTable.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.SGDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SGHomeCell
            cell.superVC = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! HomeCell1
            cell.setDic(dic: self.SGDataArray[indexPath.row - 1])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 370
        }
        return 185
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let vc = DYYDetailViewController()
            vc.SGDic = self.SGDataArray[indexPath.row - 1]
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
