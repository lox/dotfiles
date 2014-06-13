
if [[ "$(ls /Library/Java/JavaVirtualMachines | wc -l)" -ne 0 ]] ; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

export EDITOR=vim