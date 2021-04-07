octave.log: t2.m
	octave $< > $@
	mv *_ng.txt ../sim
	sed -i 's/$$/\\\\ \\hline/g' *_tab.tex
	mv *_tab.tex ../doc

clean:
	@rm -f octave.log *.txt *_tab.tex *.eps
	

.PHONY: clean
