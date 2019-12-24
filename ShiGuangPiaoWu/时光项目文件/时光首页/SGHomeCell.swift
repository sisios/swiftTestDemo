import UIKit
class SGHomeCell: UITableViewCell,CycleImageViewDelegate {
    @IBOutlet weak var SGTopView: UIView!
    var superVC:UIViewController?
    var cycleView:CycleImageView?
    fileprivate var block:(((Int) -> Void))?
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.cycleView == nil {
            let cycleImageView = CycleImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 180))
            cycleImageView.images = [UIImage.init(named: "banner1")!,UIImage.init(named: "banner2")!,UIImage.init(named: "banner3")!]
            cycleImageView.delegate = self
            cycleImageView.timeInterval = 9
            self.SGTopView.addSubview(cycleImageView)
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let vc = SGMoreViewController()
        vc.title = "近期热门"
        var arr = [[String:String]]()
        for i in 0 ..< 10 {
            arr.append(pwArray[i])
        }
        vc.SGDataArray = arr
        vc.hidesBottomBarWhenPushed = true
        self.superVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        let vc = SGMoreViewController()
        vc.title = "最近开场"
        var arr = [[String:String]]()
        for i in 10 ..< 16 {
            arr.append(pwArray[i])
        }
        vc.SGDataArray = arr
        vc.hidesBottomBarWhenPushed = true
        self.superVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
