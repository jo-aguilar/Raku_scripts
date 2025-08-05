#! /usr/bin/env perl6

# medit.raku $(raku -e 'put "3 " x 2 ~ "4 " x 3')

#Sequência em Fibonacci
#[0.1667, 0.1667, 0.3333, 0.5000, 0.8333, 1.3333, 2.1667, 3.5000, 5.6667]

sub temporizador (Numeric $tempo) {
	my $delta_tempo = $tempo*60;
	sleep($delta_tempo);
	put "\a";
}

sub terminar {
	for 0 ... 10 -> $n {
		put "\a", "[!!!] Fim das rotinas";
		sleep(1);
		shell('clear');
	}
}

sub MAIN (*@ARGS) {
	
		shell('clear');
		my $tempo_total = 0;
		for @ARGS -> $n { $tempo_total += +$n; }


		put "[TEMPO TOTAL]: $tempo_total minutos"; 
		for @ARGS -> $tempos {
			state $_ = 0;
			temporizador(+$tempos);
			$_++;
			shell('clear');
			NEXT print "[Rotina $_/{@ARGS.elems}] terminada", "\n";
		}
	terminar();

}


