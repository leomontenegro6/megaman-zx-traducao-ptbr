<?php
function aviso($msg, $quebra=true){
	if($quebra){
		echo $msg . PHP_EOL;
	} else {
		echo $msg . ' ';
	}
}

function lerByteHex($arq){
	return strtoupper(bin2hex(fread($arq, 1)));
}

function ler2BytesHexInvertido($arquivo, $posicao=''){
	if(!empty($posicao)){
		fseek($arquivo, $posicao);
	}
	$byte1 = bin2hex(fread($arquivo, 1));
	$byte2 = bin2hex(fread($arquivo, 1));
	return hexdec($byte2 . $byte1);
}

function escreverByte($arquivo, $byte, $hexadecimal=true){
	if($hexadecimal){
		$byte = hex2bin($byte);
	}
	fwrite($arquivo, $byte);
}

function converterCharByte($char, $tabela_invertida){
	$byte = strtr(utf8_encode($char), $tabela_invertida);
	if(strlen($byte) != 2){
		echo PHP_EOL . "AVISO: Caractere inválido, substituindo para arroba..." . PHP_EOL;
		$byte = '20';
	}
	return $byte;
}

function voltar1Byte($arq){
	fseek($arq, (ftell($arq) - 1));
}

function voltar2Bytes($arq){
	fseek($arq, (ftell($arq) - 2));
}

function voltarComeco($arq){
	fseek($arq, 0);
}

function checkAlfanumerico($texto){
    $convert = array(
		// Acentos maiúsculos
		"À"=>"A", "Á"=>"A", "Ã"=>"A", "Â"=>"A",
		"Ç"=>"C", "É"=>"E", "Ê"=>"E", "Í"=>"I",
		"Ï"=>"I", "Ó"=>"O", "Ô"=>"O", "Õ"=>"O",
		"Ú"=>"U", "Ü"=>"U", "Ñ"=>"N",
		// Acentos minúsculos
		"à"=>"a", "á"=>"a", "ã"=>"a", "â"=>"a",
		"ç"=>"c", "é"=>"e", "ê"=>"e", "í"=>"i",
		"ï"=>"i", "ó"=>"o", "ô"=>"o", "õ"=>"o",
		"ú"=>"u", "ü"=>"u", "ñ"=>"n"
	);
    return ctype_alnum(strtr($texto, $convert));
}

function checkSinalPontuacao($caractere){
	return in_array($caractere, array('.', '?', '!', '-', '/', ':', '\''));
}

function lerTabelaCaracteres($invertida=false){
	$tabela = array(
		// Caracteres
		'00'=>' ', '01'=>'!', '02'=>'"', '03'=>'#', '04'=>'$', '05'=>'%', '06'=>'&', '07'=>'\'', 
		'08'=>'(', '09'=>')', '0A'=>'*', '0B'=>'+', '0C'=>',', '0D'=>'-', '0E'=>'.', '0F'=>'/', 
		'1A'=>':', '1B'=>';', '1D'=>'=', '1F'=>'?', '20'=>'@', '3B'=>'[', '3D'=>']', '5E'=>'~',
		'8A'=>'ª', '8E'=>'®', '90'=>'°', '9A'=>'º',
		// Números
		'10'=>'0', '11'=>'1', '12'=>'2', '13'=>'3', '14'=>'4', '15'=>'5', '16'=>'6', '17'=>'7', 
		'18'=>'8', '19'=>'9',
		// Letras maiúsculas
		'21'=>'A', '22'=>'B', '23'=>'C', '24'=>'D', '25'=>'E', '26'=>'F', '27'=>'G', '28'=>'H',
		'29'=>'I', '2A'=>'J', '2B'=>'K', '2C'=>'L', '2D'=>'M', '2E'=>'N', '2F'=>'O', '30'=>'P',
		'31'=>'Q', '32'=>'R', '33'=>'S', '34'=>'T', '35'=>'U', '36'=>'V', '37'=>'W', '38'=>'X',
		'39'=>'Y', '3A'=>'Z',
		// Letras minúsculas
		'41'=>'a', '42'=>'b', '43'=>'c', '44'=>'d', '45'=>'e', '46'=>'f', '47'=>'g', '48'=>'h',
		'49'=>'i', '4A'=>'j', '4B'=>'k', '4C'=>'l', '4D'=>'m', '4E'=>'n', '4F'=>'o', '50'=>'p',
		'51'=>'q', '52'=>'r', '53'=>'s', '54'=>'t', '55'=>'u', '56'=>'v', '57'=>'w', '58'=>'x',
		'59'=>'y', '5A'=>'z',
		// Acentos
		'A0'=>'À', 'A1'=>'Á', 'A2'=>'Â', 'A3'=>'Ã', 'A7'=>'Ç', 'A9'=>'É', 'AA'=>'Ê', 'AD'=>'Í',
		'B3'=>'Ó', 'B4'=>'Ô', 'B5'=>'Õ', 'BA'=>'Ú', 'C0'=>'à', 'C1'=>'á', 'C2'=>'â', 'C3'=>'ã',
		'C7'=>'ç', 'C9'=>'é', 'CA'=>'ê', 'CD'=>'í', 'D3'=>'ó', 'D4'=>'ô', 'D5'=>'õ', 'DA'=>'ú'
	);
	if($invertida){
		return array_flip($tabela);
	} else {
		return $tabela;
	}
}

function startsWith($haystack, $needle){
	// search backwards starting from haystack length characters from the end
	return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== FALSE;
}

function obterTipoScript($nome_arquivo){
	$nome_arquivo_sem_extensao = str_replace('.bin', '', $nome_arquivo);
	$infos = explode('_', $nome_arquivo_sem_extensao);
	$tipo = $infos[1];
	if(startsWith($tipo, 'gd')){ // NPCs do QG dos Guardiões
		$tipo = 'NPCs Guardiões';
	} elseif(startsWith($tipo, 'm')){ // Missão
		$numero_missao = hexdec(substr($tipo, -2));
		$tipo = 'Missão ' . $numero_missao;
	} elseif(startsWith($tipo, 'q')){ // Quests do jogo
		$numero_quest = hexdec(substr($tipo, -2));
		$tipo = 'Quest ' . $numero_quest;
	} elseif(startsWith($tipo, 'sys')){ // Textos de sistema
		$tipo = 'Sistema';
	} elseif(startsWith($tipo, 'tw')){ // NPCs da cidade
		$tipo = 'NPCs Cidade';
	} else {
		$tipo = $infos[1];
	}
	return $tipo;
} 

function obterPersonagemScript($nome_arquivo){
	$nome_arquivo_sem_extensao = str_replace('.bin', '', $nome_arquivo);
	$infos = explode('_', $nome_arquivo_sem_extensao);
	if($infos[2] == 'en1'){
		$personagem = 'Vent';
	} elseif($infos[2] == 'en2'){
		$personagem = 'Aile';
	} else {
		$personagem = 'indefinido';
	}
	return $personagem;
}

function inverterBytes($bytes){
	$array_bytes = str_split($bytes, 2);
	$bytes_invertidos = '';
	foreach($array_bytes as $byte){
		$bytes_invertidos = $byte . $bytes_invertidos;
	}
	if(empty($bytes_invertidos)){
		$bytes_invertidos = $bytes;
	}
	return $bytes_invertidos;
}

function obterTamanhoArquivo($arquivo){
	$tamanho_arquivo = dechex(ftell($arquivo) - 4);
	if(strlen($tamanho_arquivo) < 4){
		$tamanho_arquivo = str_pad($tamanho_arquivo, 4, "0", STR_PAD_LEFT);
	}
	return inverterBytes($tamanho_arquivo);
}

function obterPosicaoInicioScript($posicao_inicio_textos){
	$posicao_inicio_script = dechex($posicao_inicio_textos - 4);
	if(strlen($posicao_inicio_script) < 4){
		$posicao_inicio_script = str_pad($posicao_inicio_script, 4, "0", STR_PAD_LEFT);
	}
	return inverterBytes($posicao_inicio_script);
}

function adicionarPonteiro($array_ponteiros, $arquivo, $posicao_inicio_textos){
	$ponteiro = dechex(ftell($arquivo) - $posicao_inicio_textos);
	if(strlen($ponteiro) < 4){
		$ponteiro = str_pad($ponteiro, 4, "0", STR_PAD_LEFT);
	}
	$array_ponteiros[] = inverterBytes($ponteiro);
	return $array_ponteiros;
}
?>
