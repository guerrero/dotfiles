function rm_ds_store_files --description 'Remove all DS_Store files recursively in the current folder'
  find . -name '*.DS_Store' -type f -ls -delete
end