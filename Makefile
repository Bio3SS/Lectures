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

# Content

vim_session:
	bash -cl "vmt"

Sources += Makefile content.mk

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
