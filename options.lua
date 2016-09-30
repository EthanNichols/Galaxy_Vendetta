
options = {}

playersInGame = 2

previousGamestate = 0

function options.load()
	optionsFont = love.graphics.newFont(25)

	local button = 0
	local text = "Players: " .. playersInGame
	local ring = 3

	while button < 3 do
		if button == 1 then
			text = "Controls"
			ring = 2
		elseif button == 2 then
			text = "Exit"
			ring = 1
		end

		table.insert(options, 
					{x = love.graphics.getWidth() / 2 - optionsFont:getWidth(text) / 2,
					y = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 7 * ring + 10,
					text = text,
					r = 255,
					g = 255,
					b = 255})
		button = button + 1
	end
end

function options.update(dt)

	local mouseX, mouseY = love.mouse.getPosition()

	for i, v in ipairs(options) do
		if mouseX >= v.x and
		mouseX <= v.x + optionsFont:getWidth(v.text) and
		mouseY >= v.y and
		mouseY <= v.y + optionsFont:getHeight(v.text) then
			v.r = 0
			v.b = 0
		else
			v.r = 255
			v.b = 255
		end
	end
end

function options.mousepressed(x, y, button)
	for i, v in ipairs(options) do
		if x >= v.x and
		x <= v.x + optionsFont:getWidth(v.text) and
		y >= v.y and
		y <= v.y + optionsFont:getHeight(v.text) then
			if v.text == "Players: " .. playersInGame then
				if button == 1 then
					playersInGame = playersInGame + 1
				elseif button == 2 and
				playersInGame ~= 2 then
					playersInGame = playersInGame - 1
				end
				v.text = "Players: " .. playersInGame
				players.load(playersInGame)
			elseif v.text == "Controls" then
				gamestate = "controls"
			elseif v.text == "Exit" then
				gamestate = previousGamestate
			end
		end
	end
end

function options.draw()
	love.graphics.setFont(optionsFont)
	for i, v in ipairs(options) do
		love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.print(v.text, v.x, v.y)
	end
end