(// Parallel fork morning, 211017
fork{
	1.do{

		fork{
			loop{
				(amp: 0.02).play;
				0.5.wait;
				(amp: 0.01).play;
				0.5.wait;
			}
		};

		// offset 1.0
		1.0.wait;
		fork{
			loop{
				(degree: 3, amp: 0.03).play;
				1.0.wait;
				(degree: 3, amp: 0.01).play;
				1.0.wait;
			}
		};

		// offset 1.0 + 5.0
		5.wait;
		fork{
			c = 0;
			d = Pseq([6, 3, 2, 2, 3, 6], inf).asStream;
			loop{
				(degree: -12 + d.next, amp: 0.02).play;
				(1.0/3).wait;
				c = c + 1;
			}
		};

		// offset 1.0 + 5.0 + 10.0
		10.wait;
		fork{
			t = Pwrand([1.0, 2.0, 1.0/3, 1.0/4, 1.0/6, 1.0/8], [2, 3, 5, 4, 3, 2].normalizeSum, inf).asStream;
			b = Pbrown(-12, 10, 4, inf).asStream;
			loop{
				(degree: (b+6).next, dur: t.next, amp: ([1.0, 0.9, 0.6, 0.5, 0.5, 0.3, 0.2]/12).choose).play;
				t.next.wait;
			}
		};


	}
}
)