import UIKit
enum CWBAlertViewStyle {
    case actionSheet
    case alert
}
class CWBAlertView: UIView {
    fileprivate var centerView = UIView()
    fileprivate var title:String?
    fileprivate var message:String?
    fileprivate var type:CWBAlertViewStyle!
    fileprivate var actionArray = [CWBAlertAction]()
    fileprivate var canClickDismis = true
    fileprivate var beganTimer:TimeInterval = 0
    public convenience init(title: String?, message: String?, preferredStyle: CWBAlertViewStyle) {
        self.init()
        for sView in UIApplication.shared.delegate!.window!!.subviews {
            if sView.isKind(of: CWBAlertView.classForCoder())  {
                let alertView = sView as! CWBAlertView
                if alertView.message == message {
                    return
                }
            }
        }
        self.title = title
        self.message = message
        self.type = preferredStyle
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.layoutIfNeeded()
    }
    open func addAction(_ action: CWBAlertAction) {
        actionArray.append(action)
    }
    open func show(){
        let centerViewWidth = self.type == CWBAlertViewStyle.alert ? self.frame.size.width * 0.75 : self.frame.size.width * 0.9
        var titleHeight:CGFloat = 0
        var messageHeight:CGFloat = 0
        var actionHeight:CGFloat = 0
        var y:CGFloat = 15
        self.centerView.layer.masksToBounds = true
        self.centerView.layer.cornerRadius = 8
        self.centerView.backgroundColor = UIColor.white
        if self.title != nil {
            titleHeight = self.calculateStringSize(str: self.title!, maW: centerViewWidth - 10, maH: 10000, fontSize: 15.0).height
            let titleLabel = UILabel.init(frame: CGRect.init(x: 5, y: 15, width: centerViewWidth - 10, height: titleHeight))
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            titleLabel.text = self.title!
            self.centerView.addSubview(titleLabel)
        }
        if self.message != nil {
            messageHeight = self.calculateStringSize(str: self.message!, maW: centerViewWidth - 30, maH: 10000, fontSize: 14.0).height
            let messageLabel = UILabel.init(frame: CGRect.init(x: 15, y: titleHeight != 0 ? titleHeight + 20 : 15, width: centerViewWidth - 30, height: messageHeight))
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.text = self.message!
            messageLabel.font = UIFont.systemFont(ofSize: 14.0)
            messageLabel.textColor = RGBColor(r: 65, g: 65, b: 65, alpha: 1)
            self.centerView.addSubview(messageLabel)
        }
        if titleHeight != 0{
            y += titleHeight + 15
        }
        if messageHeight != 0{
            y += messageHeight + 15
        }
        if self.type == CWBAlertViewStyle.alert {
            if self.actionArray.count == 1 {
                if y != 15 {
                    let lineView1 = UIView.init(frame: CGRect.init(x: 0, y: y, width: centerViewWidth, height: 0.5))
                    lineView1.backgroundColor = RGBColor(r: 180, g: 180, b: 180, alpha: 1)
                    self.centerView.addSubview(lineView1)
                }
                
                let action = self.actionArray.first
                action?.frame = CGRect.init(x: 0, y: y, width: centerViewWidth, height: 40)
                actionHeight += 40.5
                self.centerView.addSubview(action!)
            }
            else if self.actionArray.count == 2 {
                if y != 15 {
                    let lineView1 = UIView.init(frame: CGRect.init(x: 0, y: y, width: centerViewWidth, height: 0.5))
                    lineView1.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                    self.centerView.addSubview(lineView1)
                }
                let action1 = self.actionArray.first
                action1?.frame = CGRect.init(x: 0, y: y, width: centerViewWidth * 0.5 - 0.5, height: 40)
                self.centerView.addSubview(action1!)
                
                let lineView2 = UIView.init(frame: CGRect.init(x: centerViewWidth * 0.5, y: y, width: 0.5, height: 40))
                lineView2.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                self.centerView.addSubview(lineView2)
                
                let action2 = self.actionArray.last
                action2?.frame = CGRect.init(x: centerViewWidth * 0.5, y: y, width: centerViewWidth * 0.5 + 0.5, height: 40)
                self.centerView.addSubview(action2!)
                actionHeight += 40.5
            }
            else {
                for (index,action) in self.actionArray.enumerated() {
                    let lineView = UIView.init(frame: CGRect.init(x: 0, y: y + CGFloat(index * 40), width: centerViewWidth, height: 0.5))
                    lineView.backgroundColor = RGBColor(r: 230, g: 230, b: 230, alpha: 1)
                    self.centerView.addSubview(lineView)
                    action.frame = CGRect.init(x: 0, y: y + CGFloat(index * 40) + 0.5, width: centerViewWidth, height: 40)
                    self.centerView.addSubview(action)
                    actionHeight += 40.5
                }
            }
        }
        else{
            if titleHeight == 0 && messageHeight == 0 {
                y = 0
            }
            for (index,action) in self.actionArray.enumerated() {
                if index != 0 || y != 0{
                    let lineView = UIView.init(frame: CGRect.init(x: 0, y: y + CGFloat(index * 40), width: centerViewWidth, height: 0.5))
                    lineView.backgroundColor = RGBColor(r: 180, g: 180, b: 180, alpha: 1)
                    self.centerView.addSubview(lineView)
                }
                action.frame = CGRect.init(x: 0, y: y + CGFloat(index * 40) + 0.5, width: centerViewWidth, height: 40)
                self.centerView.addSubview(action)
                actionHeight += 40.5
            }
        }
        let totalH = y + actionHeight
        if totalH > UIScreen.main.bounds.height {
            self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: UIScreen.main.bounds.height - 40)
            self.centerView.center = self.center
            self.centerView.alpha = 0.5
            for view in self.centerView.subviews {
                view.removeFromSuperview()
            }
            let textView = UITextView.init(frame: self.centerView.bounds)
            textView.text = message
            textView.isScrollEnabled = true
            textView.isEditable = false
            textView.font = UIFont.systemFont(ofSize: 14.0)
            self.centerView.addSubview(textView)
            self.addSubview(self.centerView)
            UIView.animate(withDuration: 0.3) {
                self.centerView.alpha = 1
            }
        }
        else {
            if self.type == CWBAlertViewStyle.alert {
                self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: totalH)
                self.centerView.center = self.center
                self.centerView.alpha = 0.5
                self.addSubview(self.centerView)
                UIView.animate(withDuration: 0.3) {
                    self.centerView.alpha = 1
                }
            }
            else{
                self.centerView.frame = CGRect.init(x: 0, y: 0, width: centerViewWidth, height: totalH)
                self.centerView.center = CGPoint.init(x: self.center.x, y: self.frame.size.height + (totalH) * 0.5)
                self.addSubview(self.centerView)
                UIView.animate(withDuration: 0.3) {
                    self.centerView.center = CGPoint.init(x: self.center.x, y: self.frame.size.height - (totalH + 20) * 0.5)
                }
            }
        }
        self.AddEffectView(self, nil,nil)
        UIApplication.shared.delegate?.window!!.addSubview(self)
    }
    fileprivate func AddEffectView(_ sView:UIView,_ style:UIBlurEffect.Style?,_ alpha:CGFloat?){
        let effect = UIBlurEffect.init(style: style == nil ? .dark : style!)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = sView.bounds
        effectView.alpha = alpha == nil ? 0.55 : alpha!
        sView.addSubview(effectView)
        sView.sendSubviewToBack(effectView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.beganTimer = Date().timeIntervalSince1970
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canClickDismis && (touches.first?.view)! != self.centerView && !(touches.first?.view)!.isKind(of: CWBAlertAction.classForCoder()){
            let dic = Date().timeIntervalSince1970 - self.beganTimer
            if dic < 0.5 {
                if self.type == CWBAlertViewStyle.alert {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.alpha = 0.5
                    }) { (_) in
                        self.removeFromSuperview()
                    }
                }
                else{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.centerView.center = CGPoint.init(x: self.center.x, y: self.frame.size.height + self.centerView.frame.size.height * 0.5)
                    }) { (_) in
                        self.removeFromSuperview()
                    }
                }
            }
        }
        self.beganTimer = 0
    }
    fileprivate func calculateStringSize(str: String, maW: CGFloat, maH: CGFloat, fontSize: CGFloat) -> CGSize {
        let paragraohStyle = NSMutableParagraphStyle()
        paragraohStyle.lineSpacing = 1
        let dict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize), NSAttributedString.Key.paragraphStyle: paragraohStyle]
        let nsStr = str as NSString
        return nsStr.boundingRect(with: CGSize.init(width: maW, height: maH), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: dict, context: nil).size
    }
}
enum CWBAlertActionStyle : Int {
    case `default`
    case cancel
}
class CWBAlertAction : UIButton{
    var title:String?
    var handler:((CWBAlertAction) -> Swift.Void)?
    var textColor:UIColor?{
        didSet {
            self.layoutSubviews()
        }
    }
    private var style:CWBAlertActionStyle?
    public convenience init(title: String?, style: CWBAlertActionStyle, handler: ((CWBAlertAction) -> Void)? = nil) {
        self.init()
        self.layoutIfNeeded()
        self.title = title
        self.handler = handler
        self.addTarget(self, action: #selector(touchesHandler), for: .touchUpInside)
        self.style = style
    }
    override func layoutSubviews() {
        if self.title != nil {
            let titleLabel = UILabel.init(frame: self.bounds)
            if self.style != nil {
                if self.style! == CWBAlertActionStyle.cancel {
                    titleLabel.textColor = RGBColor(r: 102, g: 102, b: 102, alpha: 1)
                }
                else{
                    titleLabel.textColor = textColor != nil ? textColor! : navgationBarColor
                }
            }
            else{
                titleLabel.textColor = textColor != nil ? textColor! : navgationBarColor
            }
            
            titleLabel.textAlignment = .center
            titleLabel.text = self.title!
            titleLabel.font = UIFont.systemFont(ofSize:  16.0)
            self.addSubview(titleLabel)
        }
    }
    @objc fileprivate func touchesHandler(){
        if handler != nil {
            handler!(self)
        }
        self.disMissCenterView()
    }
    fileprivate func disMissCenterView(){
        if let fView = self.superview?.superview as? CWBAlertView {
            if fView.type == CWBAlertViewStyle.alert {
                UIView.animate(withDuration: 0.3, animations: {
                    fView.alpha = 0.5
                }) { (_) in
                    fView.removeFromSuperview()
                }
            }
            else{
                UIView.animate(withDuration: 0.3, animations: {
                    fView.centerView.center = CGPoint.init(x: fView.center.x, y: fView.frame.size.height + fView.centerView.frame.size.height * 0.5)
                }) { (_) in
                    fView.removeFromSuperview()
                }
            }
        }
    }
}
