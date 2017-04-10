#!/bin/bash
# chmod 744 check_script_soft.sh

BLACK='tput setaf 0'
RED='tput setaf 1'
GREEN='tput setaf 2'
YELLOW='tput setaf 3'
BLUE='tput setaf 4'
MAGENTA='tput setaf 5'
CYAN='tput setaf 6'
WHITE='tput setaf 7'

STYLE_OFF='tput sgr0'

function title {
  echo
  echo `$CYAN`$1`$STYLE_OFF`
  echo
}

function not_found {
  echo `$RED` $1`$STYLE_OFF` ": Not found"
}

function check_soft {
  local PROGRAM_NAME=$1
  local EXECUTABLE_PROGRAM=$(which $PROGRAM_NAME)

  if [ $EXECUTABLE_PROGRAM ]; then
    echo `$GREEN` $EXECUTABLE_PROGRAM`$STYLE_OFF`
  else
    not_found $PROGRAM_NAME
  fi
}

function os_check {
  echo `$BLUE`$(uname -a)`$STYLE_OFF`

  if [ -d /etc ]; then
    # echo $(/etc/*release | wc | awk '{print $1}')
    echo `$BLUE`$(cat /etc/*release)`$STYLE_OFF`
  fi
}

function lang_vars_check {
  checking_env_vars=(LANGUAGE LANG LC_ALL LC_CTYPE)

  for var_name in ${checking_env_vars[*]}; do
    if [ -z "${!var_name}" ]; then
      echo "`$YELLOW`$var_name`$STYLE_OFF`" "`$RED`should be set`$STYLE_OFF`"
    else
      echo "`$YELLOW`$var_name`$STYLE_OFF`" "`$GREEN`has value:`$STYLE_OFF` `$CYAN`${!var_name}`$STYLE_OFF`"
    fi
  done
}

title "Base:"

os_check

check_soft 'gcc'
check_soft 'checkinstall'

title "Check LANG vars:"

lang_vars_check

title "Programming Langs:"

check_soft 'rvm'
check_soft 'ruby'
check_soft 'node'
check_soft 'python'

title "Converters:"

check_soft 'convert'

title "CacheStores:"

check_soft 'redis-server'

title 'DataBases:'

check_soft 'psql'
check_soft 'mysql'

title "Search:"

check_soft 'searchd'

title "Helpers:"

check_soft 'git'
check_soft 'tmux'
check_soft 'pygmentize'

title "Image Optimizers:"

check_soft 'gifsicle'
check_soft 'jhead'
check_soft 'jpegoptim'
check_soft 'jpegtran'
check_soft 'optipng'
check_soft 'pngcrush'
check_soft 'pngout'
check_soft 'pngquant'
check_soft 'advpng'
check_soft 'svgo'

title "WebServer:"

check_soft 'nginx'

# python -V
# pygmentize -V
