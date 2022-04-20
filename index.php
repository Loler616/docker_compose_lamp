<h1>Test połączenia z serwerem MySQL...</h1>

<?php 
	$host = 'mysql';
	$user = 'root';
	$pass = 'password123';
	$conn = new mysqli($host, $user, $pass);

	if ($conn->connect_error) {
		die("Nie udało się nawiązać połączenia. Errors: " . $conn->connect_error);
	} 
	else {
		echo "Udało się nawiązać połączenie!";
	}
?>