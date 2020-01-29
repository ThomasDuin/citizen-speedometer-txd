AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, carName)
    currentCar = currentVehicle
end)

AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat, carName)
    currentCar = 0
end)

currentCar = 0

isSpeedometerShowing = false
currentSpeed = 0
deductRev = 1045220557
currentRev = 0
currentGear = 1

CreateThread(function()
	while true do
		Wait(0)
        displayText(0.025, 0.65, 0.25, 0.45, "speed: " .. currentSpeed, 255, 255, 255, 255)
		RequestStreamedTxd("default")
		while not HasStreamedTxdLoaded("default") do
			Wait(0)
			displayText(0.025, 0.65, 0.25, 0.45, "NOT LOADED1", 255, 255, 255, 255)
		end

        if currentCar > 0 then
            local txdBack = GetTextureFromStreamedTxd("default", "back")
            local txdBackTacho = GetTextureFromStreamedTxd("default", "back_tacho")

            local txdPin = GetTextureFromStreamedTxd("default", "pin")
            currentSpeed = math.floor(GetCarSpeed(currentCar, _s) * 5 * 1.25)
            currentRev = GetVehicleEngineRevs(currentCar)
            if currentRev ~= false then currentRev = math.floor(((currentRev - deductRev) / 100000) * 1.4) else currentRev = 0 end

            DrawSprite(txdBack, 0.75, 0.87, 0.15, 0.15, 0, 255, 255, 255, 255)
            DrawSprite(txdBackTacho, 0.90, 0.87, 0.15, 0.15, 0, 255, 255, 255, 255)

            DrawSprite(txdPin, 0.75, 0.87, 0.15, 0.15, ToFloat(currentSpeed), 255, 255, 255, 255)
            DrawSprite(txdPin, 0.90, 0.87, 0.15, 0.15, ToFloat(currentRev), 255, 255, 255, 255)
        end
	end
end)