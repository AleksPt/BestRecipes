import UIKit

protocol OnboardingActionsDelegate: AnyObject {
    func onboardingButtonTapped()
    func onboardingSkipTapped()
}

class OnboardingViewController: UIPageViewController {
    
    // MARK: - Properties
    private var currentIndex = 0
    private var pages = [UIViewController]()
    private var pageControl = UIStackView()
    private var dots = [UIView]()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        setupPages()
        
        if let firstVC = pages.first as? PageContentViewController {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
            firstVC.updatePageControl(with: currentIndex)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let currentVC = viewControllers?.first as? PageContentViewController {
            currentVC.updatePageControl(with: currentIndex)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let currentVC = viewControllers?.first as? PageContentViewController {
            currentVC.updatePageControl(with: currentIndex)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupPages() {
        let onboardingPages = OnboardingData.getPages()
        onboardingPages.forEach { data in
            let pageViewController = PageContentViewController(pageData: data)
            pageViewController.delegate = self
            
            pages.append(pageViewController)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let previousIndex = index - 1
        currentIndex = previousIndex
        if let vc = viewController as? PageContentViewController {
            vc.updatePageControl(with: currentIndex)
        }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        let nextIndex = index + 1
        currentIndex = nextIndex
        if let vc = viewController as? PageContentViewController {
            vc.updatePageControl(with: currentIndex)
        }
        return pages[nextIndex]
    }
}

extension OnboardingViewController: OnboardingActionsDelegate {
    func onboardingButtonTapped() {
        if let currentVC = viewControllers?.first as? PageContentViewController,
           let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC) as? PageContentViewController {
            
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
            currentIndex = pages.firstIndex(of: nextVC) ?? currentIndex
            nextVC.updatePageControl(with: currentIndex)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func onboardingSkipTapped() {
        if let lastVC = pages.last as? PageContentViewController {
            setViewControllers([lastVC], direction: .forward, animated: true, completion: nil)
            currentIndex = pages.count - 1
            lastVC.updatePageControl(with: currentIndex)
        }
    }
}
