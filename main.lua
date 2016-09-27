require "players"
require "objects"
require "mainMenu"
require "gameMenu"
require "options"

gamestate = "mainMenu"

function love.load()

	--Randomly generate a seed for the game
	math.randomseed(os.time())

	--Load functions
	options.load()
	mainMenu.load()
	gameMenu.load()
	players.load(0)
	objects.load()
end

function love.update(dt)

	--Test the gamestate
	--Update the functions that need to be updated under the respective gamestate
	if gamestate == "game" then
		players.update(dt)
		objects.update(dt)
	elseif gamestate == "mainMenu" then
		mainMenu.update(dt)
	elseif gamestate == "gameMenu" then
		gameMenu.update(dt)
	elseif gamestate == "options" then
		options.update(dt)
	end
end

function love.wheelmoved(x, y)

end

function love.mousepressed(x, y, button)

	--Test the gamestate
	--Send mouse information to the respective functions
	if gamestate == "mainMenu" then
		mainMenu.mousepressed(x, y, button)
	elseif gamestate == "gameMenu" then
		gameMenu.mousepressed(x, y, button)
	elseif gamestate == "options" then
		options.mousepressed(x, y, button)
	end
end

function love.keypressed(button)
	--Test if the escape buttons has been pressed
	--exit the game
	if button == "escape" then
		if gamestate == "mainMenu" then
			exit()
		elseif gamestate == "game" then
			gamestate = "gameMenu"
		end
	end

	--Send keyboard information to the functions
	players.keypressed(button)
end

function love.draw()
	--Set the color of the circles for the map.
	--Draw all of the circles
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 10, 10)
	love.graphics.circle("line", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, love.graphics.getHeight() / 7)
	love.graphics.circle("line", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, (love.graphics.getHeight() / 7) * 2)
	love.graphics.circle("line", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, (love.graphics.getHeight() / 7) * 3)

	--Test the gamestate
	--Draw the functions that need to be drawn for the respective gamestate
	if gamestate == "mainMenu" then
		mainMenu.draw()
	elseif gamestate == "game" then
		players.draw()
		objects.draw()
	elseif gamestate == "gameMenu" then
		gameMenu.draw()
	elseif gamestate == "options" then
		options.draw()
	end
end

function exit()
	--This functions only purpose is to quit the game
	love.event.quit()
end

--C:\Users\Ethan Nichols\AppData\Roaming\LOVE\Testing