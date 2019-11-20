
## Directories

### Modules 

## A special module (should probably be a clone)
## Resting! investigate

clonedirs += WA_Ebola_Outbreak
WA_Ebola_Outbreak:
	git clone https://github.com/Outbreak-analysis/WA_Ebola_Outbreak.git

pushdir = ../web/materials


hotdirs += $(mdirs) $(clonedirs)
Sources += $(mdirs)

######################################################################


## Note chopping

day1.txt: intro.txt Makefile
	perl -npe "last if /Example/" $< | perl -npe "s/CHAPTER.*/CHAPTER Day 1 complete notes/" > $@
day1.complete.pdf: intro.txt

######################################################################

Sources += $(wildcard *.pl)

### NEWPOLL gone 2019 Feb 09 (Sat); don't use poll links anymore

## This can go for 2020 (still using it to clean 2018 lectures)
### Change NEWPOLL back to POLL once link is added
%.pollclean: %.txt
	perl -pi -e "s|NEWPOLL.*?everywhere.com/|POLL |" $<


## Poll conversion
## Use semi-colons for MC
## | for separation (or ?; will that work for pdf outputs?)
Ignore += *.poll.csv
%.poll.csv: %.txt pollcsv.pl
	$(PUSH)

######################################################################

## Midterm complete notes

## Deprecated 2019 Feb 09 (Sat)
midterm1.txt: nonlinear.txt Makefile
	perl -npe "last if /CUTOFF/" $< | perl -npe "s/UNIT.*/UNIT Midterm 1 extra notes/" > $@
## midterm1.complete.pdf: nonlinear.txt

## New paradigm 2019 Feb 09 (Sat)
## Remember to search/destroy old CUTOFF before using
## If we keep these intermediate, they should disappear (and not be committed)
life_history.cut.complete.pdf:
%.cut.txt: %.txt
	perl -npe "last if /CUTOFF/" $< | perl -npe "s/UNIT.*/UNIT Extra notes/" > $@

######################################################################

-include $(ms)/hotcold.mk
