all: ngspice1.log ngspice2.log ngspice3.log ngspice4.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 2,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $(word 2,$^) | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $(word 2,$^) | grep -v $i_TAB | grep -v $i_END | sed 's/vx#branch/Ix/g' | sed 's/req/Req/g' | sed 's/vx/Vx/g' | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 3,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 4,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	
ngspice1.log: t2_1.cir
	ngspice -b $< -o $@
	
ngspice2.log: t2_2.cir
	ngspice -b $< -o $@
	
ngspice3.log: t2_3.cir
	ngspice -b $< -o $@
	
ngspice4.log: t2_4.cir
	ngspice -b $< -o $@

clean:
	@rm -f *.log *_ng.txt *_tab.tex *.ps *.pdf

.PHONY: all clean
