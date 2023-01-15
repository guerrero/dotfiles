function mkdcd --description "Create new folder and cd into it" --argument-names dir
  mkdir $dir; and cd $dir
end
