/* Thanks to http://phrogz.net/js/classes/OOPinJS2.html */
Function.prototype.inheritsFrom = function(parentObject)
{ 
	if(parentClassOrObject.constructor == Function) 
	{ 
		/* Normal Inheritance */
		this.prototype = new parentObject;
		this.prototype.constructor = this;
		this.prototype.parent = parentObject.prototype;
	} 
	else 
	{ 
		/* Pure Virtual Inheritance */
		this.prototype = parentObject;
		this.prototype.constructor = this;
		this.prototype.parent = parentObject;
	}
	
	return this;
}

/*Class*/ RadiumEngine = function()
{
	this.version = "1.0";
	
	var point_distance = this.point_distance = function(x1, y1, x2, y2)
	{
		var xL = x1 - x2;
		var yL = y1 - y2;
		return Math.sqrt((xL * xL) + (yL * yL));
	}
}
