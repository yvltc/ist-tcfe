octave.log: t2.m
	octave $< > $@
	mv *_ng.txt ../sim
	sed -i 's/$$/\\\\ \\hline/g' Nodal_tab.tex

clean:
	@rm -f octave.log data.txt *_tab.tex
	

.PHONY: clean
