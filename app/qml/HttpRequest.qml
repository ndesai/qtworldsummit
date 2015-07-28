import QtQuick 2.5

QtObject {
    property url url

    property bool busy: false
    property bool debug: false

    signal requestFinished

    function httpRequest(parameters, operation, callback, callbackError, finishedCallback) {
        var doc = new XMLHttpRequest()

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status === 200) {
                    if (debug)
                        console.log(operation, url + (parameters !== "" ? "?" + parameters : ""), "succeeded")

                    callback(doc.responseText, url + (parameters !== "" ? "?" + parameters : ""))
                } else {
                    if (debug)
                        console.log(operation, url + (parameters !== "" ? "?" + parameters : ""), "failed with code", doc.status)

                    callbackError(doc.responseText, url + (parameters !== "" ? "?" + parameters : ""))
                }

                if (finishedCallback)
                    finishedCallback(url + (parameters !== "" ? "?" + parameters : ""))

                busy = false
                requestFinished(parameters)
            }
        }

        if (debug)
            console.log(operation, url + (parameters !== "" ? "?" + parameters : ""))

        doc.open(operation, url + (parameters !== "" ? "?" + parameters : ""))
        doc.send()
    }

    function get(parameters, callBack, errorCallback, finishedCallback) {
        busy = true
        var functionCallback = callBack
        if (functionCallback === undefined) {
            functionCallback = function(reply) {
                console.log("Reply finished for url:", url + (parameters !== "" ? "?" + parameters : ""), "but no callback provided")
                console.log("Reply:", reply)
            }
        }

        var functionCallbackError = errorCallback
        if (functionCallbackError === undefined) {
            functionCallbackError = function(reply) {
                console.log("Reply failed for url:", url + (parameters !== "" ? "?" + parameters : ""), "but no error callback provided")
                console.log("Reply:", reply)
            }
        }

        if (debug)
            console.log("Trying to get url:", url + (parameters !== "" ? " parameters " + parameters : ""))

        if (url !== "")
            httpRequest(parameters, "GET", functionCallback, errorCallback, finishedCallback)
        else
            console.log("Error in HttpRequest, can't call get without url")
    }
}
