import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaults.standard.object(forKey: "current") == nil {
            UserDefaults.standard.set("", forKey: "current")
        }
        if (UserDefaults.standard.object(forKey: "ddList") == nil) {
            UserDefaults.standard.set([], forKey: "ddList")
        }
        if UserDefaults.standard.object(forKey: "UserList") == nil {
            let arr = NSMutableArray()
            let imgData = UIImage.init(named: "myIcon")!.pngData()!
            let dic = ["name":"18408249730","pwd":"123456","icon":imgData,"nick":"购票者","xb":"男","sj":"18408249730"] as [String : Any]
            arr.add(dic)
            UserDefaults.standard.set(arr, forKey: "UserList")
        }
        self.window?.rootViewController = XFBaseTabBar()
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0;
            UITableView.appearance().estimatedSectionFooterHeight = 0;
            UITableView.appearance().estimatedSectionHeaderHeight = 0;
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
        }
        self.window?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.window!.makeKeyAndVisible()
        return true
    }
}
