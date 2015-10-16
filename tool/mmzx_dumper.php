<?php
include('mmzx_lib.php');

echo "+==============================+" . PHP_EOL;
echo "+ [NDS] Megaman ZX (U)         +" . PHP_EOL;
echo "+ Script Dumper v0.1           +" . PHP_EOL;
echo "+ Trans-Center, 2015           +" . PHP_EOL;
echo "+ Solid_One                    +" . PHP_EOL;
echo "+==============================+" . PHP_EOL;
echo PHP_EOL;
echo "Como usar:" . PHP_EOL;
echo " - Crie uma pasta chamada 'scripts' no mesmo local onde estão os arquivos da tool;" . PHP_EOL;
echo " - Dentro da pasta 'scripts', crie outras duas pastas de nome 'originais' e 'dumpados';" . PHP_EOL;
echo " - Extraia, da pasta 'data' da rom do jogo (preferencialmente a americana), os seguintes arquivos:" . PHP_EOL;
echo "  1. Todos os arquivos em extensão .bin cujo nome começa com 'm_' e termina com 'en';" . PHP_EOL;
echo "  2. Todos os arquivos em extensão .bin cujo nome começa com 'talk_' e termina com 'en', 'en1' ou 'en2';" . PHP_EOL;
echo " - Ponha os seguintes arquivos dentro da pasta 'originais' e execute este script;" . PHP_EOL;
echo " - A extração dará início em seguida, salvando os scripts na pasta 'dumpados'." . PHP_EOL;
echo PHP_EOL;

aviso('Verificando quantidade de scripts...', false);
$scripts = glob('scripts/originais/*.bin', GLOB_BRACE);
$total_scripts = count($scripts);
aviso($total_scripts);
if($total_scripts > 0){
	aviso('Lendo tabela...', false);
	$tabela = lerTabelaCaracteres(false);
	aviso('OK!');
	aviso('Iniciando extração dos scripts...');
	foreach($scripts as $script) {
		$nome_arquivo_original = basename($script);
		if($nome_arquivo_original == 'talk_q07_en1.bin'){
			aviso("O script \"$nome_arquivo_original\" é nulo e será ignorado.");
			continue;
		}
		$nome_arquivo_dumpado = str_replace('.bin', '.txt', $nome_arquivo_original);
		
		aviso("Extraindo script \"$nome_arquivo_original\" para arquivo de texto \"$nome_arquivo_dumpado\"...", false);
		
		$script = fopen($script, 'r');
		$texto = fopen("scripts/dumpados/$nome_arquivo_dumpado", 'w');

		// Obtendo tamanho do arquivo
		$tamanho_arquivo = ler2BytesHexInvertido($script, 0) + 4;

		// Obtendo posição do texto...
		$posicao_inicio_textos = ler2BytesHexInvertido($script, 2) + 4;

		// Obtendo posições de início e fim dos ponteiros...
		$posicao_inicio_ponteiros = 4;
		$posicao_fim_ponteiros = $posicao_inicio_textos - 1;
		
		// Escrevendo informações do script antes do texto começar
		$tipo = obterTipoScript($nome_arquivo_original);
		$personagem = obterPersonagemScript($nome_arquivo_original);
		fwrite($texto, "<script_info ");
		fwrite($texto, "tipo='$tipo' personagem='$personagem' ");
		fwrite($texto, "tamanho='$tamanho_arquivo' ");
		fwrite($texto, "inicio_ponteiros='$posicao_inicio_ponteiros' ");
		fwrite($texto, "fim_ponteiros='$posicao_fim_ponteiros' ");
		fwrite($texto, "inicio_textos='$posicao_inicio_textos' ");
		fwrite($texto, "/>" . PHP_EOL);
		fwrite($texto, '<#####################>' . PHP_EOL . PHP_EOL);

		// Percorrendo lista de ponteiros...
		$i = $posicao_inicio_ponteiros;
		while($i < $posicao_fim_ponteiros){
			// Obtendo endereço de cada ponteiro
			$ponteiro = ler2BytesHexInvertido($script, $i) + $posicao_inicio_textos;
			
			// Extraindo textos de cada ponteiro...
			fseek($script, $ponteiro);
			$flag_parametros = false;
			$flag_fim_string = false;
			do {
				$byte = lerByteHex($script);
				if($flag_parametros === false) {
					if($byte == 'F2'){ // Posição da caixa de diálogo
						$byte2 = lerByteHex($script);
						$char = "<p $byte2>";
					} elseif($byte == 'F3'){ // Avatar
						$byte2 = lerByteHex($script);
						$char = "<a $byte2>";
					} elseif($byte == 'F4'){ // Sexo do personagem (?)
						$byte2 = lerByteHex($script);
						$char = "<s $byte2>";
					} elseif($byte == 'F6'){ // Escolha
						$byte2 = lerByteHex($script);
						$char = "<e $byte2>";
					} elseif($byte == 'F8'){ // Nome
						$byte2 = lerByteHex($script);
						$char = "<n $byte2>";
					} elseif($byte == 'F9'){ // Número do diálogo
						$byte2 = lerByteHex($script);
						$byte3 = lerByteHex($script);
						$char = "<d $byte2$byte3>";
					} elseif($byte == 'FB'){ // Menu
						$char = "<m>";
					} elseif($byte == 'FF'){ // Fim do script
						$flag_fim_string = true;
						$char = '<FIM>';
					} else {
						// Caractere diferente dos acima.
						// Nesse caso, voltar um byte no arquivo e ativar a flag de parâmetros,
						// para o decoder extrair corretamente o texto do script em si,
						// em função da tabela de caracteres
						fwrite($texto, PHP_EOL);
						$flag_parametros = true;
						voltar1Byte($script);
						continue;
					}
				} else {
					if($byte == 'E0'){ // D-Pad
						$byte2 = lerByteHex($script);
						if($byte2 == 'E1'){
							$char = "<dpad>";
						} else {
							$char = "<E0><$byte2>";
						}
					} elseif($byte == 'E2'){ // Botão A
						$byte2 = lerByteHex($script);
						if($byte2 == 'E3'){
							$char = "<btn_a>";
						} else {
							$char = "<E2><$byte2>";
						}
					} elseif($byte == 'E4'){ // Botão B
						$byte2 = lerByteHex($script);
						if($byte2 == 'E5'){
							$char = "<btn_b>";
						} else {
							$char = "<E2><$byte2>";
						}
					} elseif($byte == 'EE'){ // Seta para cima
						$char = "<cima>";
					} elseif($byte == 'EF'){ // Seta para baixo
						$char = "<baixo>";
					} elseif($byte == 'F0'){ // Setas / cursores
						$byte2 = lerByteHex($script);
						if($byte2 == '00'){ // Seta pra esquerda
							$char = "<esquerda>";
						} elseif($byte2 == '01'){ // Seta pra direita
							$char = "<direita>";
						} elseif($byte2 == '02'){ // Cursor para esquerda (menus de escolha)
							$char = "<cursor_esq>";
						} else { // Indefinido
							$char = "<F0><$byte2>";
						}
					} elseif($byte == 'F1'){ // Cor do texto
						$byte2 = lerByteHex($script);
						$char = "<c $byte2>";
					} elseif($byte == 'FA'){ // Nome do protagonista
						$char = "<nome>";
					} elseif($byte == 'FC'){ // Quebra de linha
						$char = PHP_EOL;
					} elseif($byte == 'FD'){ // Quebra de seção
						$char = PHP_EOL . '<--------------------->' . PHP_EOL . PHP_EOL;
					} elseif($byte == 'FE'){ // Fim de texto
						$flag_parametros = false;
						$char = PHP_EOL . '<*********************>' . PHP_EOL . PHP_EOL;
					} elseif($byte == 'FF'){ // Fim do script
						$flag_fim_string = true;
						$char = PHP_EOL . '<FIM>';
					} elseif(in_array($byte, array('F2', 'F3', 'F4', 'F6', 'F8', 'F9', 'FB'))){
						// Caractere de controle, geralmente após uma quebra de seção.
						// Nesse caso, voltar um byte no arquivo e desativar flag de parâmetros,
						// para o decoder interpretar corretamente os caracteres posteriores de flags da janela
						$flag_parametros = false;
						voltar1Byte($script);
						continue;
					} else {
						if(array_key_exists($byte, $tabela)){
							// Caractere de texto comum.
							$char = strtr($byte, $tabela);
						} else {
							// Caractere desconhecido. Exibir seu valor entre tags
							$char = "<$byte>";
						}
					}
				}
				if(!feof($script)){
					fwrite($texto, $char);
					if($flag_fim_string === true){
						break;
					}
				} else {
					break;
				}
			} while($byte != 'FE');
			//var_dump(dechex($ponteiro));
			if($flag_fim_string === true){
				break;
			} else {
				$i = $i + 2;
			}
		}
		if(isset($flag_fim_string) && $flag_fim_string === false){
			$char = '<FIM>';
			fwrite($texto, $char);
		}
		fclose($script);
		fclose($texto);
		aviso("OK!");
	}
	aviso('Scripts extraídos com sucesso!');
} else {
	aviso('Nenhum script encontrado!');
}
?>
