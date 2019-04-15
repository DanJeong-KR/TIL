/*
 
 1. scroll view 구현하고
 
 2. page control 적용하고?
 
 */
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        pageControl.addTarget(self, action: #selector(pageAction(_:)), for: .valueChanged)
    }
    
    
    @objc func pageAction(_ sender: Any) {
        guard let sender = sender as? UIPageControl else {return}
        
        scrollView.contentOffset.x = CGFloat(414*sender.currentPage)
        
    }
    
}

extension ViewController: UIScrollViewDelegate {
    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)

        let pageNum = Int(scrollView.contentOffset.x / scrollView.frame.width)

        pageControl.currentPage = pageNum
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating 메소드 : ",scrollView.contentOffset)
//    }
    
    
    
    
}

