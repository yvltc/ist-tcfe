all: ngspice_z_out.log ngspice.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSTABS=$(shell grep _TAB $(word 2,$^) | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $(word 2,$^) | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	
	sed -i '1 r out_imp_tab.tex' data_tab.tex
	mv *.eps *.tex ../doc
	
ngspice_z_out.log: t5_out_impedance.cir
	ngspice -b $< -o $@
		
ngspice.log: t5.cir
	ngspice -b $< -o $@

clean:
	@rm -f *.log *_ng.txt *_tab.tex *.eps *.pdf *.ps

.PHONY: all clean
