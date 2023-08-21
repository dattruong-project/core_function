//
//  HttpProvider.swift
//  Runner
//
//  Created by Truong Dat on 17/08/2023.
//

import Foundation

class HttpProvider {
    init(){
        let url = URL(string: "https://sb-openapi.zalopay.vn/v2/create")!

        request = URLRequest(url: url)
        request!.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    
    var request: URLRequest?
    static let instance = HttpProvider()
}
