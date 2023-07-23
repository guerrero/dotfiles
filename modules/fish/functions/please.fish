function please --description "Execute the last written command using sudo"
    eval command sudo $history[1]
end
