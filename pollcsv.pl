use strict;
use 5.10.0;

$/ = "";
my $tag = "POLL";

## Decide here how closely to match tag
## Fancier would be to make tag an array pointer and loop through it
while (<>){
	## next unless s/^\s*$tag\b\s*//;
	next unless s/$tag\b\s*//;
	chomp;

	## Optionally have a pipe separating the lecture question from the everywhere question
	## 2018 Mar 01 (Thu) Experimenting with ? divider as well. Why not?
	## ? Only works if there are two of them. 
	## Don't have two ?s and also a |
	s/.*[|]//s;
	s/.*[?]\s*(.*[?])/$1/s;
	s/\s*\n\s*/ /g;

	## Choices start after .?:
	my ($ques, $choices) = /(.*?[.?:])(.*)/;
	# say "Ques: $ques";
	# say "Choice: $choices";

	## … split by ;
	my @choices = split /;\s*/, $choices;
	# @choices = map {s/.*/"$&"/} @choices;
	print "Poll, ";
	if (@choices>1){
		print "Multiple choice, ";
	} else {
		print "Open-ended, ";
	}

	print $ques . ', ';
	say join ", ", @choices;
}
