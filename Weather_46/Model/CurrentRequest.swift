//
//  CurrentRequest.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/29.
//

import Foundation
import UIKit

class CurrentRequest{
    let url: URL
    
    init(urlString: String) {
        url = URL(string: urlString)!
        print(urlString)
    }
    
    func resume(handler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        // URLからリクエスト(サーバー上のアドレスにデータ取得をお願いする)を作る
        let request = URLRequest(url: url)
        //タスクとして登録(呼び出す)
        let task = URLSession.shared.dataTask(with: request, completionHandler: handler)
        //読み込み開始
        task.resume()
    }
}
