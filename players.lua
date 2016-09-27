
players = {}

local playingPlayers = 0
local winner = -1

function players.load(playerAmount)

	players.reset()

	playingPlayers = playerAmount

	--Local variable for the amount of players created
	local player = 0

	while player < playerAmount do

		local r = math.floor(math.random() * 155 + 100)
		local g = math.floor(math.random() * 155 + 100)
		local b = math.floor(math.random() * 155 + 100)

		--Local variables for the position of the player(s)
		local x = love.graphics.getWidth() / 2
		local y = love.graphics.getHeight() / 2
		local rotation = (360 / playerAmount) * player
		local radius = love.graphics.getHeight() / 7

		--Set the player number for each player
		player = player + 1

		--Put information into a player table
		table.insert(players, 
					{playerNum = player,
					x = x,
					y = y,
					r = r,
					g = g,
					b = b,
					radius = radius,
					radiusChange = 0;
					rotation = rotation,
					fillType = "fill",
					ring = 1,
					direction = 1,
					speed = 1,
					maxSpeed = 1,})
	end
end

function players.update(dt)

	--Get the X and Y positions for the center of the screen
	local centerX = love.graphics.getWidth() / 2
	local centerY = love.graphics.getHeight() / 2

	--Get information about the players
	for i, v in ipairs(players) do

		--Test to see if the player is still in the round
		if v.fillType == "fill" then

			--Move the player around the circle based on speed
			v.rotation = v.rotation + (v.speed / v.ring)

			--Check to see if the player has gone a full circle
			--Reset the player's rotation so that there is less data to keep
			if v.rotation >= 360 then
				v.rotation = v.rotation - 360
			end

			local radiusChangeSpeed = 10

			if v.radiusChange < 0 then
				v.radius = v.radius + radiusChangeSpeed
				v.radiusChange = v.radiusChange + radiusChangeSpeed
			elseif v.radiusChange > 0 then
				v.radius = v.radius - radiusChangeSpeed
				v.radiusChange = v.radiusChange - radiusChangeSpeed
			end

			if v.radiusChange < 6 and
			v.radiusChange > -6 and
			v.radiusChange ~= 0 then
				v.radiusChange = 0
				v.radius = v.ring * (love.graphics.getHeight() / 7)
			end

			--Set the X and Y position of the players with respect to the rotation
			v.x = v.radius * math.sin(math.rad(v.rotation)) + centerX
			v.y = v.radius * math.cos(math.rad(v.rotation)) + centerY

			--Test if the speed of the player is lower or higher than their max speed
			--Increase / decrease the players speed until it's equal to the max speed
			if v.speed > v.maxSpeed then
				v.speed = v.speed - .01
			elseif v.speed < v.maxSpeed then
				v.speed = v.speed + .01
			end
		end
	end

	players.collide()

	players.win()
end

function players.collide()
	for i, v in ipairs(players) do
		for i, b in ipairs(players) do
			if v.playerNum ~= b.playerNum then
				if v.rotation + 5 > b.rotation and
				v.rotation < b.rotation and
				v.fillType == b.fillType and
				v.ring == b.ring and
				v.radiusChange == 0 and
				b.radiusChange == 0 then
					b.fillType = "line"
					b.speed = 0
				end
			end
		end
	end
end

function players.win()

	local playersLost = 0
	local lastPlayer = 0

	for i, v in ipairs(players) do
		if v.fillType == "line" then
			playersLost = playersLost + 1
		else
			lastPlayer = v.playerNum
		end
	end

	if playersLost == playingPlayers - 1 then
		winner = lastPlayer

		players.load(playingPlayers)
	end
end

function players.keypressed(button)

	--Get information about the players
	for i, v in ipairs(players) do
		--Test for which keyboard button was pressed
		--Test for one player to move, rather than all of them
		--Move the players in the direction determined by the ring they're on
		if button == "z" and
		v.playerNum == 1 and
		v.radiusChange == 0 and
		v.ring ~= 3 then
			v.ring = v.ring + v.direction
			v.radiusChange = (love.graphics.getHeight() / 7) * -v.direction
		elseif button == "x" and
		v.playerNum == 1 and
		v.radiusChange == 0 and
		v.ring ~= 1 then
			v.ring = v.ring - v.direction
			v.radiusChange = (love.graphics.getHeight() / 7) * v.direction
		end
	end
end

function players.reset()
	if players[1] ~= nil then
		while playingPlayers >= 0 do
			players[playingPlayers] = nil
			playingPlayers = playingPlayers - 1
		end
	end

	objects.reset()
end

function players.draw()

	--Get information about the players
	for i, v in ipairs(players) do

		--Set the color of the player
		--Draw the player
		love.graphics.setColor(v.r, v.g, v.b)
		love.graphics.circle(v.fillType, v.x, v.y, 10)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.print("Player " .. winner .. " won last round!")
end