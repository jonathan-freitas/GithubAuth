//
//  ProfileViewController.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var logOutbtn: UIButton!
    
    // User
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configViews()
    }
    
    private func configViews() {
        
        // Configuring image
        imageView.layer.cornerRadius = self.imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        
        // Setting the image with cache
        Nuke.loadImage(with: URL(string: user.avatarUrl!)!,
                       options: ImageLoadingOptions(placeholder: UIImage(named: Constants.Images.AvatarPlaceholder)!,
                                                    transition: .fadeIn(duration: 0.33)
            ),
                       into: imageView)
        
        // Setting the texts
        nameLabel.text = user.name
        locationLabel.text = user.location
        emailLabel.text = user.email
        bioLabel.text = user.bio
        
        // Setting the action button
        logOutbtn.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    /// Method responsible to logout the user.
    @objc func logOut() {
        switch LoginViewModel.deleteUser() {
        case true:
            print("User not deleted!")
        case false:
            self.navigationController?.popViewController(animated: true)
        }
    }
}
