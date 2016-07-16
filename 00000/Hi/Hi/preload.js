alert('啊~swift调用了我。')

var requestUrlList = {
    "家政": [
           {
           url:'http://m.ayibang.com/appointment/',
           detailKey: {
           '擦玻璃': {
           paramKey: 'keyword',
           param: 'project_clean_glass'
           }
           },
           onDocumentReady:  ayibangReady
           },
           {
           url:'http://m.ayibang.com/appointment/',
           detailKey: {
           '擦地板': {
           paramKey: 'keyword',
           param: 'project_depth_cleaning'
           }
           },
           onDocumentReady:  ayibangReady
           },
           ]
}

function ayibangReady (callback) {
    var price = document.getElementsByClassName("H-cont")[0].innerText
    var result = {
    price: price,
    orderUrl: ""
    }
    callback(result)
}

function getMainIdea (content) {
    var text = content
    if (text.match(/擦地板|洗玻璃/)) {
        idea = {
        sort: "家政",
        detailKey: "擦地板"
        }
    }
    return idea;
}

function getMatchUrls (idea) {
    
    var urls = []
    
    if (!idea) {
        return url;
    }
    
    var sort = idea.sort;
    var detailKey = idea.detailKey;
    
    var requests = requestUrlList[sort];
    
    for (var i = 0; i < requests.length; i++) {
        var onePossible = requests[i]
        var onePossibleKey = onePossible.detailKey
        if (onePossibleKey) {
            url = onePossible.url + "?" + onePossibleKey.paramKey +"="+ onePossibleKey.param
            readyJS = onePossible.onDocumentReady
            urls.push(
                      {
                      url: url,
                      readyJS: readyJS
                      }
                      )
        }
    };
    
    return urls
}

function mainUrl (content) {
    var idea = getMainIdea(content)
    var urls = getMatchUrls(idea)
    console.log("content: ", urls)
}

mainUrl("洗玻璃")

