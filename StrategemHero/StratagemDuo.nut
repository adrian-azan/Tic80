class StratagemDuo extends Stratagem
{
	_additionalSpriteId = null
	
	constructor(spriteId, additionalSpriteId, combo,name)
	{
	
		base.constructor(spriteId,combo,name)
		
		_additionalSpriteId = additionalSpriteId
	}
	
	function draw(x,y)
	{
		base.draw(x,y);
		
		spr(_additionalSpriteId,x-7,y+20,15,2,0,0,2,2)

	}
}
