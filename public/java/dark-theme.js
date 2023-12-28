document.addEventListener("DOMContentLoaded", function () {
    var moon = document.getElementById("moon");
    var body = document.body;
    var navigation = document.getElementById("navigation"); // Replace with your actual navigation element
    var main = document.getElementById("main"); // Replace with your actual main element

    // Check if dark theme is initially applied
    var isDarkTheme = body.classList.contains("dark-theme");

    // Set the initial image based on the initial dark theme state
    moon.src = isDarkTheme ? "../ImagesDarkMode/sun.png" : "../ImagesDarkMode/moon.png";

    // Toggle dark theme and image on click
    moon.onclick = function () {
        // Update the image based on the current dark theme state before toggling the class
        moon.src = body.classList.contains("dark-theme") ? "../ImagesDarkMode/moon.png" : "../ImagesDarkMode/sun.png";

        // Toggle dark theme
        body.classList.toggle("dark-theme");
        navigation.classList.toggle('active1');
        main.classList.toggle('active1');
    };
});
