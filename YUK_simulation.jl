function yuk_treatment(X1, X2)
    mass = 100 - 0.8*X1 - (1-0.005*X2)*X2
    cost = X1^2/20 + 1.5*X2

    return mass, cost
end