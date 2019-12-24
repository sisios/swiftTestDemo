import UIKit
class SGOrderViewController: SGBaseViewCon,UITableViewDataSource,UITableViewDelegate {
    var SGIndex = 0
    var SGDataArray = [[[String:Any]]]()
    var SGViewArray = [UIView]()
    var SGBtnArray = [UIButton]()
    @IBOutlet weak var SGTableView: UITableView!
    @IBOutlet weak var SGView1: UIView!
    @IBOutlet weak var SGBtn1: UIButton!
    @IBOutlet weak var SGClassView: UIView!
    @IBOutlet weak var SGView2: UIView!
    @IBOutlet weak var SGBtn3: UIButton!
    @IBOutlet weak var SGBtn2: UIButton!
    @IBOutlet weak var SGView3: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SGDataArray.removeAll()
        self.navigationController?.navigationBar.isHidden = false
        self.setData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "订单"
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1) {
            self.setDic()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.SGIndex < self.SGDataArray.count {
            return self.SGDataArray[self.SGIndex].count
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SGOrderCell
        if self.SGIndex < self.SGDataArray.count {
            if self.SGDataArray[self.SGIndex].count > 0 {
                cell.setDic(dic: self.SGDataArray[self.SGIndex][indexPath.row])
                cell.SGButton.tag = indexPath.row
                cell.SGButton.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SGDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.SGDic = self.SGDataArray[self.SGIndex][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnAction(btn:UIButton){
        let alertVC = CWBAlertView.init(title: "温馨提示", message: "您是否确定删除该订单？", preferredStyle: .alert)
        let a1 = CWBAlertAction.init(title: "确定", style: .default) { (_) in
            SVProgressHUD.show()
            SVProgressHUD.dismiss(withDelay: 1, completion: {
                self.delAction(inde: btn.tag)
            })
        }
        let a2 = CWBAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(a2)
        alertVC.addAction(a1)
        alertVC.show()
    }
    func delAction(inde:Int){
        self.SGDataArray[self.SGIndex].remove(at: inde)
        var arr = UserDefaults.standard.object(forKey: "ddList") as! [[String : Any]]
        let current = UserDefaults.standard.object(forKey: "current") as! String
        for (_,dic) in arr.enumerated() {
            if (dic["key"] as! String) == current {
                arr = self.SGDataArray[0]
                UserDefaults.standard.set(arr, forKey: "ddList")
                break
            }
        }
        self.SGTableView.reloadData()
        self.setStatus(ind: self.SGIndex)
    }
    @IBAction func btn1Action(_ sender: UIButton) {
        self.SGIndex = 0
        self.setStatus(ind: self.SGIndex)
    }
    @IBAction func btn2Action(_ sender: UIButton) {
        self.SGIndex = 1
        self.setStatus(ind: self.SGIndex)
    }
    @IBAction func btn3Action(_ sender: UIButton) {
        self.SGIndex = 2
        self.setStatus(ind: self.SGIndex)
    }
    func setStatus(ind:Int){
        for (indx,btn) in self.SGBtnArray.enumerated(){
            if indx == ind {
                btn.setTitleColor(UIColor.black, for: .normal)
            }
            else{
                btn.setTitleColor(RGBColor(r: 139, g: 139, b: 153, alpha: 1), for: .normal)
            }
        }
        for (indx,vi) in self.SGViewArray.enumerated(){
            vi.isHidden = indx != ind
        }
        if self.SGIndex < self.SGDataArray.count {
            self.SGClassView.isHidden = self.SGDataArray[self.SGIndex].count != 0
        }
        else{
            self.SGClassView.isHidden = false
        }
        self.SGTableView.reloadData()
    }
    func setDic(){
        self.SGTableView.backgroundColor = allPageBackColor
        self.SGTableView.register(UINib.init(nibName: "SGOrderCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.SGBtnArray = [self.SGBtn1,self.SGBtn2,self.SGBtn3]
        self.SGViewArray = [self.SGView1,self.SGView2,self.SGView3]
        self.SGTableView.delegate = self
        self.SGTableView.dataSource = self
        self.SGTableView.reloadData()
    }
    func setData(){
        let arr = UserDefaults.standard.object(forKey: "ddList") as! [[String : Any]]
        let current = UserDefaults.standard.object(forKey: "current") as! String
        var arr1 = [[String:Any]]()
        var arr2 = [[String:Any]]()
        let arr3 = [[String:Any]]()
        for dic in arr {
            if (dic["key"] as! String) == current {
                if (dic["status"] as! String) == "0" {
                    arr1.append(dic)
                }
                else {
                    arr2.append(dic)
                }
            }
        }
        self.SGDataArray.append(arr1)
        self.SGDataArray.append(arr3)
        self.SGDataArray.append(arr2)
        self.setStatus(ind: self.SGIndex)
    }
}
