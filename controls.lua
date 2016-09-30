
controls = {}

local playerNumber = 1

local setOutKey = false
local setInKey = false

function controls.load()
	controlsFont = love.graphics.newFont(25)

	local button = 0
	local text = "Player: " .. playerNumber
	local ring = 3

	while button < 4 do
		if button == 1 then
			text = "Out: "
			ring = 2
		elseif button == 2 then
			text = "In: "
			ring = 1
		elseif button == 3 then
			text = "Exit"
			ring = -1
		end

		table.insert(controls, 
					{buttonNum = button;
					x = love.graphics.getWidth() / 2 - controlsFont:getWidth(text) / 2,
					y = love.graphics.getHeight() / 2 - (love.graphics.getHeight() / 7) * ring + 10,
					text = text,
					r = 255,
					g = 255,
					b = 255})
		button = button + 1
	end
end

function controls.update(dt)

	local mouseX, mouseY = love.mouse.getPosition()

	for i, v in ipairs(controls) do
		if mouseX >= v.x and
		mouseX <= v.x + controlsFont:getWidth(v.text) and
		mouseY >= v.y and
		mouseY <= v.y + controlsFont:getHeight(v.text) then
			v.r = 0
			v.b = 0
		else
			v.r = 255
			v.b = 255
		end
	end
end

function controls.mousepressed(x, y, button)

	local outText = ""
	local inText = ""
	local playerChange = false

	for i, v in ipairs(controls) do
		if x >= v.x and
		x <= v.x + controlsFont:getWidth(v.text) and
		y >= v.y and
		y <= v.y + controlsFont:getHeight(v.text) then

			if v.text == "Player: " .. playerNumber then
				if button == 1 and
				playerNumber < playersInGame then
					playerNumber = playerNumber + 1
				elseif button == 2 and
				playerNumber > 1 then
					playerNumber = playerNumber - 1
				end

				v.text = "Player: " .. playerNumber
				playerChange = true

				for i, b in ipairs(players) do
					if playerNumber == b.playerNum then
						outText = b.outKey
						inText = b.inKey
					end
				end
			end

			for i, b in ipairs(players) do
				if playerNumber == b.playerNum then
					print(b.playerNum)
					if v.text == "Out: " .. b.outKey then
						setOutKey = true
					elseif v.text == "In: " .. b.inKey then
						setInKey = true
					end
				end
			end

			if v.text == "Exit" then
				gamestate = "mainMenu"
			end
		end
	end

	if playerChange == true then
		for i, v in ipairs(controls) do
			if v.buttonNum == 1 then
				v.text = "Out: " .. outText
			elseif v.buttonNum == 2 then
				v.text = "In: " .. inText
			end
		end
	end
end

function controls.keypressed(button)

	if button == "escape" then
		gamestate = "mainMenu"
	end

	for i, v in ipairs(controls) do

		for i, b in ipairs(players) do
			if setOutKey == true and
			v.text == "Out: " .. b.outKey then
				v.text = "Out: " .. button
				b.outKey = button
				setOutKey = false
			elseif setInKey == true and
			v.text == "In: " .. b.inKey then
				v.text = "In: " .. button
				b.inKey = button
				setInKey = false
			end
		end
	end
end

function controls.draw()
	love.graphics.setFont(controlsFont)
	for i, v in ipairs(controls) do
		love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.print(v.text, v.x, v.y)
	end
end