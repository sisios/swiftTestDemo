import UIKit
import Photos
class ToolsManager: NSObject {
    class func AlertInfoWith(msg:String){
        DispatchQueue.main.async {
            let lab = UILabel.init(frame: CGRect.init(x: (kScreenW - 200) * 0.5, y: kScreenH, width: 220, height: 30))
            lab.text = msg
            lab.alpha = 1
            lab.font = UIFont.systemFont(ofSize: 14.0)
            lab.backgroundColor = UIColor.black
            lab.textColor = UIColor.white
            lab.layer.masksToBounds = true
            lab.layer.cornerRadius = 10
            lab.textAlignment = .center
            lab.numberOfLines = 0
            UIApplication.shared.keyWindow?.addSubview(lab)
            var rect = lab.frame
            UIView.animate(withDuration: 0.3, animations: {
                rect.origin.y -= 50
                lab.frame = rect
            }, completion: { (_) in
                UIView.animate(withDuration: 2, animations: {
                    lab.alpha = 0.9
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        rect.origin.y += 50
                    }, completion: { (_) in
                        lab.removeFromSuperview()
                    })
                })
            })
        }
    }
    class func calcStringSize(str: String, maW: CGFloat, maH: CGFloat, fontSize: CGFloat) -> CGSize {
        let paragraohStyle = NSMutableParagraphStyle()
        paragraohStyle.lineSpacing = 1
        let dict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize), NSAttributedString.Key.paragraphStyle: paragraohStyle]
        let nsStr = str as NSString
        return nsStr.boundingRect(with: CGSize.init(width: maW, height: maH), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: dict, context: nil).size
    }
    class func findHeaderLine(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for view in view.subviews {
            let imageView = self.findHeaderLine(view: view)
            if (imageView != nil) {
                return imageView
            }
        }
        return nil
    }
}
