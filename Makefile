## This is 3SS/Lectures, a screens project directory

## https://avenue.cllmcmaster.ca/d2l/home/273939
## Request
	##  http://avenue.mcmaster.ca/course/course_request_check.php
## Activate (cryptic):
	## Course admin/course offering information/active (then save)

current: target
-include target.mk

-include makestuff/newtalk.def
-include makestuff/perl.def

######################################################################

vim_session:
	bash -cl "vmt README.md"

Sources += Makefile README.md notes.md

## Keeping track of schedule
Sources += lectures.txt

######################################################################

# mdirs += age boxes competition dd exploitation life_tables sims structure

pardirs += exponential ts web
pardirs += compensation bd_models WA_Ebola_Outbreak dd
pardirs += Life_tables structure life_history age

pushdir = web/materials/

hotdirs += $(pardirs)

######################################################################

## Lectures

Sources += $(wildcard *.txt *.poll)

# Unit 1 (Intro)

## intro.pollclean: 
intro.poll.csv: intro.txt pollcsv.pl
intro.html: intro.step
intro.outline.pdf: intro.txt

intro.draft.pdf: intro.txt
intro.final.pdf: intro.txt
intro.handouts.pdf: intro.txt
intro.complete.pdf: intro.txt

math.handouts.pdf: math.txt
math.complete.pdf: math.txt

# Unit 2 (Linear population growth)
linear.pollnew: 
## linear.pollclean: 
linear.poll.csv: linear.txt pollcsv.pl
linear.html: linear.step
linear.outline.pdf: linear.txt

linear.final.pdf: linear.txt
linear.draft.pdf: linear.txt
linear.handouts.pdf: linear.txt
linear.complete.pdf: linear.txt

# Unit 3 (Non-linear population growth)
nonlinear.pollnew: 
nonlinear.poll.csv: nonlinear.txt pollcsv.pl
nonlinear.html: nonlinear.step
nonlinear.outline.pdf: nonlinear.txt

nonlinear.final.pdf: nonlinear.txt
nonlinear.draft.pdf: nonlinear.txt
nonlinear.handouts.pdf: nonlinear.txt
nonlinear.complete.pdf: nonlinear.txt

# Special lesson
corona.pollnew: 
corona.poll.csv: corona.txt pollcsv.pl
corona.html: corona.step
corona.outline.pdf: corona.txt

corona.final.pdf: corona.txt
corona.draft.pdf: corona.txt
corona.handouts.pdf: corona.txt
corona.complete.pdf: corona.txt

# Unit 4 (Structured populations)
structure.poll.csv: structure.txt pollcsv.pl
structure.html: structure.step
structure.outline.pdf: structure.txt

structure.final.pdf: structure.txt
structure.draft.pdf: structure.txt
structure.handouts.pdf: structure.txt
structure.complete.pdf: structure.txt

# Unit 5 (Life history)
## life_history.pollclean: 
life_history.poll.csv: life_history.txt pollcsv.pl
life_history.html: life_history.step
life_history.outline.pdf: life_history.txt

life_history.final.pdf: life_history.txt
life_history.draft.pdf: life_history.txt
life_history.handouts.pdf: life_history.txt
life_history.complete.pdf: life_history.txt

# Unit 6 (competition)
## competition.pollclean: 
competition.poll.csv: competition.txt pollcsv.pl
competition.html: competition.step
competition.outline.pdf: competition.txt

competition.final.pdf: competition.txt
competition.draft.pdf: competition.txt
competition.handouts.pdf: competition.txt
competition.complete.pdf: competition.txt

humble.draft.pdf: humble.txt
humble.html: humble.step

# Unit 7 (exploitation)
## exploitation.pollclean: 
exploitation.poll.csv: exploitation.txt pollcsv.pl
exploitation.html: exploitation.step
exploitation.outline.pdf: exploitation.txt

exploitation.draft.pdf: exploitation.txt
exploitation.final.pdf: exploitation.txt
exploitation.handouts.pdf: exploitation.txt
exploitation.complete.pdf: exploitation.txt

# Unit 8 (Disease)
## disease.pollclean: 
disease.poll.csv: disease.txt pollcsv.pl
disease.html: disease.step
disease.outline.pdf: disease.txt

disease.final.pdf: disease.txt
disease.draft.pdf: disease.txt
disease.handouts.pdf: disease.txt
disease.complete.pdf: disease.txt

######################################################################

## Midterm complete notes

## Remember to search/destroy old CUTOFF before using
## If we keep these intermediate, they should disappear (and not be committed)
## nonlinear.cut.complete.pdf: nonlinear.txt
%.cut.txt: %.txt
	perl -npe "last if /CUTOFF/" $< | perl -npe "s/UNIT.*/UNIT Extra notes/" > $@

######################################################################

## Image directories

imageDrop = ~/Dropbox/3SS
## echo "imageDrop = ~/Dropbox/courses/3SS" > local.mk ##
Ignore += local.mk
-include local.mk

######################################################################

## Pixfiles (too many!!)
aging.html: aging.step
competition.html: competition.step
dandelions.html: dandelions.step
diseases.html: diseases.step
dynamics.html: dynamics.step
ebola.html: ebola.step
evaluation.html: evaluation.step
exploitation.html: exploitation.step
flu.html: flu.step
health.html: health.step
het.html: het.step
hiv.html: hiv.step
import.html: import.step
journals.html: journals.step
life_history.html: life_history.step
logs.html: logs.step
models.html: models.step
nonlinear.html: nonlinear.step
philosophy.html: philosophy.step
populations.html: populations.step
rabies.html: rabies.step
structure.html: structure.step
units.html: units.step

######################################################################

## Formatting
## Script is talkdir/lect.pl
## Current rules are in talkdir/txt.format _and_
Sources += local.txt.format

## Copyright notice
Sources += copy.tex

## Directory-specific latex commands
Sources += pop.tex localcomm.tex

######################################################################

Sources += $(wildcard *.pl)

## Poll conversion
## Use semi-colons for MC
## | for separation (or ?; will that work for pdf outputs?)
Ignore += *.poll.csv
%.poll.csv: %.txt pollcsv.pl
	$(PUSH)

######################################################################

### Makestuff

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk
-include makestuff/newtalk.mk
-include makestuff/texdeps.mk
-include makestuff/webpix.mk
-include makestuff/hotcold.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
