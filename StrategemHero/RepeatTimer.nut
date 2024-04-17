
class RepeatTimer extends Timer
{

	function isFinished()
	{
		if (time() - start > length)
		{
			reset()
			return true
		}
		return false
	}
}