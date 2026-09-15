#! /usr/bin/env perl6

proto sub lista_numerica {*};
proto sub lista_temporal(@lista) {*};
proto sub retorna_string(@lista_de_retorno) {*};

sub MAIN (*@ARGS) {
	if ( @ARGS.elems == 1 ) {
		my $diretorio = $?FILE.IO.parent;
		if ( @ARGS[0] eq "aleatorio" ) {
			my $string = retorna_string(lista_temporal(lista_numerica));
			my $comando = \qq[raku $diretorio/medit.raku \$( raku -e {$string})];
			shell($comando);
		}

		elsif ( @ARGS[0] eq "regular" ) {
			shell ("raku $diretorio/medit.raku \$(raku -e 'put 
			\"4 \" x 2 ~ 
			\"2 \" x 2 ~
			\"1 \" x 2 ~
			\"0.5 \" x 2 ~
			\"0.25 \" x 2 ~
			\"0.125 \" x 2 ~
			\"0.075 \" x 2' )");
		}
		elsif (@ARGS[0] eq "fib" ) {
			shell ("raku $diretorio/medit.raku \$(raku -e 'put
			\"0.25 \" x 1 ~ 
			\"0.1667 \" x 1 ~
			\"0.1667 \" x 1 ~
			\"0.3333 \" x 1 ~
			\"0.5000 \" x 1 ~
			\"0.8333 \" x 1 ~
			\"1.3333 \" x 1 ~
			\"2.1667 \" x 1 ~
			\"3.5000 \" x 1 ~
			\"5.6667 \" x 1' )");
		}
		elsif ( @ARGS[0] eq "palin" ) {
			shell ("raku $diretorio/medit.raku \$(raku -e 'put
			\"0.25 \" x 1 ~ 
			\"0.1667 \" x 1 ~
			\"0.1667 \" x 1 ~
			\"0.3333 \" x 1 ~
			\"0.5000 \" x 1 ~
			\"0.8333 \" x 1 ~
			\"1.3333 \" x 1 ~
			\"2.1667 \" x 1 ~
			\"3.5000 \" x 1 ~
			\"2.1667 \" x 1 ~
			\"1.3333 \" x 1 ~
			\"0.8333 \" x 1 ~
			\"0.5000 \" x 1 ~
			\"1.3333 \" x 1 ~
			\"0.1667 \" x 1 ~
			\"0.1667 \" x 1 ~
			\"0.025 \" x 1' )");
			
		}
		else {
			say q:to/END/;
			[!!!] ERRO: Entrada inválida. 
			      Entradas válidas são somente [fib], [regular], 
			      [aleatorio] e [palin]
			END
			exit;
		}

	}
	else { 
		say q:to/END/; 
		[!!!] ERRO: Mais de um elemento!
		      uso: raku meditar.raku <ARG> +
		      aleatorio | regular | fib | palin

		END
		exit;
		}
}



multi sub lista_numerica {
	my @lista1;
	my @lista2;

	while (@lista1.elems != 9 or @lista2.elems != 9) {
		my $var1 = Int((1..10).rand);
		my $var2 = Int((1..10).rand);
		@lista1.push($var1) unless ($var1 (elem) @lista1);
		@lista2.push($var2) unless ($var2 (elem) @lista2);
	}
	return (|@lista1,  |@lista2);
}

multi sub lista_temporal (@lista) {
	my $tempos = (0.25, 0.1667, 0.1667, 0.3333, 0.5, 0.8333, 1.3333, 2.1667, 3.5);
	my $tamanho_lista = @lista.elems-1;
	my @lista_de_retorno = List.new;
	for 0 ... $tamanho_lista -> $n {
		@lista_de_retorno.push($tempos[@lista[$n]-1]);
	}
	return @lista_de_retorno;
}

multi sub retorna_string (@lista_de_retorno) {
	my $tamanho_lista = @lista_de_retorno.elems-1;
	my $string_de_saida = qq['put ];
	for 0 .. $tamanho_lista -> $n {
		if ($n < $tamanho_lista) {
			$string_de_saida ~= qq["{@lista_de_retorno[$n]} " x 1 ~ ];
		}
		else{
			$string_de_saida ~= qq["{@lista_de_retorno[$n]} " x 1'];
		}
	}
	return $string_de_saida;
}
