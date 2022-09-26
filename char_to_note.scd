
// 텍스트 파일 읽어오기
~path = "/Users/giy/Desktop/sample.txt";
~str = FileReader.read(~path).postcs;


(
~str = "Several world leaders have denied wrongdoing after featuring in a huge leak of financial documents from offshore companies.

Dubbed the Pandora Papers, the 12 million files constitute the biggest such leak in history.

Russian President Vladimir Putin and Jordan's King Abdullah II bin Al-Hussein are among some 35 current and former leaders linked to the files.

Both have issued statements saying they have done nothing wrong.

Jordan's royal palace said it was \"not unusual nor improper\" that King Abdullah owned property abroad.

Leaked documents show the leader secretly spent more than £70m ($100m) on a property empire in the UK and US since taking power in 1999.";

// ~str = "AaBbCcDd";

~noteNames = ();
~noteNames.putPairs(['c', 60, 'd', 62, 'e', 64, 'f', 65, 'g', 67, 'a', 69, 'b', 71]);

fork{
	inf.do{
		~str.do {|char, i| // 위 문자열의 문자 하나씩이 char 로 들어옴
			var symRaw = char.asSymbol, amp = 0.1, sym = nil;
			if (symRaw.firstIsUpper, {amp = 0.5}, {amp = 0.1}); // 대문자인 경우 amp값을 크게
			sym = symRaw.toLower; // 문자를 소문자로 바꾼 후, symbol 타입으로 변경
			if (~noteNames.includesKey(sym), { // 만약 해당 문자가 ~noteNames에 있는 거라면,
				var n = ~noteNames[sym]; // 문자에 해당하는 노트 값을 가져와 n에 넣음
				("char: " ++ symRaw ++ ", " ++ "note: " ++ n).postln;
				(midinote: n, amp: amp).play;
			},
			{ // 해당 문자가 ~noteNames에 없다면
				("char: " ++ symRaw ++ ", " ++ "note: " ++ "Not defined").postln;
			});
			1.0.wait;
		};
		"loop...".postln;
	}
}
)
