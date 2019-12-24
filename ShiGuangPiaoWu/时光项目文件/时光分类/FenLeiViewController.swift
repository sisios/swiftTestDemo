import UIKit

class FenLeiViewController: SGBaseViewCon ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var dataArray1 = [[String:String]]()
    fileprivate var dataArray2 = [[String:String]]()
    
    @IBOutlet weak var btn1: UIButton!
    fileprivate var index = 0
    @IBOutlet weak var btn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        for i in 0 ..< 10 {
            self.dataArray1.append(pwArray[i])
        }
        for i in 10 ..< 16 {
            self.dataArray2.append(pwArray[i])
        }
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib.init(nibName: "HomeCell1", bundle: nil), forCellReuseIdentifier: "cell")
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.index == 0 ? self.dataArray1.count : self.dataArray2.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell1
        if self.index == 0 {
            cell.setDic(dic: self.dataArray1[indexPath.row])
        }
        else{
            cell.setDic(dic: self.dataArray2[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DYYDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        if self.index == 0 {
            vc.SGDic = self.dataArray1[indexPath.row]
        }
        else{
            vc.SGDic = self.dataArray2[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn1Action(_ sender: UIButton) {
        self.setStatus(0)
    }
    @IBAction func btn2Action(_ sender: UIButton) {
        self.setStatus(1)
    }
    fileprivate func setStatus(_ ind:Int){
        if self.index != ind {
            self.index = ind
            if ind == 0 {
                self.btn1.setImage(UIImage.init(named: "tyImg4"), for: .normal)
                self.btn2.setImage(UIImage.init(named: "tyImg5"), for: .normal)
            }
            else{
                self.btn1.setImage(UIImage.init(named: "tyImg6"), for: .normal)
                self.btn2.setImage(UIImage.init(named: "tyImg7"), for: .normal)
            }
            self.tableView.reloadData()
        }
    }
}
