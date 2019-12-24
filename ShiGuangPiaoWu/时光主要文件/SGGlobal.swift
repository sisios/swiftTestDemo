import UIKit
import UIKit
import Foundation
let isIphone5s = UIScreen.main.bounds.size.width == 320
let navgationBarColor = RGBColor(r: 124, g: 91, b: 254, alpha: 1)
extension UIView{
    func alertViewMsg(msg:String?) {
        DispatchQueue.main.async {
            let alertView = CWBAlertView.init(title: "温馨提示", message: msg, preferredStyle: .alert)
            let sureAction = CWBAlertAction.init(title: "确定", style: .cancel, handler: nil)
            alertView.addAction(sureAction)
            alertView.show()
        }
    }
}
let pwArray = [["id":"011","city":"电影票","img":"xfImg1","title":"简弘亦“亦X不染”演唱会北京站","addr":"北京市 | 北京展览馆剧场","time":"2019.09.27 周五 19:30","price":"260"],["id":"021","city":"电影票","img":"xfImg2","title":"【北京站】萧敬腾娱乐先生巡回演唱会绍兴站","addr":"奥体中心体育馆 ","time":"2019.10.26 周六 19:30","price":"380"],["id":"031","city":"电影票","img":"xfImg3","title":"【上海站】2019摩登兄弟“成长风暴”巡回演唱会上海站","addr":"上海市 | 梅赛德斯-奔驰文化中心","time":"2019.08.31 周六 19:30","price":"380"],["id":"041","city":"电影票","img":"xfImg4","title":"【南京】2019张韶涵「寓言」世界巡回演唱会-南京站","addr":"南京 | 南京奥体中心体育馆","time":"2019.10.26 周六 19:30","price":"380"],["id":"051","city":"电影票","img":"xfImg5","title":"【武汉】欧阳娜娜十周年巡回音乐会武汉站","addr":"武汉市 | 武汉客厅·中国文化博览中心A馆 ","time":"2019.08.29 周四 19:30","price":"280"],["id":"061","city":"电影票","img":"xfImg6","title":"【北京站】2019潘玮柏创使者Cominghome巡回演唱会","addr":"华熙LIVE凯迪拉克中心(原五棵松体育馆)","time":"2019.10.13  19:00","price":"240"],["id":"071","city":"电影票","img":"xfImg7","title":"【北京站】五月天Mayday2019JustRockIt!!!蓝|BLUE","addr":"国家体育场—鸟巢","time":"2019.08.23 周五 18:30","price":"255"],["id":"081","city":"电影票","img":"xfImg8","title":"【北京站】刘瑞琦2019“温暖的房间”巡回演唱会","addr":" 北京展览馆剧场","time":"2019.10.25 周五 19:30","price":"180"],["id":"0111","city":"电影票","img":"xfImg9","title":"华艺星空·QUEEN REALTRIBUTE皇后致敬乐队演唱会《波西米亚狂想曲》","addr":"北京展览馆剧场","time":"2019.09.07 19:30","price":"120"],["id":"0211","city":"电影票","img":"xfImg10","title":"【天津】MC HotDog 热狗2019“废欲清”全国巡演-天津站","addr":"天津市 | 大麦66LiveHouse ","time":"2019.08.24 周六 19:30","price":"380"],["id":"0311","city":"电影票","img":"xfImg11","title":"【苏州】2019 张韶涵「寓言」世界巡回演唱会-苏州站","addr":"苏州市 | 苏州市体育中心体育场","time":"2019.11.23 周六 19:30","price":"380"],["id":"0411","city":"电影票","img":"xfImg12","title":"【福州】伍佰 China Blue Rock Star2019演唱会福州站","addr":"福州市 | 福州海峡奥林匹克体育中心综合馆 ","time":"2019.11.30 周六 19:30","price":"280"],["id":"0511","city":"电影票","img":"xfImg13","title":"【南宁】MY BEAUTIFUL LIVE杨千嬅世界巡回演唱会-南宁站","addr":"南宁市 | 广西体育中心体育场","time":"2019.11.02 周六 20:00","price":"389"],["id":"0611","city":"电影票","img":"xfImg14","title":"【武汉】2019 张韶涵「寓言」世界巡回演唱会-武汉站","addr":"武汉市 | 武汉客厅·中国文化博览中心A馆 ","time":"2019.12.07 周六 19:30","price":"380"],["id":"0711","city":"电影票","img":"xfImg15","title":"【海口】“Cherish 珍晰”王晰个人巡回音乐会-海口站","addr":"海南国际会展中心东方环球大剧院 ","time":"2019.11.16 周六 19:30","price":"280"],["id":"0811","city":"电影票","img":"xfImg16","title":"【长沙】2019张信哲世界巡回演唱会长沙站——未来式","addr":"长沙市 | 湖南国际会展中心 ","time":"2019.11.30 周六 19:30","price":"380"]]
let isIphonePlus = UIScreen.main.bounds.size.width == 414
let KIsiPhoneX = UIScreen.main.bounds.height >= 812
func RGBColor(r:(CGFloat), g:(CGFloat), b:(CGFloat), alpha:(CGFloat)) -> UIColor{
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}
let isIphone7 = UIScreen.main.bounds.size.width == 375
let kScreenH = UIScreen.main.bounds.height
let kScreenW = UIScreen.main.bounds.width
let allPageBackColor = RGBColor(r: 245, g: 245, b: 245, alpha: 1)
extension UIImage{
    public class func generateQRCode(_ text: String,_ width:CGFloat,_ fillImage:UIImage? = nil, _ color:UIColor? = nil) -> UIImage? {
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            let scale = width/newOutPutImage.extent.width
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            let output = newOutPutImage.transformed(by: transform)
            let QRCImage = UIImage(ciImage: output)
            guard let fillImage = fillImage else {
                return QRCImage
            }
            let imageSize = QRCImage.size
            UIGraphicsBeginImageContext(imageSize)
            QRCImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let fillRect = CGRect(x: (width - width/5)/2, y: (width - width/5)/2, width: width/5, height: width/5)
            fillImage.draw(in: fillRect)
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return QRCImage }
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}
