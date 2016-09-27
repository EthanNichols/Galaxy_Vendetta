
mainMenu = {}

function mainMenu.load()
	mainMenuFont = love.graphics.newFont(25)

	local button = 0
	local text = "Play Game"
	local ring = 3

	while button < 3 do
		if button == 1 then
			text = "Options"
			ring = 2
		elseif button == 2 then
			text = "Exit"
			ring = 1
		end

		table.insert(mainMenu, 
					{x = love.graphics.getWidth() / 2 - mainMenuFont:getWidth(text) / 2,
					y = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 7 * ring + 10,
					text = text,
					r = 255,
					g = 255,
					b = 255})
		button = button + 1
	end
end

function mainMenu.update(dt)

	local mouseX, mouseY = love.mouse.getPosition()

	for i, v in ipairs(mainMenu) do
		if mouseX >= v.x and
		mouseX <= v.x + mainMenuFont:getWidth(v.text) and
		mouseY >= v.y and
		mouseY <= v.y + mainMenuFont:getHeight(v.text) then
			v.r = 0
			v.b = 0
		else
			v.r = 255
			v.b = 255
		end
	end
end

function mainMenu.mousepressed(x, y, button)
	for i, v in ipairs(mainMenu) do
		if x >= v.x and
		x <= v.x + mainMenuFont:getWidth(v.text) and
		y >= v.y and
		y <= v.y + mainMenuFont:getHeight(v.text) then
			if v.text == "Play Game" then
				gamestate = "game"
				players.load(playersInGame)
			elseif v.text == "Options" then
				gamestate = "options"
				previousGamestate = "mainMenu"
			elseif v.text == "Exit" then
				exit()
			end
		end
	end
end

function mainMenu.draw()
	love.graphics.setFont(mainMenuFont)
	for i, v in ipairs(mainMenu) do
		love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.print(v.text, v.x, v.y)
	end
end