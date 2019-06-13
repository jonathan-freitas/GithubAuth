//
//  Navigation.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import UIKit

struct Navigation {
    static func pushProfileView(viewController: UIViewController, user: User) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        vc?.user = user
        viewController.navigationController?.pushViewController(vc!, animated: true)
    }
}
