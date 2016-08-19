$(document).one('pagecreate', function (event) {
    var curDate = new Date();
    var dayLength = 24 * 60 * 60 * 1000;
    var nextThreeDays = [
        new Date(curDate.getTime() + dayLength),
        new Date(curDate.getTime() + (dayLength * 2)),
        new Date(curDate.getTime() + (dayLength * 3))
    ];
    var loc = $('#location');
    var temp = $('#temperature');
    var desc = $('#weatherDesc');
    var icon = $('#weatherIcon');
    var cities = $('#cities');
    var searchCity = $('#searchCity');
    var chartDiv = $('#chartDiv');
    // when a canvas element changes its data, weird things were happening
    // when mouse-hovering over it (was showing all old data, too). So
    // I empty the div container and reassign it with this string.
    var myCanvas = '<canvas id="myCanvas" width="200" height="100"></canvas>';
    var recentSearchesUl = $('#recentCitySearches');
    var recentSearches = [];
    var _citiesJson;

    getLocation();
    setCities();
    getRecentSearches();
    displayRecentSearches();

    $(document).on('tap', '#cities > li', function () {
        var item = $(this);
        var id = item.attr('id');
        var lat = _citiesJson.cities[id].lat;
        var lon = _citiesJson.cities[id].lon;

        getWeatherDataLatLon(lat, lon);
    });

    $(document).on('tap', '#recentCitySearches > li', function () {
        var search = $(this).text();

        getWeatherDataCityName(search);
    });

    searchCity.on('keypress', function (key) {
        // If enter key
        if (key.which == 13) {
            var searchTerm = searchCity.val();
            searchCity.val('');

            getWeatherDataCityName(searchTerm).done(function (foundData) {
                // Don't add searches that didn't return any weather data
                if (foundData) {
                    setRecentSearches(searchTerm);
                }
            });
        }
    });

    function getWeatherDataLatLon(lat, lon) {
        var url = 'http://api.openweathermap.org/data/2.5/forecast/daily?lat=' + lat + '&lon=' + lon + '&cnt=4&units=metric&&APPID=6e2a48c7ef75859b44f8c39d75030bcf'

        getWeatherData(url);
    }

    function getWeatherDataCityName(cityName) {
        var url = 'http://api.openweathermap.org/data/2.5/forecast/daily?q=' + cityName + '&cnt=4&units=metric&&APPID=6e2a48c7ef75859b44f8c39d75030bcf'

        return getWeatherData(url);
    }

    function getWeatherData(url) {
        var deferred = $.Deferred();
        var foundData = false;

        $.getJSON(url)
            .done(function (weatherData) {
                // Data not found error handling
                if (weatherData.cod == '404') {
                    alert('No data found for that location!');
                } else {
                    foundData = true;
                    displayData(weatherData);
                }

                deferred.resolve(foundData);
            })
            .fail(function () {
                alert('The API call didn\'t work!');
                deferred.reject();
            });


        return deferred.promise();
    }

    function displayData(weatherData) {
        loc.text(weatherData.city.name + ', ' + weatherData.city.country);
        var today = weatherData.list[0];
        temp.text(today.temp.day + ' ' + String.fromCharCode(176) + 'C');
        desc.text(today.weather[0].description);
        icon.attr('src', 'http://openweathermap.org/img/w/' + today.weather[0].icon + '.png');

        var forecasts = $('#forecasts').html();
        var generateHtml = Handlebars.compile(forecasts);

        // make a truncated version of the four weather reports days
        var tomorrowOnwards = [];
        for (var i = 1; i < 4; i++) tomorrowOnwards.push(weatherData.list[i]);
        $('#forecast').html(generateHtml(tomorrowOnwards));

        for (var i = 0; i < nextThreeDays.length; i++) {
            var forecast = $('#forecastDate' + i);
            $(forecast).text(nextThreeDays[i].toDateString());
        }

        buildCanvas(weatherData);
    }

    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showErr);
        } else {
            console.log("Geolocation is not supported.")
        }
    }

    function showPosition(position) {
        getWeatherDataLatLon(position.coords.latitude, position.coords.longitude);
    }

    function showErr(err) {
        console.log(err.message)
    }

    function buildCanvas(weatherData) {
        chartDiv.empty();
        chartDiv.append(myCanvas);
        var ctx = $('#myCanvas');

        var today = weatherData.list[0];

        var data = {
            labels: ['Morning', 'Day', 'Evening', 'Night'],
            datasets: [
                {
                    label: "Temperature fluctuations",
                    fill: true,
                    lineTension: 0.1,
                    backgroundColor: "rgba(75,192,192,0.4)",
                    borderColor: "rgba(75,192,192,1)",
                    borderCapStyle: 'butt',
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: 'miter',
                    pointBorderColor: "rgba(75,192,192,1)",
                    pointBackgroundColor: "#fff",
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(75,192,192,1)",
                    pointHoverBorderColor: "rgba(220,220,220,1)",
                    pointHoverBorderWidth: 2,
                    pointRadius: 1,
                    pointHitRadius: 10,
                    data: [today.temp.morn, today.temp.day, today.temp.eve, today.temp.night],
                }
            ]
        };

        var myLineChart = Chart.Line(ctx, {
            data: data
        });
    }

    function setCities() {
        $.getJSON('resources/data/cities.json')
            .done(function (citiesData) {
                _citiesJson = citiesData;
                var citiesPanelContent = $('#citiesPanelContent').html();
                var generateHtml = Handlebars.compile(citiesPanelContent);
                var content = generateHtml(_citiesJson);
                cities.append(content);
                cities.listview('refresh');
            })
            .fail(function () {
                alert('Cities JSON didn\'t load');
            });
    }

    function getRecentSearches() {
        if (localStorage.recentSearches) {
            recentSearches = JSON.parse(localStorage.recentSearches);
        }
    }

    function setRecentSearches(search) {
        recentSearches.push(search);
        localStorage.recentSearches = JSON.stringify(recentSearches);
        displayRecentSearches();
    }

    // only display 10 most recent searches
    function displayRecentSearches() {
        recentSearchesUl.empty();
        var counter = 0;
        for (var i = recentSearches.length - 1; i >= 0 && counter < 10; i--, counter++) {
            // I got lazy here. I used Handlebars elsewhere, however.
            var li = '<li><a href="#">' + recentSearches[i] + '</a></li>';
            recentSearchesUl.append(li);
        }

        recentSearchesUl.listview('refresh');
    }
});