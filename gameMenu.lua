
gameMenu = {}

function gameMenu.load()
	gameMenuFont = love.graphics.newFont(25)

	local button = 0
	local text = "Resume Game"
	local ring = 3

	while button < 3 do
		if button == 1 then
			text = "Options"
			ring = 2
		elseif button == 2 then
			text = "Main Menu"
			ring = 1
		end

		table.insert(gameMenu, 
					{x = love.graphics.getWidth() / 2 - gameMenuFont:getWidth(text) / 2,
					y = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 7 * ring + 10,
					text = text,
					r = 255,
					g = 255,
					b = 255})
		button = button + 1
	end
end

function gameMenu.update(dt)

	local mouseX, mouseY = love.mouse.getPosition()

	for i, v in ipairs(gameMenu) do
		if mouseX >= v.x and
		mouseX <= v.x + gameMenuFont:getWidth(v.text) and
		mouseY >= v.y and
		mouseY <= v.y + gameMenuFont:getHeight(v.text) then
			v.r = 0
			v.b = 0
		else
			v.r = 255
			v.b = 255
		end
	end
end

function gameMenu.mousepressed(x, y, button)
	for i, v in ipairs(gameMenu) do
		if x >= v.x and
		x <= v.x + gameMenuFont:getWidth(v.text) and
		y >= v.y and
		y <= v.y + gameMenuFont:getHeight(v.text) then
			if v.text == "Resume Game" then
				gamestate = "game"
			elseif v.text == "Options" then
				gamestate = "options"
				previousGamestate = "gameMenu"
			elseif v.text == "Main Menu" then
				gamestate = "mainMenu"
			end
		end
	end
end

function gameMenu.draw()
	love.graphics.setFont(gameMenuFont)
	for i, v in ipairs(gameMenu) do
		love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.print(v.text, v.x, v.y)
	end
end