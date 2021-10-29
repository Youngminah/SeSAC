//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    private let searchView = UIView()
    private var startPage = 1
    
    private let closeSceneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.searchSceneBackgroundColor
        addView()
        setConstraints()
        setConfiguration()
    }
    
    @objc private func closeButtonTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setConfiguration() {
        closeSceneButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        searchBar.delegate = self
        setTableView()
    }
    
    private func addView() {
        view.addSubview(searchView)
        searchView.addSubview(closeSceneButton)
        searchView.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.height.equalTo(60)
        }
        
        closeSceneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(closeSceneButton.snp.right).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.prefetchDataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMovieData(name: searchBar.text!) { data , error  in
            print(data)
        }
    }
}

////MARK: - Pagination
//extension SearchViewController: UITableViewDataSourcePrefetching {
//
//    //셸이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if viewModel.movieData.count - 1 == indexPath.row {
//                startPage += 10
//                fetchMovieData(name: <#T##String#>, completion: <#T##(SearchMovie?, Error?) -> ()#>)
//                print("prefetch: \(indexPath)")
//            }
//        }
//    }
//
//    //취소하는 기능
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        print("취소: \(indexPaths)")
//    }
//}



extension SearchViewController{
    
    func fetchMovieData(name: String, completion: @escaping (SearchMovie?, Error?) -> ()) {
        
        let url = "\(Endpoint.baseURL)/movie/day?api_key=\(APIKey.TMDB)"
        let header: HTTPHeaders  = [
            "X-Naver-Client-Id": "JTUUAwcOVlI3mySPRh9r",
            "X-Naver-Client-Secret": "syRcCnryD2"
        ]
        
        AF.request(url, method: .get,  headers: header).validate().responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}

struct SearchMovie: Codable {
    
    var items: [Movie]
    
    struct Movie: Codable{
      var title: String
      var pubDate: String
      var director: String
      var image: String
    }
}

