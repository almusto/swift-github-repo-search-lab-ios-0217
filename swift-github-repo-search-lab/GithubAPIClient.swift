//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire



class GithubAPIClient {


    class func getRepositories(with completion: @escaping ([Any]) -> ()) {
      let string = "https://api.github.com/repositories?client_id=\(clientID)&client_secret=\(clientSecret)"
      Alamofire.request(string).responseJSON { response in
        if let JSON = response.result.value as? [Any] {
          completion(JSON)
        }
      }
    }

  class func checkIfRepositoryIsStarred(_ fullName: String, completion: @escaping (Bool) -> ()) {
    let urlString = "https://api.github.com/user/starred/\(fullName)"
    let headers: HTTPHeaders = [
      "Authorization" : "token \(token)"
    ]


    Alamofire.request(urlString, method: .get, headers: headers).response { response in
      if let status = response.response   {
        if status.statusCode == 204 {
          completion(true)
        } else if status.statusCode == 404 {
          completion(false)
        } else {
          completion(false)
        }
      }


    }
  }


  class func starRepository(named fullName: String, completion: @escaping ()->()) {
    let urlString = "https://api.github.com/user/starred/\(fullName)"
    let headers: HTTPHeaders = [
      "Content-Length" : "0",
      "Authorization" : "token \(token)"
    ]

    Alamofire.request(urlString, method: .put, headers: headers).response { response in
      if let status = response.response   {
        if status.statusCode == 204 {
          print(status.statusCode)
          completion()
        }
      }
    }
    
  }

  class func unstarRepository(named fullName: String, completion: @escaping ()->()) {
    let urlString = "https://api.github.com/user/starred/\(fullName)"
    let headers: HTTPHeaders = [
      "Content-Length" : "0",
      "Authorization" : "token \(token)"
    ]

    Alamofire.request(urlString, method: .delete, headers: headers).response { response in
      if let status = response.response   {
        if status.statusCode == 204 {
          print(status.statusCode)
          completion()
        }
      }
    }

  }

  class func searchForRepo(named name: String, with completion: @escaping ([Any]) -> ()) {
    let githubURL: String = "https://api.github.com/search/repositories?q=\(name)"
    Alamofire.request(githubURL).responseJSON { response in
      if let JSON = response.result.value as? [String:Any] {
        let items = JSON["items"] as? [Any] ?? []
        completion(items)
      }
    }


  }
    
}

