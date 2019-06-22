#serach php and phtml files
phpgrep() { # search php files
    ack --smart-case --type=php $1
}
rbgrep() { # search php files
    ack --smart-case --type=ruby $1
}
ubergrep() { #search all files
    ack --smart-case $1
}
jsgrep() { #search js files
    ack --smart-case --type=js $1
}
cssgrep() { #search css files
    ack --smart-case --type=css $1
}
sassgrep() { # search development css files
find . \( -name "*.scss" -print \)  | xargs grep -n "$1"
}
jssgrep() { # search development css files
find . \( -name "*.js" -print \)  | xargs grep -n "$1"
}
hgrep(){
history | grep "$1"
}
# I often want awk '{print <var>}'
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

function stagedLines() {
	git status -s | grep '^M|^A' |  egrep '\.php|\.js$' | egrep -v 'tests/' | \
	egrep -v '/assets/build' | awk '{print $2}' | xargs -L 1 git diff origin/master | wc -l
}

function vipdiff {
	git diff --name-status origin/master...$1 | grep '\.php|\.js$' | \
	grep -v 'tests/' | grep -v '/assets/build' | \
	awk '{print $2}' | xargs -L 1 git diff origin/master | wc -l
}

# Prepend a string 
function prepend {
    first="awk '{print "
    last="}'"
    cmd="${first}\"\${1}\"$0${last}"
    eval $cmd
}

# Print a histogram, with setable unit size
function histogram {
    UNIT=$1
    if [ -z "$UNIT" ]; then
        UNIT="1";
    fi

    first="sort|uniq -c|awk '{printf(\"\n%s \", \$0); for (i =0; i<\$1; i=i+"
    last=") {printf(\"#\")};}'; echo \"\""
    cmd="${first}${UNIT}${last}"
    eval $cmd
}

function calc {
    awk "BEGIN{ print $* }";
}

function getip {
    host $1|grep " has address "|cut -d" " -f4
}

sniff="sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp'"

difff() {
    svn diff > ~/diff.diff
    vim ~/diff.diff
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}



# cat or zcat all the access logs in a folder 
# Pass in folder to search in as the only param
# Likely want > into another file for further use
access_concat(){
	find $1 -name "acc*" -not -name "*.gz" -exec cat '{}' \;
	find $1 -name "acc*" -name "*.gz" -exec zcat '{}' \;
}
