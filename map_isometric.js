if(RadiumEngine !== undefined)
{
	/*Class*/ RadiumEngine.prototype.IsometricMap = function(canvas)
	{
		this.tile_width = 32;
		this.tile_height = 64;
		this.width = 6;
		this.height = 6;
		this.mouse_tile = undefined;
		this.mouse_over = false;
		this.fill_screen = false;
		
		this.canvas = canvas
		this.context = canvas.getContext("2d");
		
		$(this.canvas).bind('mouseenter', {'self': this}, function(event){
			self.mouse_over = true;
		});
		
		$(this.canvas).bind('mouseleave', {'self': this}, function(event){
			self.mouse_over = false;
		});
		
		$(this.canvas).bind('mousemove', {'self': this}, function(event){
			self = event.data.self;
			
			var rect = self.canvas.getBoundingClientRect();
			var root = document.documentElement;
			var mouse_x = event.clientX - rect.top - root.scrollTop;
			var mouse_y = event.clientY - rect.left - root.scrollLeft;
			var coords = event.data.self.TileFromPosition(mouse_x, mouse_y);
			
			self.mouse_tile = coords;
			/*$('#status').html(coords.x + " , " + coords.y);*/
			
			self.Redraw();
		});
		
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
			this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
			
			for(var i = 0; i < this.height; i++)
			{
				for(var r = 0; r < this.width; r++)
				{
					this.DrawTile(r, i);
					/*pos = this.GetTilePosition(r, i);
					this.context.fillRect(pos.x, pos.y, 1, 1);*/
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
			
			if(this.mouse_tile !== undefined && tile_x == this.mouse_tile.x && tile_y == this.mouse_tile.y)
			{
				this.context.fillStyle = "#D9FFB4";
				this.context.fill();
			}
			
			this.context.stroke();
		}
		
		this.GetBasePoint = function()
		{
			return new RadiumEngine.Point((this.width * this.tile_width) / 2, 0);
		}
		
		this.GetTileOrigin = function(tile_x, tile_y)
		{
			/* Determine base point (0,0) of the isometric diamond. */
			base_point = this.GetBasePoint();
			
			/* Determine offset for determining starting point for the current row (tile_y coordinate). */
			row_offset = new RadiumEngine.Point(0 - ((this.tile_width / 2) * tile_y), (this.tile_height / 2) * tile_y);
			
			/* Determine specific offset of the specified tile_x coordinate on the tile_y row. */
			tile_offset = new RadiumEngine.Point((this.tile_width / 2) * tile_x, (this.tile_height / 2) * tile_x);
			
			/* Return the sum of the above to determine the actual tile position on the canvas. */
			return base_point.Add(row_offset, tile_offset);
		}
		
		this.GetTilePosition = function(tile_x, tile_y)
		{
			origin = this.GetTileOrigin(tile_x, tile_y);
			
			return origin.Add(new RadiumEngine.Point(0 - (this.tile_width / 2), 0));
		}
		
		this.TileFromPosition = function(x, y)
		{
			p = new RadiumEngine.Point(x, y);
			a = self.GetBasePoint();
			b = a.Add(new RadiumEngine.Point(0 - (this.tile_width / 2), this.tile_height / 2));
			c = a.Add(new RadiumEngine.Point(this.tile_width / 2, this.tile_height / 2));
			
			/* Compute vectors. */    
			v0 = c.Subtract(a);
			v1 = b.Subtract(a);
			v2 = p.Subtract(a);

			/* Compute dot products. */
			dot00 = RadiumEngine.dot_product([v0.x, v0.y], [v0.x, v0.y]);
			dot01 = RadiumEngine.dot_product([v0.x, v0.y], [v1.x, v1.y]);
			dot02 = RadiumEngine.dot_product([v0.x, v0.y], [v2.x, v2.y]);
			dot11 = RadiumEngine.dot_product([v1.x, v1.y], [v1.x, v1.y]);
			dot12 = RadiumEngine.dot_product([v1.x, v1.y], [v2.x, v2.y]);

			/* Compute tile. */
			inv_denom = 1 / (dot00 * dot11 - dot01 * dot01);
			tile_x = (dot11 * dot02 - dot01 * dot12) * inv_denom;
			tile_y = (dot00 * dot12 - dot01 * dot02) * inv_denom;
			
			return new RadiumEngine.Point(Math.floor(tile_x), Math.floor(tile_y));
		}
	}
}
