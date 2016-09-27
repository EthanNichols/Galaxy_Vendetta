
objects = {}

createObjectTimer = 0
createNewObject = 50

objectsCreated = 0

function objects.load()

end

function objects.update(dt)

	--Change the time for how much time it takes to spawn an object
	createObjectTimer = createObjectTimer + 1

	--Set a random rotation point on a random ring
	local rotation = math.floor(math.random() * 360)
	local ring = math.floor(math.random() * 3 + 1)
	local radius = ring * (love.graphics.getHeight() / 7)

	--Set the center of all the rings to the center of the screen
	local centerX = love.graphics.getWidth() / 2
	local centerY = love.graphics.getHeight() / 2

	--Set the X and Y position of the object on the one of the rings
	local x = radius * math.sin(math.rad(rotation)) + centerX
	local y = radius * math.cos(math.rad(rotation)) + centerY

	--Randomly give the object and effect
	effect = math.floor(math.random() * 5 + 1)

	--Test for the random effect and set the actual effect of the object
	if effect <= 2 then effect = "speed"
	elseif effect >= 4 then effect = "maxSpeed"
	elseif effect == 3 then effect = "stop"
	end

	if createObjectTimer >= createNewObject then
		table.insert(objects,
					{objectNum = objectsCreated,
					x = x,
					y = y,
					ring = ring,
					radius = radius,
					rotation = rotation,
					despawnTimer = 500,
					exists = true,
					effect = effect})

		createObjectTimer = 0
		objectsCreated = objectsCreated + 1
	end

	for i, v in ipairs(objects) do
		v.despawnTimer = v.despawnTimer - 1

		if v.despawnTimer <= 0 then
			v.exists = false
		end
	end

	objects.collide()
end

function objects.collide()
	for i, v in ipairs(players) do
		for i, b in ipairs(objects) do
			if v.rotation + math.abs(b.ring - 5) >= b.rotation and
			v.rotation <= b.rotation and
			v.ring == b.ring and
			b.exists == true and
			v.radiusChange == 0 then
				if b.effect == "speed" then
					v.speed = v.speed + 1
				elseif b.effect == "maxSpeed" then
					v.speed = v.speed + .2
					v.maxSpeed = v.maxSpeed + .2
				elseif b.effect == "stop" then
					v.speed = -.1
				end
				b.exists = false
			end
		end
	end
end

function objects.reset()
	while objectsCreated > 0 do
		objects[objectsCreated] = nil
		objectsCreated = objectsCreated - 1
	end
end

function objects.draw()
	for i, v in ipairs(objects) do
		if v.exists == true then
			if v.effect == "maxSpeed" then
				love.graphics.setColor(0, 0, 255)
			elseif v.effect == "speed" then
				love.graphics.setColor(0, 255, 0)
			elseif v.effect == "stop" then
				love.graphics.setColor(255, 0, 0)
			end
			love.graphics.circle("fill", v.x, v.y, 5, 10)
		end
	end
end
