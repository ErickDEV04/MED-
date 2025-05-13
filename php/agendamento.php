<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: ../index.html");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $paciente_id = $_POST['paciente_id'];
    $profissional_id = $_POST['profissional_id'];
    $especialidade_id = $_POST['especialidade_id'];
    $servico_id = $_POST['servico_id'];
    $convenio_id = $_POST['convenio_id'];
    $data = $_POST['data'];
    $horario = $_POST['horario'];
    $centro_custo = $_POST['centro_custo'];

    $sql = "INSERT INTO agendamentos (paciente_id, profissional_id, especialidade_id, servico_id, convenio_id, data, horario, centro_custo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiiissss", $paciente_id, $profissional_id, $especialidade_id, $servico_id, $convenio_id, $data, $horario, $centro_custo);
    
    if ($stmt->execute()) {
        echo "Agendamento realizado com sucesso!";
    } else {
        echo "Erro ao agendar: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MED+ | Agendamento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Agendamento</h2>
        <form method="POST">
            <div class="mb-3">
                <label for="paciente_id">Paciente</label>
                <select class="form-control" id="paciente_id" name="paciente_id" required>
                    <?php
                    $sql = "SELECT id, nome FROM pacientes";
                    $result = $conn->query($sql);
                    while ($row = $result->fetch_assoc()) {
                        echo "<option value='{$row['id']}'>{$row['nome']}</option>";
                    }
                    ?>
                </select>
            </div>
            <!-- Outros campos semelhantes para profissional, especialidade, serviço, etc. -->
            <button type="submit" class="btn" style="background-color: #ea3af; color: #f8fbf6;">Agendar</button>
        </form>
    </div>
</body>
</html>
