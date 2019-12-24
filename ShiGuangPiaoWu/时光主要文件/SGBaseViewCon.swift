import UIKit
class SGBaseViewCon: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = allPageBackColor
    }
}
class SGNaviCon: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = navgationBarColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
class XFBaseTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = SGHomeViewController()
        vc1.tabBarItem.image = UIImage.init(named: "home1_norm")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage.init(named: "home1_sel")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.title = "首页"
        let nav1 = SGNaviCon.init(rootViewController: vc1)
        let vc2 = FenLeiViewController()
        vc2.tabBarItem.image = UIImage.init(named: "home2_norm")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage.init(named: "home2_sel")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.title = "分类"
        let nav2 = SGNaviCon.init(rootViewController: vc2)
        let vc3 = SGOrderViewController()
        vc3.tabBarItem.image = UIImage.init(named: "home3_norm")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage.init(named: "home3_sel")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.title = "订单"
        let nav3 = SGNaviCon.init(rootViewController: vc3)
        let vc4 = SGMationViewController()
        vc4.tabBarItem.image = UIImage.init(named: "home4_norm")?.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.selectedImage = UIImage.init(named: "home4_sel")?.withRenderingMode(.alwaysOriginal)
        vc4.tabBarItem.title = "我的"
        let nav4 = SGNaviCon.init(rootViewController: vc4)
        self.viewControllers = [nav1,nav2,nav3,nav4]
        self.tabBar.tintColor = navgationBarColor
    }
}
