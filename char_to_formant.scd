
(
SynthDef.new(\vowel, {
	arg fund_midi = 72, amp = 0.2, gate = 1,
	form_freq = #[800, 1050, 2900, 3900, 4950],
	bw_form_freq = #[80, 90, 120, 130, 140],
	sub_db = #[0, 6, 32, 20, 50];
	var fund_freq, vib, db, sig, env;

	fund_freq = midicps(fund_midi);
	db = ampdb(amp);

	vib = SinOsc.kr(6, 0, midicps(fund_midi + XLine.kr(0.008, 0.2, 1.3)) - fund_freq); //vibrato
	fund_freq = fund_freq + vib;

	env = EnvGen.kr(Env.perc(0.1, 0.5, curve: 10), gate, doneAction: 2);
	sig = Formant.ar(fund_freq, form_freq, bw_form_freq, dbamp(db - sub_db)).sum;
	Out.ar(0, Pan2.ar(sig * env, 0, 1.0));

}, variants:(
	a: [form_freq: #[800, 1050, 2900, 3900, 4950], bw_form_freq: #[80, 90, 120, 130, 140], sub_db: #[0, 6, 32, 20, 50]],
	e: [form_freq: #[350, 2000, 2800, 3600, 4950], bw_form_freq: #[60, 100, 120, 150, 200], sub_db: #[0, 20, 15, 40, 56]],
	i: [form_freq: #[270, 2140, 2950, 3900, 4950], bw_form_freq: #[60, 90, 100, 120, 120], sub_db: #[0, 12, 26, 26, 44]],
	o: [form_freq: #[450, 800, 2830, 3800, 4950], bw_form_freq: #[70, 80, 100, 130, 135], sub_db: #[0, 11, 22, 22, 50]],
	u: [form_freq: #[325, 700, 2700, 3800, 4950], bw_form_freq: #[50, 60, 170, 180, 200], sub_db: #[0, 16, 35, 40, 60]])
).add
)



~path = "/Users/giy/Desktop/sample.txt";
x = FileReader.read(~path).postcs;

~prevChar = 'c';
~prevChar.ascii;

// https://www.bbc.com/news/science-environment-24021772
(
~str = "World temperatures are rising because of human activity, and climate change now threatens every aspect of human life.
Left unchecked, humans and nature will experience catastrophic warming, with worsening droughts, greater sea level rise and mass extinction of species.
We face a huge challenge, but there are potential solutions.
What is climate change?
Climate is the average weather in a place over many years. Climate change is a shift in those average conditions.
The rapid climate change we are now seeing is caused by humans using oil, gas and coal for their homes, factories and transport.
When these fossil fuels burn, they release greenhouse gases - mostly carbon dioxide (CO2). These gases trap the Sun's heat and cause the planet's temperature to rise.
The world is now about 1.2C warmer than it was in the 19th Century - and the amount of CO2 in the atmosphere has risen by 50%";

// ~str = "papapapa popopopo tapatapa topotopo lalahana lolohono vababava zoxoxozo";

~vowelNames = ();
~vowelNames.putPairs(['a', 'vowel.a', 'e', 'vowel.e' , 'i', 'vowel.i', 'o', 'vowel.o', 'u', 'vowel.u']);

~prevChar = '0';
fork{
	inf.do{
		~str.do {|char, i|
			var sym = char.toLower.asSymbol;
			if (~vowelNames.includesKey(sym), {
				var synth_variant = ~vowelNames[sym];
				"[".post;
				char.post;
				"]".post;
				Synth(synth_variant, [\fund_midi, (50 + ((~prevChar.ascii) % 24))]);
			}, {
				char.post;
			});
			0.2.wait;
			~prevChar = char;
		};
		"loop...".postln;
	}
}
)


