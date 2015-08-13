import QtQuick 2.4

// TODO: ND - Convert to singleton C++ (allow for caching, etc.)
Item {
    id: root

    property int status: Loader.Null

    property url url: "http://www.qtworldsummit.com/sessionsjson/"
    property url urlSchedule: "http://api.app.st/qws15/schedule"

    property var schedule: null
    property var tracks: null

    Component.onCompleted: {
        status = Loader.Loading;
        webRequest(urlSchedule, function(response) {
            if (response) {
                console.log(response.length)
                schedule = response;
                status = Loader.Ready;
            } else {
                status = Loader.Error;
            }
        });
    }

    // Utility methods
    function webRequest(requestUrl, callback){
        console.log(arguments.callee.name, "requestUrl="+requestUrl)
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            var response;
            if(request.readyState === XMLHttpRequest.DONE) {
                if(request.status === 200) {
                    response = JSON.parse(request.responseText);
                } else {
                    console.log("Server: " + request.status + "- " + request.statusText);
                    response = ""
                }
                callback(response, request, requestUrl)
            }
        }
        request.open("GET", requestUrl, true); // only async supported
        request.send();
    }
}

