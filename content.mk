
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

## Deprecated 2019 Feb 09 (Sat)
midterm1.txt: nonlinear.txt Makefile
	perl -npe "last if /CUTOFF/" $< | perl -npe "s/UNIT.*/UNIT Midterm 1 extra notes/" > $@
## midterm1.complete.pdf: nonlinear.txt

######################################################################

-include $(ms)/hotcold.mk
