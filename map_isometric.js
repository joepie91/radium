if(RadiumEngine !== undefined)
{
	/*Class*/ RadiumEngine.prototype.IsometricMap = function(canvas)
	{
		this.tile_width = 32;
		this.tile_height = 64;
		this.width = 6;
		this.height = 6;
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
			for(var i = 0; i < this.height; i++)
			{
				for(var r = 0; r < this.width; r++)
				{
					this.DrawTile(r, i);
					pos = this.GetTilePosition(r, i);
					this.context.fillRect(pos.x, pos.y, 1, 1);
				}
			}
		}
		
		this.DrawTile = function(tile_x, tile_y)
		{
			var pos_x = tile_x * this.tile_width;
			var pos_y = tile_y * this.tile_height;
			
			var t1 = this.GetTileOrigin(tile_x, tile_y);
			var t2 = t1.Add(new RadiumEngine.Point(this.tile_width / 2, this.tile_height / 2));
			var t3 = t1.Add(new RadiumEngine.Point(0, this.tile_height));
			var t4 = t1.Add(new RadiumEngine.Point(0 - (this.tile_width / 2), this.tile_height / 2));
			
			/*var t1 = new RadiumEngine.Point(pos_x + (this.tile_width / 2), pos_y);
			var t2 = new RadiumEngine.Point(pos_x + this.tile_width, pos_y + (this.tile_height / 2));
			var t3 = new RadiumEngine.Point(pos_x + (this.tile_width / 2), pos_y + this.tile_height);
			var t4 = new RadiumEngine.Point(pos_x, pos_y + (this.tile_height / 2));*/
			
			this.context.beginPath();
			
			this.context.moveTo(t1.x, t1.y);
			this.context.lineTo(t2.x, t2.y);
			this.context.lineTo(t3.x, t3.y);
			this.context.lineTo(t4.x, t4.y);
			this.context.lineTo(t1.x, t1.y);
			
			switch(tile_y)
			{
				case 0:
					this.context.lineWidth = 1;
					break;
				case 1:
					this.context.lineWidth = 2;
					break;
				case 2:
					this.context.lineWidth = 3;
					break;
				case 3:
					this.context.lineWidth = 4;
					break;
				case 4:
					this.context.lineWidth = 5;
					break;
				case 5:
					this.context.lineWidth = 6;
					break;
			}
			
			switch(tile_x)
			{
				case 0:
					this.context.strokeStyle = "blue";
					break;
				case 1:
					this.context.strokeStyle = "purple";
					break;
				case 2:
					this.context.strokeStyle = "green";
					break;
				case 3:
					this.context.strokeStyle = "red";
					break;
				case 4:
					this.context.strokeStyle = "maroon";
					break;
				case 5:
					this.context.strokeStyle = "black";
					break;
			}
			
			this.context.stroke();
		}
		
		this.GetTileOrigin = function(tile_x, tile_y)
		{
			/* Determine base point (0,0) of the isometric diamond. */
			base_point = new RadiumEngine.Point((this.width * this.tile_width) / 2, 0);
			console.log(base_point);
			/* Determine offset for determining starting point for the current row (tile_y coordinate). */
			row_offset = new RadiumEngine.Point(0 - ((this.tile_width / 2) * tile_y), (this.tile_height / 2) * tile_y);
			console.log(row_offset);
			/* Determine specific offset of the specified tile_x coordinate on the tile_y row. */
			tile_offset = new RadiumEngine.Point((this.tile_width / 2) * tile_x, (this.tile_height / 2) * tile_x);
			console.log(tile_offset);
			/* Return the sum of the above to determine the actual tile position on the canvas. */
			return base_point.Add(row_offset, tile_offset);
		}
		
		this.GetTilePosition = function(tile_x, tile_y)
		{
			origin = this.GetTileOrigin(tile_x, tile_y);
			
			return origin.Add(new RadiumEngine.Point(0 - (this.tile_width / 2), 0));
		}
	}
}
