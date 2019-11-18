## This is 3SS/Lectures, a screens project directory

## https://avenue.cllmcmaster.ca/d2l/home/273939
## Request
	##  http://avenue.mcmaster.ca/course/course_request_check.php
## Activate (cryptic):
	## Course admin/course offering information/active (then save)

current: target
-include target.mk

# include makestuff/perl.def

######################################################################

vim_session:
	bash -cl "vmt"

Sources += Makefile content.mk

## Keeping track of schedule
Sources += lectures.txt

## See .lmk rule
Drop = Define_image_drop_in_local.mk

-include $(ms)/newtalk.def
-include $(ms)/perl.def
-include local.mk
## -include $(ms)/repos.def

######################################################################

### Makestuff

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk
-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
