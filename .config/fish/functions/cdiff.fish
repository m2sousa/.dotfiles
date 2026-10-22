function cdiff --description "Review git changes with the neovim plugin codediff.nvim"
	if not git rev-parse --is-inside-work-tree &>/dev/null
		echo "cdiff: not a git repository. aborting." >&2
		return 1
	end

    nvim -c "CodeDiff --exit-on-close $argv"
end
