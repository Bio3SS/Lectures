## This is 3SS/Lectures

## Request
	##  http://avenue.mcmaster.ca/course/course_request_check.php
## Activate (cryptic):
	## Course admin/course offering information/active (then save)
## Swamp image: Drazen Nesic via pixnio

## UPDATE this number EVERYWHERE!
## :%s/371137/413706/g
## https://avenue.cllmcmaster.ca/d2l/home/413706

current: target
-include target.mk

-include makestuff/newtalk.def
-include makestuff/perl.def

######################################################################

vim_session:
	bash -cl "vmt notes.md lectures.txt"

## README is for people who might want to actually fork this; may not be up to date
Sources += Makefile README.md notes.md hours.md

## Keeping track of schedule
Sources += lectures.txt

######################################################################

## Resource documents (starting with course evaluations from 2021)
Ignore += resources
resources:
	$(LN) /home/dushoff/Dropbox/resources/3SS/ $@

Ignore += swamp.jpg
swamp.jpg: resources/swamp_orig.jpg Makefile
	convert -crop 5760x2304+0+1000 -scale 41.67% $< $@
	## convert -crop 5760x2304 -scale 41.67% $< $@

######################################################################

# mdirs += boxes life_tables sims

pardirs += exponential ts web
pardirs += compensation bd_models WA_Ebola_Outbreak dd
pardirs += Life_tables structure life_history age competition
pardirs += exploitation sims boxes
pardirs += covidCA

pushdir = web/materials/

hotdirs += $(pardirs)

alldirs += $(pardirs)

######################################################################

## Lectures

Sources += $(wildcard *.txt *.poll)

# Unit 1 (Intro)

intro.poll.csv: intro.txt pollcsv.pl
intro.html: intro.step
intro.outline.pdf: intro.txt

intro.draft.pdf: intro.txt
intro.final.pdf: intro.txt
intro.handouts.pdf: intro.txt
intro.complete.pdf: intro.txt
intro.handouts.docx: intro.handouts.tex

math.handouts.pdf: math.txt
math.complete.pdf: math.txt

# Unit 2 (Linear population growth)
linear.poll.csv: linear.txt pollcsv.pl
linear.html: linear.step
linear.outline.pdf: linear.txt

linear.final.pdf: linear.txt
linear.draft.pdf: linear.txt
linear.handouts.pdf: linear.txt
linear.complete.pdf: linear.txt

linear.handouts.pdf.pd:
linear.handouts.docx.pd:
linear.complete.pdf.pd:

# Unit 3 (Non-linear population growth)
nonlinear.poll.csv: nonlinear.txt pollcsv.pl
nonlinear.html: nonlinear.step
nonlinear.outline.pdf: nonlinear.txt

nonlinear.final.pdf: nonlinear.txt
nonlinear.draft.pdf: nonlinear.txt
nonlinear.handouts.pdf: nonlinear.txt
nonlinear.complete.pdf: nonlinear.txt

## delay.txt a suppressed section of nonlinear (2021)

# Unit 4 (Structured populations)
structure.poll.csv: structure.txt pollcsv.pl
structure.html: structure.step
structure.outline.pdf: structure.txt

structure.final.pdf: structure.txt
structure.draft.pdf: structure.txt
structure.handouts.pdf: structure.txt
structure.complete.pdf: structure.txt

# Unit 5 (Life history)
life_history.poll.csv: life_history.txt pollcsv.pl
life_history.html: life_history.step
life_history.outline.pdf: life_history.txt

life_history.final.pdf: life_history.txt
life_history.draft.pdf: life_history.txt
life_history.handouts.pdf: life_history.txt
life_history.complete.pdf: life_history.txt
life_history.cut.complete.pdf: life_history.txt

# Unit 6 (competition)
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
exploitation.poll.csv: exploitation.txt pollcsv.pl
exploitation.html: exploitation.step
exploitation.outline.pdf: exploitation.txt

exploitation.draft.pdf: exploitation.txt
exploitation.final.pdf: exploitation.txt
exploitation.handouts.pdf: exploitation.txt
exploitation.complete.pdf: exploitation.txt
exploitation.cut.complete.pdf: exploitation.txt

## Merged version 2022 Mar 27 (Sun)
disease.poll.csv: disease.txt pollcsv.pl
disease.html: disease.step
disease.outline.pdf: disease.txt

disease.final.pdf: disease.txt
disease.draft.pdf: disease.txt
disease.handouts.pdf: disease.txt
disease.complete.pdf: disease.txt

# Unit 9 (Corona supplement)
# Special lesson 2020 (early!) All deleted
# Supplement 2022 put in its place
corona.poll.csv: corona.txt pollcsv.pl
corona.html: corona.step
corona.outline.pdf: corona.txt

corona.final.pdf: corona.txt
corona.draft.pdf: corona.txt
corona.handouts.pdf: corona.txt
corona.complete.pdf: corona.txt

######################################################################

pandoc_r = pandoc -o $@ $<

%.handouts.docx: %.handouts.tex
	$(pandoc_r)

######################################################################

## Midterm complete notes

## Remember to search/destroy old CUTOFF before using
## If we keep these intermediate, they should disappear (and not be committed)
## structure.cut.complete.pdf: structure.txt
## life_history.cut.complete.pdf: life_history.txt
## competition.cut.complete.pdf: competition.txt
%.cut.txt: %.txt
	perl -npe "last if /CUTOFF/" $< | perl -npe "s/UNIT.*/UNIT Provisional notes/" > $@

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

## Video manipulation

Ignore += video
video/%: video
video: dir = ~/Dropbox/courses/3SS/2021/videos/
video:
	$(linkdirname)

Ignore += *.mp4

## Edit the stylus/fangirl lecture
0122.1.mp4: video/0122.mp4
	ffmpeg -y -i $< -ss 7 -to 792 -acodec copy $@
0122.2.mp4: video/0122.mp4
	ffmpeg -y -i $< -ss 832 -acodec copy $@

video/0122.edit.mp4: 0122.1.mp4 0122.2.mp4 0122.comb.txt

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
-include makestuff/texi.mk
-include makestuff/webpix.mk
-include makestuff/hotcold.mk
-include makestuff/video.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
