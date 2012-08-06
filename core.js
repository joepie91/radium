/* Thanks to http://phrogz.net/js/classes/OOPinJS2.html */
Function.prototype.inheritsFrom = function(parentObject)
{ 
	if(parentObject.constructor == Function) 
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
	
	var /*Exception*/ Warning = this.Warning = function(message)
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
	
	var /*Exception*/ ResourceWarning = this.ResourceWarning = function(message, resource, action)
	{
		this.resource = resource;
		this.message = message;
		this.action = action;
	}
	ResourceWarning.inheritsFrom(Warning);
	
	var /*Class*/ Player = this.Player = function()
	{
		this.credits = 0; /* Integer */
		this.health = 1; /* Fraction */
		this.resources = {}; /* Associative array -> Resource */
		
		this.InitializeResource = function(resource, negative_allowed, min, max)
		{
			var resource_object = new Resource();
			resource_object.name = resource;
			
			if(negative_allowed !== undefined)
			{
				resource_object.negative_allowed = negative_allowed;
			}
			
			if(min !== undefined)
			{
				resource_object.minimum = min;
			}
			
			if(min !== undefined)
			{
				resource_object.maximum = max;
			}
			
			if(min != null && min > 0)
			{
				/* Set current amount of units to minimum boundary. */
				resource_object.value = min;
			}
			
			this.resources[resource] = resource_object;
		}
		
		this.TakeResource = function(resource, amount)
		{
			if(this.resources[resource])
			{
				resource_object = this.resources[resource];
				
				if(resource_object.value - amount < 0 && resource_object.negative_allowed == false)
				{
					throw new ResourceException("There are not enough units of this resource available.", resource, "take");
				}
				else if(resource_object.minimum != null && resource_object.value - amount < resource_object.minimum)
				{
					throw new ResourceException("Taking away this many units will violate the lower resource boundary.", resource, "take");
				}
				else
				{
					resource_object.value -= amount;
				}
			}
			else
			{
				throw new ResourceException("This resource does not exist.", resource, "take");
			}
		}
		
		this.GiveResource = function(resource, amount)
		{
			if(this.resources[resource])
			{
				resource_object = this.resources[resource];
				
				if(resource_object.maximum != null && resource_object.value + amount > resource_object.maximum)
				{
					resource_object.value = resource_object.maximum;
					throw new ResourceWarning("The upper boundary of the resource was reached.", resource, "give");
				}
				else
				{
					resource_object.value += amount;
				}
			}
			else
			{
				throw new ResourceException("This resource does not exist.", resource, "give");
			}
		}
		
		this.SetResource = function(resource, amount)
		{
			if(this.resources[resource])
			{
				resource_object = this.resources[resource];
				
				if(resource_object.minimum != null && amount < resource_object.minimum)
				{
					throw new ResourceException("The specified amount is lower than the lower boundary of the resource.", resource, "set");
				}
				else if(resource_object.maximum != null && amount > resource_object.maximum)
				{
					throw new ResourceException("The specified amount is lower than the lower boundary of the resource.", resource, "set");
				}
				else if(resource_object.negative_allowed === false && amount < 0)
				{
					throw new ResourceException("This resource cannot be set to a negative amount.", resource, "set");
				}
				else
				{
					resource_object.value = amount;
				}
			}
			else
			{
				throw new ResourceException("This resource does not exist.", resource, "set");
			}
		}
	}
	
	var /*Class*/ Resource = this.Resource = function()
	{
		this.name = "Unnamed resource";
		this.negative_allowed = false;
		this.minimum = null;
		this.maximum = null;
		this.value = 0;
	}
	
	var /*Static Class*/ Point = RadiumEngine.Point = function(x, y)
	{
		this.x = x;
		this.y = y;
		
		this.Add = function()
		{
			var new_point = new RadiumEngine.Point(this.x, this.y);
			console.log(arguments);
			for (i in arguments)
			{
				new_point.x += arguments[i].x;
				new_point.y += arguments[i].y;
			}
			
			return new_point;
		}
	}
	
	var /*Static*/ point_distance = RadiumEngine.point_distance = function(x1, y1, x2, y2)
	{
		var xL = x1 - x2;
		var yL = y1 - y2;
		return Math.sqrt((xL * xL) + (yL * yL));
	}
}
