function [redNumbers, blueNumbers] = extractDiceScores(I, num) 
    [er, cr] = extractDice(I, 'red');
    [eb, cb] = extractDice(I, 'blue');

    redNumbers = getDiceNumbers(I, er, cr);
    blueNumbers = getDiceNumbers(I, eb, cb);

    % plotComponents(I, er, ct, eb, cb);
end