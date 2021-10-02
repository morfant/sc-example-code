// play 안에 함수가 있을 때
(
play{
	f = { |freq = (26.midicps) | LFDNoise3.ar(0.2, 0.1) };
}
)


// var gate 형태 확인
{LFTri.ar(1/30, 1)}.plot(30)

{Pulse.kr(5)}.plot(1);
trace

s.meter.alwaysOnTop_(s)

// k와 i의 변화 양상
(
{|k|
	("k = " ++ k).postln;
	{|i|
		  ("\ti = " ++ i).postln;
	}!(k/2 + 1).asInteger;
} ! 16;
)



(
~makePulse = {|i|
	Pulse.ar(10.0.rand, 0.5.rrand(0.95));
} ! 12;
)

// .product
[6,2,12].product;

// Pan2
(
	Pan2.ar((
		~makePulse.()
	)
))

// Pan2 + .product
(
Pan2.ar((
	~makePulse.()
).product;
))


// https://ko.wikipedia.org/wiki/%EC%86%8C%EC%88%98_(%EC%88%98%EB%A1%A0)
3.nthPrime;





SinOsc


({ |k| // 0 ~ 15
Pan2.ar(
	({ |i| // 0 ~ ((k/2 + 1).asInteger - 1)
				Pulse.ar(
					i * k + 2 / (k + 1) * rootFreq * (i + 1) * 0.0625 * 16,
					LinLin.ar(LFTri.ar(rootFreq * (i + 1) / 1024), -1, 1, 0.5, 0.95)
                    )} ! (k/2 + 1).asInteger).product // (k/2 + 1) 개의 인자를 가진 배열의 인자들 값을 모두 곱한 결과
				* (k + 1).reciprocal
				* LinExp.ar(Blip.ar(
					(k + 5).nthPrime.reciprocal * rootFreq * 0.125, 3), -1, 1, -48.dbamp, 1).neg,

				LFTri.ar((k + 1).nthPrime * rootFreq / 256) // pos
			)
} ! 16).sum



Pan2.ar(({|i| i.postln} ! 6));
