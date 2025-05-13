<?php
$host = 'localhost';
$db = 'medplus';
$user = 'root';
$pass = '';

try {
    $conn = new mysqli($host, $user, $pass, $db);
    if ($conn->connect_error) {
        die("Conexão falhou: " . $conn->connect_error);
    }
} catch (Exception $e) {
    die("Erro: " . $e->getMessage());
}
?>
