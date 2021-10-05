//
//  WelcomViewControllerViewController.swift
//  MyCookBook
//
//  Created by sleman on 5.10.21.
//

import UIKit

class WelcomViewController: UIViewController {

    @IBOutlet var holderView: UIView!

    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }

    private func configure() {
        scrollView.frame = holderView.bounds
        let title = ["Discover delicious food with us", "Save the food you like and sweat yourself"]
        let titleTwo = ["AWESOME FOOD", "GET FOOD"]
        holderView.addSubview(scrollView)
        for x in 0..<2 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)

            
            
            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: pageView.frame.size.width, height: pageView.frame.size.height))
            let button = UIButton(frame: CGRect(x: 25, y: holderView.frame.size.height - 100, width: holderView.frame.size.width - 50, height: 40))
            
            let label = UILabel(frame: CGRect(x: 25, y: holderView.frame.size.height - 210, width: pageView.frame.size.width - 50, height: 60))
            let stackView = UIStackView(frame: CGRect(x: 25, y: holderView.frame.size.height - 250, width: pageView.frame.size.width - 50, height: 60))
            let labelTwo = UILabel(frame: CGRect(x: 0, y: 0, width: stackView.frame.size.width, height: stackView.frame.size.height))
            stackView.addSubview(labelTwo)
            
            image.contentMode = .scaleToFill
            image.image = UIImage(named: "fon_\(x)")
            pageView.addSubview(image)
            
            label.textAlignment = .left
            label.font = UIFont(name: "Arial", size: 18)
            label.textColor = .white
            pageView.addSubview(label)
            label.text = title[x]
            
            labelTwo.text = titleTwo[x]
            labelTwo.font = UIFont(name: "Arial", size: 30)
            labelTwo.font = UIFont.boldSystemFont(ofSize: 30.0)
            labelTwo.textColor = .white
            pageView.addSubview(stackView)

            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            button.setTitle("NEXT", for: .normal)
            button.layer.cornerRadius = Border.borderRadius
            if x == 1 {
                button.setTitle("GET STARTED", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 2, height: 0)
        scrollView.isPagingEnabled = true

    }

    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 2 else {
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }


}
