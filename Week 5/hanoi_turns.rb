def hanoi_turns(n)
	if n==0
	0
	else
	hanoi_turns(n-1) + 1 + hanoi_turns(n-1)
	end
end