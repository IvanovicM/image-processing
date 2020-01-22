function [blueNumbers, redNumbers] = extract_dice_score(I)
    [eb, cb] = extract_dice(I, 'blue');    
    [er, cr] = extract_dice(I, 'red');

    blueNumbers = get_dice_numbers(I, eb, cb);
    redNumbers = get_dice_numbers(I, er, cr);
    
    % plotComponents(I, er, cr, eb, cb);
end