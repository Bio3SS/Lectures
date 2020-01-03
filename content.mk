
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
