
const Util = {
    //Fecth
    getDataFromServerUsingFetch(url, bodyData, method, callback) {
        const fecthOptions = {
            method: method,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(bodyData)
        };
        if (method == 'POST'){
            fetch(url, fecthOptions)
                .then((response) => response.json())
                .then((responseJson) => {
                    console.log(responseJson)
                    callback(responseJson);
                })
                .catch((error) => {
                    console.error(error);
                })
        }else if(method == 'GET'){
            fetch(url)
                .then((response) => response.json())
                .then((responseJson) => {
                    console.log(responseJson);
                    callback(responseJson);
                })
                .catch((error) => {
                    console.error(error);
                })
        }

    },

    //XMLHttpRequest API
    getDataFromServerUsingXMLHttpRequest(url, parameter, method, callback){
      var request = new XMLHttpRequest();
        request.onreadystatechange = (e) => {
            if (request.readyState !== 4){
                return;
            }
            if (request.status === 200){
                callback(JSON.parse(request.responseText));
            }else {
                console.log('error')
            }
        };
        request.open(method, url, true);
        request.setRequestHeader("Content-Type","application/json");
        if (method === 'GET'){
            request.send()
        }else  if(method === 'POST'){
            // 参数
            // request.send();
        }
    },
    //WebSocket
    getDataFromServerUsingWebSocket(url) {
        var ws =new WebSocket(url)
        ws.onopen =() =>{
            ws.send(); //send a message
        }
        ws.onmessage = (e) => {
            console.log(e.data);
        }
        ws.onerror = (e) => {
            console.log(e.message)
        }
        ws.onclose = () => {
            console.log(e.code, e.reason)
        }
    }
}


export default Util
