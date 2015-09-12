import QtQuick 2.4
import Qt.labs.settings 1.0

// TODO: ND - Convert to singleton C++ (allow for caching, etc.)
Item {
    id: root

    property int status: Loader.Null

    property url url: "http://www.qtworldsummit.com/sessionsjson/"
    property string urlBase: "http://api.app.st/qws15/"
    property url urlSchedule: urlBase + "schedule"
    property url urlTracks: urlBase + "tracks"

    property var schedule: null
    property var tracks: null

    property alias settings: _settings

    Settings {
        id: _settings
        property var favoriteTracks: []

        property string __favoriteTracks: favoriteTracks.join(",");

        property var scheduleJson
        property var tracksJson

        Component.onCompleted: {
            favoriteTracks = __favoriteTracks.split(",").filter(Boolean);
            console.log("favoriteTracks = " + favoriteTracks);
        }

        onFavoriteTracksChanged: {
            console.log("fav="+favoriteTracks);
        }
    }

    Component.onCompleted: {
        status = Loader.Loading;
        webRequest(urlSchedule, function(response) {
            if (response) {
                console.log(response.length)
                schedule = response;
                _settings.scheduleJson = schedule;
                webRequest(urlTracks, function(response) {
                    tracks = response;
                    _settings.tracksJson = tracks;
                    status = Loader.Ready;
                });
            } else {
                // Check Settings for a cached value
                if (_settings.scheduleJson) {
                    schedule = _settings.scheduleJson;
                    if (_settings.tracksJson) {
                        tracks = _settings.tracksJson;
                        status = Loader.Ready;
                    }
                } else {
                    status = Loader.Error;
                }
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

    signal favoritesUpdated

    function insertFavorite(trackObject)
    {
        if (!favoritesModelContainsTrack(trackObject)) {
            var m = _settings.favoriteTracks;
            m.push(trackObject.id);
            _settings.favoriteTracks = m;

            favoritesUpdated();
        }
    }

    function removeFavorite(trackObject)
    {
        _settings.favoriteTracks = _settings.favoriteTracks.filter(function(e) {
            return e !== trackObject.id;
        });
        favoritesUpdated();
    }

    function favoritesModelContainsTrack(trackObject)
    {
        for (var i = 0; i < _settings.favoriteTracks.length; i++) {
            if (_settings.favoriteTracks[i] == trackObject.id) {
                return true;
            }
        }
        return false;
    }

    function getFavorites()
    {
        return _settings.favoriteTracks;
    }
}

