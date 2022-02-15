//
//  OnBoardingPageViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 12.02.2022.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var controllers = [OnboardingViewController]()
    var currentPageIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
       
        
        let vc1 = makeController(imageName: "bus",
                                 titleLabel: "Welcome!",
                                 detailLabel: "Do you want to buy a bus ticket easyly? You're in the right place!")
        vc1.view.tag = 0
        controllers.append(vc1)
        
        let vc2 = makeController(imageName: "date",
                                 titleLabel: "Easy Reservation!",
                                 detailLabel: "You can choose date and time! Reservation is never been easiest!")
        vc2.view.tag = 1
        controllers.append(vc2)
        
        let vc3 = makeController(imageName: "card",
                                 titleLabel: "Security Guaranteed!",
                                 detailLabel: "Your card is safe with us!")
        vc3.view.tag = 2
        vc3.goButton.isHidden = false
        controllers.append(vc3)
       
        self.view.addSubview(pageControl)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeAutomatically), userInfo: nil, repeats: true)
        
    }
    
    @objc func changeAutomatically(){
        if currentPageIndex < controllers.count - 1{
            currentPageIndex += 1
        } else {
            currentPageIndex = controllers.count - 1
        }
        
        pageControl.currentPage = currentPageIndex
        setViewControllers([controllers[currentPageIndex]], direction: .forward, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let first = controllers.first else { return }
        modalPresentationStyle = .fullScreen
        pageControl.currentPage = currentPageIndex
        setViewControllers([first], direction: .forward, animated: true, completion: nil)
        
        
    }
    


    private lazy var pageControl: UIPageControl = {
        let pageControlWidth: CGFloat = 200
        let pageControlHeight: CGFloat = 100

        let frame = CGRect(x: (UIScreen.main.bounds.width - pageControlWidth) / 2,
                           y: UIScreen.main.bounds.height - 100,
                           width: pageControlWidth,
                           height: pageControlHeight)

        let pageControl = UIPageControl(frame: frame)
        pageControl.numberOfPages = controllers.count
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        return pageControl
    }()
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let direction: UIPageViewController.NavigationDirection = currentPageIndex > index ? .reverse : .forward
        currentPageIndex = index
        setViewControllers([controllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    func makeController(imageName: String, titleLabel: String, detailLabel: String) -> OnboardingViewController{
        let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        _ = vc.view
        vc.imageView.image = UIImage(named: imageName)
        vc.titleLabel.text = titleLabel
        vc.subtitleLabel.text = detailLabel
        return vc
    }

}

//MARK: Delegate
extension OnBoardingPageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        guard let index = pageViewController.viewControllers?.first?.view.tag else { return }
        self.pageControl.currentPage = index
    }
    
}

//MARK: Data Source
extension OnBoardingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController as! OnboardingViewController), index > 0 else { return nil }
        let previous = index - 1
        return controllers[previous]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController as! OnboardingViewController), index < (controllers.count - 1) else { return nil }
        let next = index + 1
        return controllers[next]
    }

}

