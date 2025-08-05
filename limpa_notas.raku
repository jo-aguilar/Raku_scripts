#! /usr/bin/ perl6

use v6;
my regex cite1 { \[ cite \: <space>+ <:N>+ \] };
my regex cite2 { \[ cite '_' <:L>+ \] };
my regex cite_geral { <cite1> | <cite2> };
my regex hash_indice { '#' . };

#=begin comment
my $processo = 'gedit';     #processo para a abertura do programa de notas
my $arquivo = 'buffer.txt'; #arquivo com conteúdo entregue pelo usuário
my $suporte = 'temp.txt';   #arquivo que recebe o conteúdo tratado


if $arquivo.IO.e {
#Caso não tenha havido o fechamento próprio do programa anteriormente,
#a instância atual remove os arquivos anteriores que não forram
#propriamente removidos ao fim do script
	$arquivo.IO.unlink;
	$suporte.IO.unlink;
}

try {
#Não permite que o script continue rodando a menos que o processo de
#abertura do programa de notas tenha terminado para que haja um documento
#a ser tratado
	$arquivo.IO.spurt: '';
	my $processo_atual = Proc::Async($processo, $arquivo);
	my $promessa = $processo_atual.start;
	await $promessa;
} 
CATCH {
	default {say "[ERRO]: processo terminado com exceção";}
}

my $arquivo_aberto = open $suporte.IO, :a;
my $string_tratada = '';
my $string_buffer = '';
for $arquivo.IO.lines() -> $linhas {
#Baseado nos regexes desejados, elimina os marcadores do texto, dá espaçamento
#extras caso haja tags seguidas diretamente por conteúdo alfanumérico e outros
#tratamentos que possam ser especificados futuramente. Também evita que linhas
#duplicadas entrem no texto final não permitindo que duplicações sejam enviadas
#para o documento final
	$string_tratada = $linhas;
	if ($linhas ~~ &cite_geral) 
		{ $string_tratada.subst-mutate: /<cite_geral>/, '', :g;}	
	if ($string_tratada ~~ &hash_indice) {
		my @array = ($string_tratada ~~ &hash_indice).Str.comb;
		@array.splice(1, 0, ' ');
		$string_tratada.subst-mutate(&hash_indice, (@array.join).Str);
	}
	if ($string_tratada eq $string_buffer) { next; }
	else {
		$arquivo_aberto.say: $string_tratada; }
	$string_buffer = $string_tratada;
}
$arquivo_aberto.close;

shell("xsel --clipboard --input < \"$suporte\""); #cola o conteúdo na área de
						  #transferência
#remove os arquivos usados durante o script
$arquivo.IO.unlink;
$suporte.IO.unlink;
"[!!!] Conteúdo enviado para área de transferência".say;
"[!!!] Programa terminado".say;







