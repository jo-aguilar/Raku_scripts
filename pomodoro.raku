#!/usr/bin/env raku
my $quantidade_argumentos = 3;

proto sub sessoes_visuais ($totais, $passadas) {*}
proto sub alarme() {*}
my $vermelho := { "\e[31m" ~ $^a ~ "\e[0m"; }
my $verde    := { "\e[32m" ~ $^a ~ "\e[0m"; }

sub MAIN(*@ARGS){

	if (@ARGS.elems != $quantidade_argumentos) { 
		say q:to/END/;
		[!!!] ERRO: Quantidade inválida de argumentos!
		      uso: raku pomodoro.raku <t_estudos> <t_descanso> <sessões> 
		END
		exit;
	}
	else {
		my $t_estudos = @ARGS[0];
		my $t_descanso = @ARGS[1];
		my $sessoes = @ARGS[2];
		loop (my $i = 0; $i < $sessoes+1; $i++) {
			shell('clear');
			say q:to/END/;
			#=======================#
			|       POMODORO        |
			#=======================#
			END
				
			if $i == $sessoes { say "[SESSÕES COMPLETAS]: [!!!] "; }
			else { say "[SESSÃO ATUAL]: {$i+1}";}
			sessoes_visuais($sessoes, $i);
			sleep($t_estudos*60);
			alarme();
			say $verde("\n\n======= [DESCANSO] ======");
			sleep($t_descanso*60);
			alarme();
			shell('clear');
		}
	}
}	

multi sub sessoes_visuais ($totais, $passadas) {
	print $verde("██ ") x ($passadas) ~ $vermelho("██ ") x ($totais - $passadas);

}

multi sub alarme() {
	for 0 .. 5 -> $a { print "\a"; sleep(0.75); }
}
