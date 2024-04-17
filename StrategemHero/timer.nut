class Timer
{
	length = null
	start = null
	
	constructor(Length)
	{
		length = Length*1000
		start = time()
	}
	
	function isFinished()
	{
		if (time() - start > length)
			return true
		return false
	}
	
	function reset()
	{
		start = time()
	}
	
	function toString()
	{
		return format("%d",time(),start)
	}
}