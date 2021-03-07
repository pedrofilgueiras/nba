.curl_chinazi <-
  function(url = "https://stats.nba.com/stats/leaguegamelog?Counter=1000&Season=2019-20&Direction=DESC&LeagueID=00&PlayerOrTeam=P&SeasonType=Regular%20Season&Sorter=DATE",
           x_timeout=20,
           custom_header=NULL,
           url_proxy=NULL,
           port=NULL,
           username=NULL,
           password=NULL) {
    library(httr)
    library(rvest)
    
    headers = c(
      `Connection` = 'close',
      `Accept` = 'application/json, text/plain, */*',
      `x-nba-stats-token` = 'true',
      `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36',
      `x-nba-stats-origin` = 'stats',
      `Sec-Fetch-Site` = 'same-origin',
      `Sec-Fetch-Mode` = 'cors',
      `Referer` = 'https://downwiththechinazis.com',
      `Accept-Encoding` = 'gzip, deflate, br',
      `Accept-Language` = 'en-US,en;q=0.9'
    )

    headers <- c(
      `Host` = 'stats.nba.com',
      `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv =72.0) Gecko/20100101 Firefox/72.0',
      `Accept` = 'application/json, text/plain, */*',
      `Accept-Language` = 'en-US,en;q=0.5',
      `Accept-Encoding` = 'gzip, deflate, br',
      `x-nba-stats-origin` = 'stats',
      `x-nba-stats-token` = 'true',
      `Connection` = 'keep-alive',
      `Referer` = 'https =//stats.nba.com/',
      `Pragma` = 'no-cache',
      `Cache-Control` = 'no-cache'
    )

        if (!is.null(custom_header)){
      headers <- custom_header
    }
    
    # headers = c(
    #   `Connection` = 'close',
    #   `Pragma` = 'no-cache',
    #   `Cache-Control` = 'no-cache',
    #   `DNT` = '1',
    #   `Upgrade-Insecure-Requests` = '1',
    #   `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.29 Safari/537.36',
    #   `Sec-Fetch-User` = '?1',
    #   `Accept` = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    #   `Sec-Fetch-Site` = 'cross-site',
    #   `Sec-Fetch-Mode` = 'navigate',
    #   `Referer` = 'https://downwiththechinazis.com',
    #   `Accept-Encoding` = 'gzip, deflate, br',
    #   `Accept-Language` = 'en-US,en;q=0.9'
    # )
    
    #print(url)
    
    if (is.null(url_proxy)){
    res <- GET(url, timeout(x_timeout),add_headers(.headers = headers))
    } else {
      if (is.null(port) && is.null(username)){
        res <- httr::GET(url, use_proxy(url_proxy,port=port,password=password,username=username), timeout(x_timeout), add_headers(.headers = headers))
        } else if(!is.null(port) && is.null(username))
        {
          res <- httr::GET(url, use_proxy(url_proxy,port=port), timeout(x_timeout), add_headers(.headers = headers))
        }else {
          res <- httr::GET(url, use_proxy(url_proxy), timeout(x_timeout), add_headers(.headers = headers))
        }
      
      }
    
    json <-
      res$content %>%
      rawToChar() %>%
      jsonlite::fromJSON(simplifyVector = T)

    json

}
