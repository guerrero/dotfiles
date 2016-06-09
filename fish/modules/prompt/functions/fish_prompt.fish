function fish_prompt
	test $SSH_TTY; and printf (set_color red)(whoami)(set_color white)'@'(set_color yellow)(hostname)' '

    test $USER = 'root'; and echo (set_color red)"#"

    # Main
	echo -n (set_color magenta)(prompt_pwd)(set_color 56c4af)' ❯ '(set_color white)
end
