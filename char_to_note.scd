~path = "/Users/giy/Desktop/sample.txt";
x = FileReader.read(~path).postcs;

'A'.abs
capitalize


(
~str = "Several world leaders have denied wrongdoing after featuring in a huge leak of financial documents from offshore companies.

Dubbed the Pandora Papers, the 12 million files constitute the biggest such leak in history.

Russian President Vladimir Putin and Jordan's King Abdullah II bin Al-Hussein are among some 35 current and former leaders linked to the files.

Both have issued statements saying they have done nothing wrong.

Jordan's royal palace said it was \"not unusual nor improper\" that King Abdullah owned property abroad.

Leaked documents show the leader secretly spent more than £70m ($100m) on a property empire in the UK and US since taking power in 1999.";

~noteNames = ();
~noteNames.putPairs(['c', 60, 'd', 62, 'e', 64, 'f', 65, 'g', 67, 'a', 69, 'b', 71]);
// ~noteNames.includesKey(~str[3].asSymbol);

fork{
	inf.do{
		~str.do {|char, i|
			var sym = char.toLower.asSymbol;
			if (~noteNames.includesKey(sym), {
				var n = ~noteNames[sym];
				("char: " ++ sym ++ ", " ++ "note: " ++ n).postln;
				(midinote: n).play;
			});
			0.1.wait;
		};
		"loop...".postln;
	}
}
)