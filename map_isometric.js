if(RadiumEngine !== undefined)
{
	/*Class*/ RadiumEngine.prototype.IsometricMap = function(canvas)
	{
		this.tile_width = 32;
		this.tile_height = 64;
		this.width = 20;
		this.height = 20;
		this.fill_screen = false;
		
		this.canvas = canvas
		this.context = canvas.getContext("2d");
		
		var Configure = this.Configure = function(tile_width, tile_height)
		{
			this.tile_width = tile_width;
			this.tile_height = tile_height;
		}
		
		this.SetFill = function(enabled)
		{
			if(enabled === true)
			{
				$(this.canvas).css({
					'position': "absolute",
					'left': "0px",
					'top': "0px"
				});
				
				$('body').css({
					'overflow': "hidden"
				});
			}
			
			this.fill_screen = enabled;
			this.UpdateSize();
		}
		
		this.UpdateSize = function()
		{
			if(this.fill_screen === false)
			{
				this.canvas.width = $(this.canvas).width();
				this.canvas.height = $(this.canvas).height();
			}
			else
			{
				this.canvas.width = window.innerWidth;
				this.canvas.height = window.innerHeight;
				
				$(this.canvas).css({
					'width': window.innerWidth + "px",
					'height': window.innerHeight + "px"
				});
			}
		}
		
		var Redraw = this.Redraw = function()
		{
			console.log(this)
			for(var i = 0; i < 6; i++)
			{
				for(var r = 0; r < 6; r++)
				{
					this.DrawTile(r, i);
				}
			}
		}
		
		this.DrawTile = function(tile_x, tile_y)
		{
			var pos_x = tile_x * this.tile_width;
			var pos_y = tile_y * this.tile_height;
			
			var t1 = new RadiumEngine.Point(pos_x + (this.tile_width / 2), pos_y);
			var t2 = new RadiumEngine.Point(pos_x + this.tile_width, pos_y + (this.tile_height / 2));
			var t3 = new RadiumEngine.Point(pos_x + (this.tile_width / 2), pos_y + this.tile_height);
			var t4 = new RadiumEngine.Point(pos_x, pos_y + (this.tile_height / 2));
			
			this.context.beginPath();
			
			this.context.moveTo(t1.x, t1.y);
			this.context.lineTo(t2.x, t2.y);
			this.context.lineTo(t3.x, t3.y);
			this.context.lineTo(t4.x, t4.y);
			this.context.lineTo(t1.x, t1.y);
			
			this.context.lineWidth = 1;
			this.context.strokeStyle = "blue";
			this.context.stroke();
			
			this.context.beginPath();
			
			this.context.moveTo(pos_x, pos_y);
			this.context.lineTo(pos_x + this.tile_width, pos_y);
			this.context.lineTo(pos_x + this.tile_width, pos_y + this.tile_height);
			this.context.lineTo(pos_x, pos_y + this.tile_height);
			this.context.lineTo(pos_x, pos_y);
			
			this.context.lineWidth = 1;
			this.context.strokeStyle = "red";
			this.context.stroke();
		}
	}
}
