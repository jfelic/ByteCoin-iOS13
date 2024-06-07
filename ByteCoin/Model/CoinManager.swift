import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "4BB2DD08-A537-4326-A9FB-FC6EFEC9E876"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print("URL: \(urlString)")
        performNetworkRequest(urlString)
    }
    
    func performNetworkRequest(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error or non-200 status code")
                return
            }
            
            if let data = data {
                print("Data received: \(data)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Data as string: \(dataString)")
                } else {
                    print("Unable to convert data to string")
                }
            } else {
                print("No data received")
            }
        }
        task.resume() // Start the task
    }
}
