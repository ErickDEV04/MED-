<?php
require_once 'vendor/autoload.php'; // Inclua TCPDF
require_once 'config.php';

use \TCPDF;

$pdf = new TCPDF();
$pdf->AddPage();
$pdf->SetFont('helvetica', '', 12);
$pdf->Write(0, 'Relatório de Agendamentos', '', 0, 'C', true);
$pdf->Ln(10);

$sql = "SELECT a.id, p.nome AS paciente, pr.nome AS profissional, a.data, a.horario FROM agendamentos a 
        JOIN pacientes p ON a.paciente_id = p.id 
        JOIN profissionais pr ON a.profissional_id = pr.id";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    $pdf->Write(0, "{$row['id']} - {$row['paciente']} - {$row['profissional']} - {$row['data']} {$row['horario']}", '', 0, 'L', true);
    $pdf->Ln(5);
}

$pdf->Output('relatorio_agendamentos.pdf', 'D');
?>
