function myFunction() {
    var x = document.getElementById("sitenav");
    if (x.className === "topnav") {
      x.className += " responsive";
    } else {
      x.className = "topnav";
    }
  }