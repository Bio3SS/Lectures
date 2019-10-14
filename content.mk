
## This is staging, a dirdir under screens
## makestuff/direct.Makefile
current: target
-include target.mk

##################################################################

## Keep this directory clean. Stage, commit, delete
## The main purpose is to have a local rhdir, I think.
## It might be good to combine the screen_session with legacy to save
## a higher-level screen

## Use canonical names; stuff shouldn't stay here anyway

## makestuff/repohome.auto.mk: makestuff/repohome.list makestuff/repohome.pl

## svs git_Bio3SS_submodLectures ##
stageTarget = git_Bio3SS_Lectures
## Keep canonical names for smooth graduation pathway
vscreen: $(stageTarget:%=%.vscreen)
graduate: $(stageTarget:%=%.graduate)
forcegraduate: $(stageTarget:%=%.forcegraduate)

$(stageTarget):
	$(MAKE) rhdir/$@
	$(MV) rhdir/$@ $@

## Graduate by moving the directory to a permanent rhdir location

## Don't graduate unless you can all

## Make sure that the rhdir doesn't exist (usu because you moved it here)
## and then move the local dir back
%.graduate: rhdir %.all
	(! ls $</$*) && $(MV) $* $<

## Destroy the rhdir and then move
## This can be rolled into the above, since rhdir is not valuable
%.forcegraduate: rhdir %.all
	$(RMR) $</$* && $(MV) $* $<

######################################################################

## Backlog

pending += $(stageTarget)

Ignore += $(pending)

######################################################################

## Screens

## rprojdirs += insurance 1MP
## linkdirs += link

screen_session: 
	$(plvscreens)

## Vim

vim_session:
	bash -cl "vmt"

######################################################################

## linkdirs

sample: dir=~
sample: ; $(linkdir)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls ../makestuff/Makefile && /bin/ln -s ../makestuff 

-include makestuff/os.mk
-include makestuff/dirdir.mk
-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/repohome.mk

