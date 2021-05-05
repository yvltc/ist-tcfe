octave.log: t3.m
	octave $< > $@
	sed -i 's/$$/\\\\ \\hline/g' *_tab.tex
	mv *_tab.tex ../doc

clean:
	@rm -f octave.log *.txt *_tab.tex *.eps

.PHONY: clean
