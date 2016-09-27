function lower_case -a string
  echo $string | tr A-Z a-z
end

function kebab_case -a string
  echo (lower_case (string replace -a ' ' - $string))
end

function replace_dashes_by_spaces
  echo (string replace -a - ' ' $string)
end

function title_case -a string
  set -l matches (string match -r -a '\b[a-z]' $string)

  for match in $matches
    set -l upper (echo $match | tr a-z A-Z)
    set string (echo (string replace -r '\b[a-z]' $upper $string))
  end

  echo $string
end
