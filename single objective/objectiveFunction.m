function logIntensity = objectiveFunction(nodeParams)

trussCoords = getCoordsFromParams(nodeParams);
intensity = getIntensity(trussCoords);
logIntensity = log(intensity);
