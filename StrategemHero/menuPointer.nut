class menuPointer
{
	current = null
	limit = null

	constructor (_limit)
	{
		current = 0 
		limit = _limit
	}

	function eq(value)
	{
		return current == value
	}
	
	function _add(right)
	{
		current = (current + right) % limit
		return this
	}
	
	function _sub(right)
	{
		current = (current - right);
		if (current < 0)
			current = limit - 1
		return this
	}

	function _tostring()
	{
		return current.tostring()
	}
}