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
	var blah = "derp";
	
	var /*Exception*/ Exception = this.Exception = function(message)
	{
		this.message = message;
	}
	
	var /*Exception*/ ResourceException = this.ResourceException = function(message, resource, action)
	{
		this.resource = resource;
		this.message = message;
		this.action = action;
	}
	ResourceException.inheritsFrom(Exception);
	
	var /*Class*/ Player = this.Player = function()
	{
		this.credits = 0; /* Integer */
		this.health = 1; /* Fraction */
		this.resources = {}; /* Associative array -> Integer */
		
		this.TakeResource = function(resource, amount)
		{
			if(this.resources[resource])
			{
				this.resources[resource] -= amount;
			}
			else
			{
				throw new ResourceException("This resource does not exist.", resource, "take");
			}
		}
	}
	
	var point_distance = this.point_distance = function(x1, y1, x2, y2)
	{
		var xL = x1 - x2;
		var yL = y1 - y2;
		return Math.sqrt((xL * xL) + (yL * yL));
	}
}
