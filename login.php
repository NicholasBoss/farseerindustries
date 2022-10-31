<!DOCTYPE HTML>  
<html>
<head>
</head>
<body>  

<?php
// define variables and set to empty values
$name = $password = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $password = test_input($_POST["password"]);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<?php
// if name is = to the name in the database, then echo welcome
if ($name == "admin" && $password == "admin") {
    echo "<strong>Welcome</strong>";
    // downloadable sql file
    echo "<br><a href='files/cwgamesscript.sql'>Download CW games ERD</a>";
} else {
    echo "Wrong username or password";
}
?>

</body>
</html>