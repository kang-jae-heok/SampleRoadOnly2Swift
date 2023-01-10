

import UIKit
import CloudKit

@objc class helpBtnS: UIButton {
    let screenBounds = UIScreen.main.bounds
    let margin = 27.0
    var initFrame = CGRect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFrame = frame
        print(#function)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
        loadView()
    }
    func loadView(){
        self.setImage(UIImage(named: "help_btn"), for: .normal)
        self.addTarget(self, action: #selector(touchHelpBtn), for: .touchUpInside)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag))
        self.addGestureRecognizer(panGesture)
    }
    
    
    @objc func drag(sender: UIPanGestureRecognizer){
        // self는 여기서 ViewController이므로 self.view ViewController가 기존에가지고 있는 view이다.
        let translation = sender.translation(in: self) // translation에 움직인 위치를 저장한다.

        // sender의 view는 sender가 바라보고 있는 circleView이다. 드래그로 이동한 만큼 circleView를 이동시킨다.
       self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        sender.setTranslation(.zero, in: self) // 0으로 움직인 값을 초기화 시켜준다.
     if sender.state == .ended {
            // Do what you want
         if (self.center.x) < screenBounds.width/2 {
             UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { [self] in
                 if  center.y + translation.y > initFrame.origin.y {
                     self.frame  = CGRect(x: margin, y: initFrame.origin.y, width: 72, height: 72)
                 }else if center.y + translation.y < 0{
                     self.frame  = CGRect(x: margin, y:  0, width: 72, height: 72)
                 }else {
                     self.frame  = CGRect(x: margin, y:  self.center.y + translation.y, width: 72, height: 72)
                 }
             },completion: { [self]done in
                 if done {
                     print("hi")
                 }
             })
         }else{
             UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { [self] in
                 if  center.y + translation.y > initFrame.origin.y {
                     self.frame  = CGRect(x: screenBounds.width - margin - 72, y: initFrame.origin.y, width: 72, height: 72)
                 }else if center.y + translation.y < 0{
                     self.frame  = CGRect(x: screenBounds.width - margin - 72, y:  0, width: 72, height: 72)
                 }else {
                     self.frame  = CGRect(x: screenBounds.width - margin - 72, y:  self.center.y + translation.y, width: 72, height: 72)
                 }
             },completion: { [self]done in
                 if done {
                     print("hi")
                 }
             })
         }
         
        }
    
    }
    
    @objc func touchHelpBtn(){
        Common.safariOpenURL("http://pf.kakao.com/_TKqIxj/chat")
        Common.vibrate(1)
    }
  
}


