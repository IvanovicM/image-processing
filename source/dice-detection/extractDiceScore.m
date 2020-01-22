function [blueNumbers, redNumbers] = extractDiceScore(I)
    [eb, cb] = extractDice(I, 'blue');    
    [er, cr] = extractDice(I, 'red');

    blueNumbers = getDiceNumbers(I, eb, cb);
    redNumbers = getDiceNumbers(I, er, cr);
    
    % plotComponents(I, er, cr, eb, cb);
end